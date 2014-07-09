
require 'fileutils'

describe Chgen::Yaml do
    describe '#create_yaml' do
        include FakeFS::SpecHelpers
        before do
            # FileUtils.mkdir_p ENV['HOME']
            # FileUtils.touch ENV['HOME'] + '/.gist'
        end
        it "should parse correctly" do
            Gist.should_receive(:gist).and_return(nil)
            expect(
                subject.create_yaml("filename.yaml", "yaml_url", "md_url")
            ).to eq("## Cheat Sheet title")
        end
    end

    # describe '#sync' do
    # end
end
