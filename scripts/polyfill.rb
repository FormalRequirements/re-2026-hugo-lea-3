
# Polyfill for File.absolute_path? (introduced in Ruby 2.7)
# Required for asciidoctor-pdf on Ruby 2.6
class File
  def self.absolute_path?(path)
    # Simple implementation for Unix-like systems
    path.start_with?('/')
  end
end unless File.respond_to?(:absolute_path?)
