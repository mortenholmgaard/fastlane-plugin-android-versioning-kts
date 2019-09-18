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

    it "should return version code from build.gradle" do
      expect(execute_lane_test).to eq("22")
    end
  end
end
