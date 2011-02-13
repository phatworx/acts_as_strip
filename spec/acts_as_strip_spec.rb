# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ActiveRecord::ActsAsStrip do
  describe Dummy do
    before { @dummy = Dummy.new }
    subject { @dummy }

    context "when fields empty" do
      specify { should be_valid }

      describe :field1 do
        subject { @dummy.field1 }
        it { should be_blank }
      end

      describe :field2 do
        subject { @dummy.field2 }
        it { should be_blank }
      end
    end

    context "when field1 and field2 filled with \" TEST \"" do
      before do
        @dummy.field1 = " TEST "
        @dummy.field2 = " TEST "
        @dummy.valid?
      end

      describe :field1 do
        subject { @dummy.field1 }
        it { should == "TEST" }
      end

      describe :field2 do
        subject { @dummy.field2 }
        it { should == "TEST" }
      end
    end
  end
end