class UserMailer < ActionMailer::Base
  default to: 'foo@example.com',
          from: 'bar@example.com'

  def welcome(var)
    @var = var
    mail(subject: 'welcome to the show!')
  end
end
