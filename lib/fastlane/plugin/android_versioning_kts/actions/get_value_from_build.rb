require 'fileutils'

module Fastlane
  module Actions
    class GetValueFromBuildAction < Action
      def self.run(params)
        app_project_dir ||= params[:app_project_dir]

        type ||= params[:type]

        case type
          when "param"
            regex = Regexp.new(/\s*(?<key>#{params[:key]}\s*=\s*)(?<left>[\'\"]?)(?<value>[a-zA-Z0-9\.\_]*)(?<right>[\'\"]?)(?<comment>.*)/)
          when "function"
            regex = Regexp.new(/\s*(?<key>#{params[:key]}\s*\(\s*)(?<left>[\'\"]?)(?<value>[a-zA-Z0-9\.\_]*)(?<right>[\'\"]?)(?<comment>.*\).*)/)
          else
            throw "#{type} is not valid type"
        end

        value = ""
        found = false
        Dir.glob("#{app_project_dir}/build.gradle.kts") do |path|
          UI.verbose("path: #{path}")
          UI.verbose("absolute_path: #{File.expand_path(path)}")
          begin
            File.open(path, 'r') do |file|
              file.each_line do |line|
                unless line.match(regex) and !found
                  next
                end
                key, left, value, right, comment = line.match(regex).captures
                break
              end
              file.close
            end
          end
        end
        return value
      end

      #####################################################
      # @!group Documentation
      #####################################################
      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :app_project_dir,
                                  env_name: "ANDROID_VERSIONING_APP_PROJECT_DIR",
                               description: "The path to the application source folder in the Android project (default: android/app)",
                                  optional: true,
                                      type: String,
                             default_value: "android/app"),
          FastlaneCore::ConfigItem.new(key: :key,
                               description: "The property key",
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :type,
                               description: "The property Type [\"function\", \"param\"])",
                                      type: String,
                             default_value: "param")

        ]
      end

      def self.authors
        ["zmunm"]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
