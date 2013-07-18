require "forwardable"

module LetterBomb
  class Preview
    class << self
      def classes
        preview_filenames.map { |filename| class_from_filename(filename) }
      end

      def actions
        public_instance_methods(false).map(&:to_s).sort
      end

      def preview_action(action_name, options={})
        action = nil
        ActiveRecord::Base.transaction do
          mail = new.send(action_name)
          action = Action.new(action_name, mail, options)
          raise ActiveRecord::Rollback
        end
        action
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

    class Action
      extend Forwardable

      attr_reader :name, :mail, :format

      def_delegators :mail,
        :from, :to, :reply_to, :subject, :multipart?, :content_type, :charset

      def initialize(name, mail, options={})
        @name   = name
        @mail   = mail
        @format = options[:format] || default_format
      end

      def body
        return mail.body unless multipart?

        content_type = Rack::Mime.mime_type(".#{format}")
        (find_part_with_content_type(content_type) || mail.parts.first).body
      end

      def html_format?
        format == "html"
      end

      private

      def default_format
        content_type.match(/multipart|html/) ? "html" : "text"
      end

      def find_part_with_content_type(content_type)
        parts = mail.respond_to?(:all_parts) ? mail.all_parts : mail.parts
        parts.find { |part| part.content_type.match(content_type) }
      end
    end
  end
end
