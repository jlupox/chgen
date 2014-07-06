
# require 'pry'

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

    describe "create" do
        # subject { Object.new.extend(Chgen) }
        it "can not create an existing file" do
            File.stub(:exists?).and_return(true)
            # proc {
            #     subject.create("hola")
            # }.should raise_error
            expect {
                subject.create('whatever')
            }.to raise_error
            # subject.create("hola").should == true
        end
    end
end
