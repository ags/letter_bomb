require "spec_helper"

describe LetterBomb::Preview do
  describe ".previews" do
    it "returns a list of classes within app/mailers suffixed with preview" do
      expect(LetterBomb::Preview.previews).to include(FooMailerPreview)
    end
  end

  describe ".mailer_actions" do
    it "returns an alphabetized list of public instance methods" do
      expect(FooMailerPreview.mailer_actions).to eq(['bad', 'good'])
    end
  end

  describe ".preview_action" do
    it "wraps a call to the given method in a transaction" do
      expect do
        FooMailerPreview.preview_action(:good)
      end.to_not change { User.count }
    end

    it "returns the result of the called method" do
      expect(FooMailerPreview.preview_action(:good)).to eq("result of good")
    end
  end
end
