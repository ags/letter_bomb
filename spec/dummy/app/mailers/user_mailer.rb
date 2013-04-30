class UserMailer < ActionMailer::Base
  default to: 'foo@example.com',
          from: 'bar@example.com'

  def welcome(var)
    @var = var
    mail(subject: 'welcome to the show!') 
  end
end

class UserMailer::Preview < LetterBomb::Preview
  def welcome
    user = User.create!(name: 'john')
    UserMailer.welcome(user.name)
  end
end

class UserMailer::PreviewAgaian < LetterBomb::Preview
  def foo
  end
end
