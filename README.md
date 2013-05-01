LetterBomb
==========

Emails are pretty dangerous - inspect your mailer templates from the safety of your browser.

Install
-------

Add to your `Gemfile`:

```ruby
gem 'letter_bomb', group: :development
```

and `bundle` away.

Usage
-----

Mount the engine in your `routes.rb`:

```ruby
mount LetterBomb::Engine, at: '/letter_bomb'
```

and hit `/letter_bomb` for a list of previews.

Previews can be defined anywhere within `app/mailers` suffixed with `preview`, i.e. `app/mailers/user_mailer_preview.rb` or `app/mailers/user_mailer/preview.rb`.
Preview methods names are arbitrary so long as they return a `Mail` object.

```ruby
class UserMailer::Preview < LetterBomb::Preview

  def welcome
    UserMailer.welcome(User.last)
  end

end
```

Preview methods are wrapped in a transaction that will be rolled back, so it's safe to create test data.
One approach is to load your factory_girl factories and use those:

```ruby
class UserMailer::Preview < LetterBomb::Preview

  has_factory_girl

  def welcome
    user = FactoryGirl.create(:user)
    UserMailer.welcome(user)
  end

end
```

Alternatives
------------

Also check out 37signals [mail_view](https://github.com/37signals/mail_view), which much inspiration was taken from.
Differences: no automatic reloading of preview classes, no transactional previews, need to mount individual mailers.
