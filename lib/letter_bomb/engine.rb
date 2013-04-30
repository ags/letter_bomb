module LetterBomb
  class Engine < ::Rails::Engine
    isolate_namespace LetterBomb

    initializer 'letterbomb.mailers.autoload' do |app|
      # TODO this is sloppy. the reason behind it is:
      # 1) to generate the list of previews, we need all subclasses.
      #    rails doesn't load them up front, so we need to do that manually.
      #
      # 2) because we load the mailers and previews up-front, we have to manually tell
      #    rails to reload each per request.
      ActionDispatch::Callbacks.before do
        Dir[File.join(app.config.root, "/app/mailers/**/*.rb")].each { |file| load(file) }
      end
    end
  end
end
