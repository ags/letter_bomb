module LetterBomb
  class Preview

    def self.previews
      load_dir = Rails.application.root.join('app/mailers').to_s
      Dir.glob(load_dir + '/**/*preview.rb').map do |filename|
        # app/mailers/module/class.rb => module/class.rb => module/class => Module::Class
        lchomp(filename, load_dir).chomp('.rb').camelize.constantize
      end
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

    def self.lchomp(base, arg)
      base.to_s.reverse.chomp(arg.to_s.reverse).reverse
    end

  end
end
