module LetterBomb
  class MailersController < ApplicationController
    def index
      @mailers = LetterBomb::Preview.previews
    end

    def show
      mailer_class = params[:mailer_class]
      mailer_action = params[:mailer_action]
      @mail = mailer_class.constantize.preview_action(mailer_action)
    end
  end
end
