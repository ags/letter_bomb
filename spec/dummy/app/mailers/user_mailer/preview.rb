class UserMailer::Preview < LetterBomb::Preview
  def welcome
    user = User.create!(name: 'john')
    UserMailer.welcome(user.name)
  end
end
