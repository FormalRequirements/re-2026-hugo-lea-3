#!/usr/bin/env ruby
require 'csv'
require 'fileutils'

# Configuration
DATA_FILE = 'data/requirements.csv'
OUTPUT_DIR = 'docs/generated'

# Ensure output directory exists
FileUtils.mkdir_p(OUTPUT_DIR)

# Data structure to hold grouped requirements
# Structure: { Book => { Section => [Requirements] } }
requirements_by_book = Hash.new { |h, k| h[k] = Hash.new { |h2, k2| h2[k2] = [] } }

# Read CSV
CSV.foreach(DATA_FILE, headers: true) do |row|
  next if row['ID'].nil? || row['ID'].strip.empty?
  
  book = row['Book']&.strip || 'Unassigned'
  section = row['Section']&.strip || 'General'
  
  requirements_by_book[book][section] << row
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
        
        f.puts "[[#{id}]]"
        f.puts ".#{id}"
        f.puts "****"
        f.puts "*Description:* #{desc}"
        f.puts "+"
        f.puts "*Refers To:* <<#{refers}>>" unless refers.nil? || refers.empty?
        f.puts "*Priority:* #{prio} | *Status:* #{status}"
        f.puts "****"
        f.puts
      end
    end
    puts "Generated #{filename}"
  end
end
