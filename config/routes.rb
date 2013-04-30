LetterBomb::Engine.routes.draw do
  get '/', to: 'mailers#index', as: :mailers
  get '/:mailer_class/:mailer_action', to: 'mailers#show', as: :mailer
end
