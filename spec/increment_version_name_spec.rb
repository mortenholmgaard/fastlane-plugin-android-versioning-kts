require 'spec_helper'

describe Fastlane::Actions::IncrementVersionNameAction do
  describe 'Increment version name' do
    before do
      copy_build_fixture
    end

    def execute_lane_test
      Fastlane::FastFile.new.parse("lane :test do
        increment_version_name(
          app_project_dir: \"../**/app\"
        )
      end").runner.execute(:test)
    end

    def execute_demo_flavor_lane_option_test
      Fastlane::FastFile.new.parse("lane :test do
        increment_version_name(
          app_project_dir: \"../**/app\",
          flavor: \"demo\"
        )
      end").runner.execute(:test)
    end

    def execute_qa_flavor_lane_option_test
      Fastlane::FastFile.new.parse("lane :test do
        increment_version_name(
          app_project_dir: \"../**/app\",
          flavor: \"qa\"
        )
      end").runner.execute(:test)
    end

    it 'should return incremented version name from build.gradle.kts' do
      expect(execute_lane_test).to eq('1.0.1')
    end

    it 'should return incremented version name with minor from build.gradle.kts' do
      result = Fastlane::FastFile.new.parse("lane :test do
        increment_version_name(
          app_project_dir: \"../**/app\",
          bump_type: \"minor\"
        )
      end").runner.execute(:test)
      expect(result).to eq('1.1.0')
    end

    it 'should return incremented version name with major from build.gradle.kts' do
      result = Fastlane::FastFile.new.parse("lane :test do
        increment_version_name(
          app_project_dir: \"../**/app\",
          bump_type: \"major\"
        )
      end").runner.execute(:test)
      expect(result).to eq('2.0.0')
    end

    it 'should return incremented fixmun version name from build.gradle.kts (demo)' do
      expect(execute_demo_flavor_lane_option_test).to eq('1.2.2')
    end

    it 'should return incremented fixmun version name from build.gradle.kts (qa)' do
      expect(execute_qa_flavor_lane_option_test).to eq('1.1.2')
    end

    it 'should set VERSION_NAME shared value' do
      result = execute_lane_test
      expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::VERSION_NAME]).to eq('1.0.1')
    end

    after do
      remove_fixture
    end
  end
end
