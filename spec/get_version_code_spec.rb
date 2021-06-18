require 'spec_helper'

describe Fastlane::Actions::GetVersionCodeAction do
  describe "Get Version Code" do
    def execute_lane_test
      Fastlane::FastFile.new.parse("lane :test do
        get_version_code(
          app_project_dir: \"../**/app\"
        )
      end").runner.execute(:test)
    end

    def execute_demo_flavor_lane_test
      Fastlane::FastFile.new.parse("lane :test do
        get_version_code(
          app_project_dir: \"../**/app\",
          flavor: \"demo\"
        )
      end").runner.execute(:test)
    end

    def execute_qa_flavor_lane_test
      Fastlane::FastFile.new.parse("lane :test do
        get_version_code(
          app_project_dir: \"../**/app\",
          flavor: \"qa\"
        )
      end").runner.execute(:test)
    end

    it "should return version code from build.gradle.kts" do
      expect(execute_lane_test).to eq("12345")
    end

    it "should return version code from build.gradle.kts (demo)" do
      expect(execute_demo_flavor_lane_test).to eq("123")
    end

    it "should return version code from build.gradle.kts (qa)" do
      expect(execute_qa_flavor_lane_test).to eq("456")
    end
  end
end