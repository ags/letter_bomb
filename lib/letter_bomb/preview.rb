module LetterBomb
  class Preview
    class << self
      def previews
        preview_filenames.map { |filename| class_from_filename(filename) }
      end

      def mailer_actions
        public_instance_methods(false).map(&:to_s).sort
      end

      def preview_action(mailer_action)
        mail = nil
        ActiveRecord::Base.transaction do
          mail = new.send(mailer_action)
          raise ActiveRecord::Rollback
        end
        mail
      end

      private

      def preview_filenames
        Dir.glob(preview_directory + "/**/*preview.rb")
      end

      def preview_directory
        Rails.application.root.join("app/mailers").to_s
      end

      def class_from_filename(filename)
        # app/mailers/module/class.rb => module/class.rb => module/class => Module::Class
        lchomp(filename, preview_directory).chomp(".rb").camelize.constantize
      end

      def lchomp(target, removable)
        target.to_s.reverse.chomp(removable.to_s.reverse).reverse
      end
    end
  end
end
