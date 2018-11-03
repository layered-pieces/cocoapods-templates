require 'git'

module Pod
  class Command
    # This is an example of a cocoapods plugin adding a top-level subcommand
    # to the 'pod' command.
    #
    # You can also create subcommands of existing or new commands. Say you
    # wanted to add a subcommand to `list` to show newly deprecated pods,
    # (e.g. `pod list deprecated`), there are a few things that would need
    # to change.
    #
    # - move this file to `lib/pod/command/list/deprecated.rb` and update
    #   the class to exist in the the Pod::Command::List namespace
    # - change this class to extend from `List` instead of `Command`. This
    #   tells the plugin system that it is a subcommand of `list`.
    # - edit `lib/cocoapods_plugins.rb` to require this file
    #
    # @todo Create a PR to add your plugin to CocoaPods/cocoapods.org
    #       in the `plugins.json` file, once your plugin is released.
    #
    class Templates < Command
      self.summary = 'Cocoapods plugin to install Xcode templates from a remote source'

      self.description = <<-DESC
        Cocoapods plugin to install Xcode templates from a remote source

        https://github.com/objc-pieces/cocoapods-templates
      DESC

      self.arguments = 'URL'

      def initialize(argv)
        @url = argv.shift_argument
        @name = File.basename @url.split("/").last
        @owner = @url.split("/")[-2]
        super
      end

      def validate!
        super
        help! 'An URL is required' unless @url
        help! 'URL is invalid, expected something like https://example.com/repo.git' unless @url.start_with? "https://"
        help! 'URL is invalid, expected something like https://example.com/repo.git' unless @url.end_with? ".git"
      end

      def run
        UI.puts "Add your implementation for the cocoapods-templates plugin in #{__FILE__}"

        tmp_directory = Dir.mktmpdir
        Dir.chdir(tmp_directory) do
          UI.puts "Cloning #{@url}"
          Git.clone @url, @name

          templates = Dir["**/*.xctemplate"]

          if templates.count == 0
            UI.puts "#{@url} does not contain any Xcode templates"
          else
            UI.puts "Installing #{templates.count} template(s) to ~/Library/Developer/Xcode/Templates/File Template for #{@owner}"
            base = File.absolute_path "#{ENV["HOME"]}/Library/Developer/Xcode/Templates/File Template"

            FileUtils.mkdir_p base
            FileUtils.rm_rf "#{base}/#{@owner}"
            FileUtils.mkdir_p "#{base}/#{@owner}"

            templates.each do |path|
              FileUtils.cp_r path, "#{base}/#{@owner}"
            end

            UI.puts "Please restart Xcode for the changes to take affect"
          end
        end
      end
    end
  end
end
