#!/usr/bin/env ruby

# Configuration
OUTPUT_FILE = 'docs/generated/changelog.adoc'
REPO_DIR = '.'

def get_commits
  # Get commits in format: hash|date|author|subject
  # We limit to last 50 for this example, but could be range-based
  log = `git log -n 50 --pretty=format:"%h|%ad|%an|%s" --date=short`
  log.split("\n")
end

def parse_commit(line)
  hash, date, author, subject = line.split('|')
  
  # Conventional Commits Regex
  # type(scope)!: description
  match = subject.match(/^(\w+)(?:\(([^)]+)\))?(!?):\s+(.*)$/)
  
  if match
    {
      hash: hash,
      date: date,
      author: author,
      type: match[1],
      scope: match[2],
      breaking: match[3] == '!',
      description: match[4]
    }
  else
    # Non-conventional fallback
    {
      hash: hash,
      date: date,
      author: author,
      type: 'other',
      scope: nil,
      breaking: false,
      description: subject
    }
  end
end

commits = get_commits.map { |line| parse_commit(line) }

# Group by Type
grouped = commits.group_by { |c| c[:type] }

# Order of types to display
TYPE_ORDER = {
  'feat' => 'Features',
  'fix' => 'Bug Fixes',
  'docs' => 'Documentation',
  'style' => 'Styles',
  'refactor' => 'Code Refactoring',
  'perf' => 'Performance Improvements',
  'test' => 'Tests',
  'build' => 'Builds',
  'ci' => 'CI',
  'chore' => 'Chores',
  'revert' => 'Reverts',
  'other' => 'Other Changes'
}

File.open(OUTPUT_FILE, 'w') do |f|
  f.puts "= Changelog"
  f.puts ":toc:"
  f.puts
  f.puts "Generated from git history at #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
  f.puts
  
  TYPE_ORDER.each do |type, label|
    next unless grouped[type] && !grouped[type].empty?
    
    f.puts "== #{label}"
    f.puts
    grouped[type].each do |commit|
      scope = commit[:scope] ? "*#{commit[:scope]}:* " : ""
      breaking = commit[:breaking] ? " [BREAKING]" : ""
      f.puts "* #{commit[:date]} - #{scope}#{commit[:description]}#{breaking} ({commit[:hash]})"
    end
    f.puts
  end
end

puts "Generated #{OUTPUT_FILE}"
