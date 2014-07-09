
require 'fileutils'

describe Chgen::Yaml do
    include FakeFS::SpecHelpers
    describe '#create_yaml' do
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

    context "synhronicing" do
        let(:path) { "/path/to/sync" }
        let(:filename) { "/path/to/sync/filename.yaml" }
        let(:filename_no_yaml) { "/path/to/sync/filename.png" }
        let(:yaml) { "---\nyaml_url: yaml_url\nmd_url: md_url\nTitle: Cheat Sheet title\n"}
        let(:yaml_no_yaml_url) { "---\nfirst: 'without params'"}
        let(:yaml_no_md_url) { "---\nyaml_url: yaml_url\n"}
        let(:yaml_no_title) { "---\nyaml_url: yaml_url\nmd_url: md_url\n"}
        before do
            FileUtils.mkdir_p(path)
        end

        describe '#sync_file' do
            it "should path exists" do
                expect {
                    subject.sync_file("path/incorrect")
                }.to raise_exception("The path does not exist")
            end
            it "should to have .yaml extension" do
                FileUtils.touch(filename_no_yaml)
                expect {
                    subject.sync_file(filename_no_yaml)
                }.to raise_error("File extension must be .yaml")
            end
            it "should has a yaml_url" do
                File.write filename, yaml_no_yaml_url
                expect {
                    subject.sync_file(filename)
                }.to raise_exception("Cheat Sheet without yaml_url")
            end
            it "should has a md_url" do
                File.write filename, yaml_no_md_url
                expect {
                    subject.sync_file(filename)
                }.to raise_exception("Cheat Sheet without md_url")
            end
            it "should has a Title" do
                File.write filename, yaml_no_title
                expect {
                    subject.sync_file(filename)
                }.to raise_exception("Cheat Sheet without Title")
            end
            it "should works OK" do
                File.write filename, yaml
                Gist.should_receive(:gist).and_return(nil)
                expect {
                    subject.sync_file(filename)
                }.not_to raise_exception
            end
        end
    end

end
