
describe Chgen::Markdown do
    # let(:dummy_class) { Class.new { include Chgen::Markdown } }
    let(:wrong_yaml) { "not a yaml: not a yaml: not a yaml" }
    let(:empty_yaml) { "" }
    let(:no_title_yaml) { "hello: world" }
    # let(:data) { "not a yaml" }

    describe '#parse' do
        it "should parse an existing file" do
            File.stub(:exists?).and_return(false)
            expect { subject.parse_file("whatever") }.to raise_error("The file must exist to analize")
        end
        it "should parse a YAML file" do
            File.stub(:exists?).and_return(true)
            File.stub(:open).with("filename") { StringIO.new(wrong_yaml) }
            expect { subject.parse_file("filename") }.to raise_error("Error loading the YAML file")
        end
        it "should works Ok with an empty yaml" do
            File.stub(:exists?).and_return(true)
            File.stub(:open).with("filename") { StringIO.new(empty_yaml) }
            expect { subject.parse_file("filename") }.not_to raise_error
        end
        it "should works Ok with not title in yaml" do
            File.stub(:exists?).and_return(true)
            File.stub(:open).with("filename") { StringIO.new(no_title_yaml) }
            expect { subject.parse_file("filename") }.not_to raise_error
        end
    end

    # TODO describe parse
end
