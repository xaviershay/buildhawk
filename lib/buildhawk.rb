require 'optparse'
require 'erubis'
require 'json'

class Buildhawk
  def self.run
    options = {}
    optparse = OptionParser.new do|opts|
      # Set a banner, displayed at the top
      # of the help screen.
      opts.banner = "Usage: buildhawk [options]"

      # Define the options, and what they do
      options[:title] = nil
      opts.on( '-t', '--title TITLE', 'Set the title of the app' ) do |title|
        options[:title] = title
      end

      # This displays the help screen, all programs are
      # assumed to have this option.
      opts.on( '-h', '--help', 'Display this screen' ) do
        puts opts
        exit
      end
    end

    optparse.parse!

    data = `git log --pretty=format:"%h\t%s\t%N" --show-notes=buildtime | egrep "[0-9]$"`
    data = data.lines.map {|x| 
      x.split("\t") 
    }.map {|x| 
      [x[2].chomp, {:ref => x[0], :subject => x[1..-2] * "\t"}]
    }.reverse

    input = File.read(File.dirname(__FILE__) + '/template.erb')
    eruby = Erubis::Eruby.new(input)

    puts eruby.result(:data => data, :title => options[:title] || "Untitled")
  end
end
