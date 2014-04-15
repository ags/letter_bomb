require "spec_helper"

describe LetterBomb::Preview do
  describe ".classes" do
    it "returns a list of classes within app/mailers suffixed with preview" do
      expect(LetterBomb::Preview.classes).to include(FooMailerPreview)
    end
  end

  describe ".actions" do
    it "returns an alphabetized list of public instance methods" do
      expect(FooMailerPreview.actions).to eq(['bad', 'good'])
    end
  end

  describe ".preview_action" do
    it "wraps a call to the given method in a transaction" do
      expect do
        FooMailerPreview.preview_action(:good)
      end.to_not change { User.count }
    end

    it "returns a Preview::Action for the Mail object" do
      action = FooMailerPreview.preview_action(:good)

      # TODO using #send makes writing a mock expectation tricky
      expect(action.name).to eq(:good)
      expect(action).to be_a(LetterBomb::Preview::Action)
    end

    it "passes through raw params" do
      id = "awesome"
      raw_params = {id: id}
      action = FooMailerPreview.preview_action(:very_good, {raw_params: raw_params})
      expect(action.mail.text_part.body).to match(/#{id}/)
    end
  end
end
