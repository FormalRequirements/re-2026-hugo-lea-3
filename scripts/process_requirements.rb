#!/usr/bin/env ruby
require 'csv'
require 'fileutils'

# Configuration
DATA_FILE = 'data/requirements.csv'
ASSETS_DIR = 'data/assets/requirements'
OUTPUT_DIR = 'docs/generated'

# Ensure output directory exists
FileUtils.mkdir_p(OUTPUT_DIR)

# Data structure to hold grouped requirements
# Structure: { Book => { Section => [Requirements] } }
requirements_by_book = Hash.new { |h, k| h[k] = Hash.new { |h2, k2| h2[k2] = [] } }

# Validation errors
errors = []

# Read CSV and build ID->Book map
all_rows = []
id_to_book = {}

CSV.foreach(DATA_FILE, headers: true) do |row|
  next if row['ID'].nil? || row['ID'].strip.empty?
  all_rows << row
  
  book = row['Book']&.strip || 'Unassigned'
  id_to_book[row['ID']] = book
end

# Iterate for validation and grouping
all_rows.each do |row|
  book = row['Book']&.strip || 'Unassigned'
  section = row['Section']&.strip || 'General'

  # Validation: Attributes
  if row['Attached Files'] && !row['Attached Files'].strip.empty?
    files = row['Attached Files'].split(',').map(&:strip)
    files.each do |file|
      unless File.exist?(File.join(ASSETS_DIR, file))
        errors << "Requirement #{row['ID']} references missing file: #{file} (expected at #{File.join(ASSETS_DIR, file)})"
      end
    end
  end

  # Validation: Cross-book references
  if row['Refers To'] && !row['Refers To'].strip.empty?
    refers_id = row['Refers To'].strip
    refers_book = id_to_book[refers_id]
    
    if refers_book.nil?
      errors << "Requirement #{row['ID']} refers to non-existent ID #{refers_id}"
    elsif refers_book != book
      errors << "Cross-book reference violation: #{row['ID']} (#{book}) refers to #{refers_id} (#{refers_book}). References must stay within the same Book."
    end
  end

  requirements_by_book[book][section] << row
end

# Fail build if validation errors exist
unless errors.empty?
  puts "Build failed due to validation errors:"
  errors.each { |e| puts "- #{e}" }
  exit 1
end

# Generate AsciiDoc files
requirements_by_book.each do |book, sections|
  sections.each do |section, reqs|
    # Sanitize filenames
    safe_book = book.downcase.gsub(/[^a-z0-9]+/, '_')
    safe_section = section.downcase.gsub(/[^a-z0-9]+/, '_')
    filename = File.join(OUTPUT_DIR, "#{safe_book}_#{safe_section}.adoc")
    
    File.open(filename, 'w') do |f|
      f.puts "// Generated from #{DATA_FILE}"
      f.puts "// Book: #{book}, Section: #{section}"
      f.puts
      
      reqs.each do |req|
        id = req['ID']
        desc = req['Description']
        refers = req['Refers To']
        prio = req['Priority']
        status = req['Status']
        attached_files = req['Attached Files']
        
        f.puts "[[#{id}]]"
        f.puts ".#{id}"
        f.puts "****"
        f.puts "*Description:* #{desc}"
        f.puts
        
        if attached_files && !attached_files.strip.empty?
          files = attached_files.split(',').map(&:strip)
          files.each do |file|
            # AsciiDoc image path relative to book root (which is docs/)
            # We use a symlink docs/assets -> ../data/assets
            f.puts "image::assets/requirements/#{file}[#{file},300,align=\"center\"]" 
          end
          f.puts
        end

        f.puts "*Refers To:* <<#{refers}>>" unless refers.nil? || refers.empty?
        f.puts "*Priority:* #{prio} | *Status:* #{status}"
        f.puts "****"
        f.puts
      end
    end
    puts "Generated #{filename}"
  end
end
