#!/usr/bin/env ruby

# Configuration
OUTPUT_FILE = 'docs/generated/changelog.adoc'
REPO_DIR = '.'

def get_tags
  # Get tags in format: tag|date|author|subject
  # We use raw git format. Note: 'taggername' works for annotated tags. 
  # For lightweight tags, we might need a fallback or just use committer.
  # We'll use %(subject) for the message (first line of annotation or commit message).
  format = "%(refname:short)|%(creatordate:short)|%(taggername)|%(subject)"
  tags = `git tag -l --format='#{format}' --sort=-creatordate`
  tags.split("\n")
end

tags = get_tags

File.open(OUTPUT_FILE, 'w') do |f|
  # We don't output a main title here because this file is intended 
  # to be included inside the table in intro.adoc
  
  # If we want to generate the WHOLE table, we do:
  f.puts "[cols=\"1,1,2,3\", options=\"header\"]"
  f.puts "|==="
  f.puts "| Version | Date | Author | Description"
  
  tags.each do |line|
    version, date, author, subject = line.split('|')
    author = "Unknown" if author.to_s.strip.empty?
    
    # Clean up data
    version.strip!
    date.strip!
    author.strip!
    subject.strip!
    
    f.puts "| #{version} | #{date} | #{author} | #{subject}"
  end
  
  f.puts "|==="
end

puts "Generated #{OUTPUT_FILE}"
