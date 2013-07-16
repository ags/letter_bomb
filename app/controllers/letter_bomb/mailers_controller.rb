module LetterBomb
  class MailersController < ApplicationController

    def index
      @mailers = LetterBomb::Preview.previews
    end

    def show
      klass = params[:mailer_class]
      @action = params[:mailer_action]
      @mail = klass.constantize.preview_action(@action)

      params[:format] ||= content_type_html? ? "html" : "text"

      respond_to do |format|
        format.html {
          render layout: "letter_bomb/application"
        }

        format.text {
          render layout: "letter_bomb/application",
                 formats: [:html],
                 content_type: 'text/html'
        }
      end
    end

    private

    def content_type_html?
      @mail.content_type.match("text/html")
    end

    def body_part
      return @mail unless @mail.multipart?

      content_type = Rack::Mime.mime_type(".#{params[:format]}")
      if @mail.respond_to?(:all_parts)
        @mail.all_parts.find { |part| part.content_type.match(content_type) } || @mail.parts.first
      else
        @mail.parts.find { |part| part.content_type.match(content_type) } || @mail.parts.first
      end
    end
    helper_method :body_part

    def html_template?
      params[:format] == 'html'
    end
    helper_method :html_template?

  end
end
