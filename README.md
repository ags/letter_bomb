# letter_bomb [![Build Status](https://travis-ci.org/ags/letter_bomb.png?branch=master)](https://travis-ci.org/ags/letter_bomb)

Emails are pretty dangerous - inspect your mailer templates from the safety
of your browser.

## Install

Add to your `Gemfile`:

```ruby
gem "letter_bomb", group: :development
```

and `bundle` away.

## Usage

Mount the engine in your `routes.rb`:

```ruby
if Rails.env.development?
  mount LetterBomb::Engine, at: "/letter_bomb"
end
```

and hit `/letter_bomb` for a list of previews.

Previews can be defined anywhere within `app/mailers` suffixed with `preview`,
i.e. `app/mailers/user_mailer_preview.rb`.
Preview method names are arbitrary so long as they return a `Mail` object.

```ruby
class UserMailerPreview < LetterBomb::Preview
  def welcome
    WelcomeMailer.for_user(User.last)
  end
end
```

Preview methods are wrapped in an ActiveRecord transaction block that will be
rolled back after execution, so it's safe to create your own test data within
them.

## Contributors

* [ags](https://github.com/ags)
* [andrewk](https://github.com/andrewk)

## Alternatives

Also check out 37signals [mail_view](https://github.com/37signals/mail_view),
which much inspiration was taken from.
See [here](http://thatalexguy.com/posts/2013-07-18-letter-bomb.html) for more
details on the differences.
