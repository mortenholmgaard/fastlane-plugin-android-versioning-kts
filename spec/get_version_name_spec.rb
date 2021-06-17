require 'spec_helper'

describe Fastlane::Actions::GetVersionNameAction do
  describe "Get Version Name" do
    def execute_lane_test
      Fastlane::FastFile.new.parse("lane :test do
        get_version_name(
          app_project_dir: \"../**/app\"
        )
      end").runner.execute(:test)
    end

    def execute_demo_flavor_lane_test
      Fastlane::FastFile.new.parse("lane :test do
        get_version_name(
          app_project_dir: \"../**/app\",
          flavor: \"demo\"
        )
      end").runner.execute(:test)
    end

    def execute_qa_flavor_lane_test
      Fastlane::FastFile.new.parse("lane :test do
        get_version_name(
          app_project_dir: \"../**/app\",
          flavor: \"qa\"
        )
      end").runner.execute(:test)
    end

    it "should return version name from build.gradle.kts" do
      expect(execute_lane_test).to eq("1.0.0")
    end

    it "should return version name from build.gradle.kts (demo)" do
      expect(execute_demo_flavor_lane_test).to eq("1.2.1")
    end

    it "should return version name from build.gradle.kts (qa)" do
      expect(execute_qa_flavor_lane_test).to eq("1.1.1")
    end
  end
end
