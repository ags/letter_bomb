require 'spec_helper'

describe LetterBomb::Preview do

  class FooPreview < LetterBomb::Preview
    def good
      User.create!(name: 'bob')
      'result of good'
    end

    def bad; end

    private

    def ugly; end
  end

  describe ".previews" do
    it "returns" do
      LetterBomb::Preview.previews.should include FooPreview
    end
  end

  describe ".mailer_actions" do
    it "returns an alphabetized list of public instance methods" do
      FooPreview.mailer_actions.should == ['bad', 'good']
    end
  end

  describe ".preview_action" do
    it "wraps a call to the given method in a transaction" do
      expect do
        FooPreview.preview_action(:good)
      end.to_not change { User.count }
    end

    it "returns the result of the called method" do
      FooPreview.preview_action(:good).should == 'result of good'
    end
  end

  describe ".has_factory_girl" do
    it "requires FactoryGirl on preview initialization" do
      class FactoryPreview < LetterBomb::Preview; has_factory_girl; end

      expect do
        FactoryPreview.new
      end.to change { !!defined?(FactoryGirl) }.to(true)
    end
  end

end
