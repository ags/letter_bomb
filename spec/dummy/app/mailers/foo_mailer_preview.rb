class FooMailerPreview < LetterBomb::Preview
  def good
    User.create!(name: 'bob')
    'result of good'
  end

  def bad; end

  private

  def ugly; end
end
