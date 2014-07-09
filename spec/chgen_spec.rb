
require 'fileutils'

describe Chgen do
    # class DummyClass
    # end

    # before(:each) do
    #     @dummy_class = DummyClass.new
    #     @dummy_class.extend(Chgen)
    # end
    # let(:dummy_class) { Class.new { include Chgen } }
    # subject { dummy_class.new }
    # subject { Object.new.extend(Chgen) }

    describe '#create' do
        # subject { Object.new.extend(Chgen) }
        context "when not valid" do
            it "should not create an existing file" do
                File.stub(:exists?).and_return(true)
                # proc {
                #     subject.create("hola")
                # }.should raise_error
                expect {
                    subject.create('filename')
                }.to raise_error("The Cheat Sheet already exists")
                # subject.create("hola").should == true
            end
            it "should to have .yaml extension" do
                File.stub(:exists?).and_return(false)
                expect {
                    subject.create('filename.png')
                }.to raise_error("File extension must be .yaml")
            end
            it "should to gist login" do
                File.stub(:exists?).and_return(false, false)
                expect {
                    subject.create('filename.yaml')
                }.to raise_error "Is neccesarry to gist login => see gist --help"
            end
        end

    end
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
end
