require 'spec_helper'

describe LetterBomb::Preview do

  describe ".previews" do
    it "returns" do
      LetterBomb::Preview.previews.should include FooMailerPreview
    end
  end

  describe ".mailer_actions" do
    it "returns an alphabetized list of public instance methods" do
      FooMailerPreview.mailer_actions.should == ['bad', 'good']
    end
  end

  describe ".preview_action" do
    it "wraps a call to the given method in a transaction" do
      expect do
        FooMailerPreview.preview_action(:good)
      end.to_not change { User.count }
    end

    it "returns the result of the called method" do
      FooMailerPreview.preview_action(:good).should == 'result of good'
    end
  end

  describe "#lchomp" do
    it "removes a given string from the start of a target string" do
      LetterBomb::Preview.lchomp('abcd/edfg/abcd', 'abcd').should == '/edfg/abcd'
    end
    context "when the target string does not begin with the removable string" do
      it "returns the target string" do
        LetterBomb::Preview.lchomp('edfg/abcd', 'abcd').should == 'edfg/abcd'
      end
    end
    context "when the target string does not contain the removable string" do
      it "returns the target string" do
        LetterBomb::Preview.lchomp('edfg', 'abcd').should == 'edfg'
      end
    end
  end

end
