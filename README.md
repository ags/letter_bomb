LetterBomb
==========

Emails are pretty dangerous. Inspect your ActionMailer templates in your browser.

Install
-------

Add to your `Gemfile`:

```ruby
gem 'letter_bomb'
```

and `bundle` away.

Usage
-----

```
class UserMailer::Preview < MailPreview

  factory_girl 'spec/factories'

  def welcome
    user = FactoryGirl.create(:user)
    UserMailer.welcome(user)
  end

end
```

Your mailer class methods don't have to match your previews, but your mailers should.

Preview methods are wrapped in a transaction, so it's safe to create new data.

Hit /mailers/:mailer_name

Alternatives
------------

Also check out 37signals MailView.
