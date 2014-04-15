class FooMailerPreview < LetterBomb::Preview
  def good
    User.create!(name: 'bob')

    Mail.new do
      text_part do
        content_type "text/plain"
        body "this is text"
      end
      html_part do
        content_type "text/html"
        body "this is html"
      end
    end
  end

  def very_good
    id = raw_params.fetch(:id) { "" }
    User.create!(name: 'bob')

    Mail.new do
      text_part do
        content_type "text/plain"
        body "this is text with an id of #{id}"
      end
      html_part do
        content_type "text/html"
        body "this is html with an id of #{id}"
      end
    end
  end

  def bad; end

  private

  def ugly; end
end
