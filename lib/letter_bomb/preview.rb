module LetterBomb
  class Preview

    def self.previews
      subclasses
    end

    def self.mailer_actions
      new.public_methods(false).map(&:to_s).sort
    end

    def self.preview_action(mailer_action)
      mail = nil
      ActiveRecord::Base.transaction do
        mail = new.send(mailer_action)
        raise ActiveRecord::Rollback
      end
      mail
    end

    def self.has_factory_girl
      @@factory_girl = true
    end

    def initialize
      if defined?(@@factory_girl) && !defined?(FactoryGirl)
        require 'factory_girl'
        FactoryGirl.find_definitions
      end
    end

  end
end
