require 'yaml'
require 'dialect'
require 'sinatra/base'
require 'logger'
class WebApp < Sinatra::Base

  # Root of the web application
  ROOT = File.expand_path('../../public', __FILE__)

  # Resolves `file` from the public folder
  def self._(file)
    File.join(ROOT, file)
  end

  ############################################################## Configuration
  # Serve public pages from public
  set :public_folder, ROOT

  # A few configuration options for logging and errors
  set :logging, true
  set :raise_errors, true
  set :show_exceptions, false

  # Domain specific configuration
  set :default_lang, "fr"

  ############################################################## Routes

  get '/' do
    serve 'index.yml'
  end

  get %r{/(en|fr|nl)} do |lang|
    serve 'index.yml', lang
  end

  ############################################################## Error handling

  # error handling
  error do
    'Sorry, an error occurred'
  end

  ############################################################## Helpers

  # Serves a given wlang file
  def serve(file, lang = self.class.default_lang)
    data = YAML::load(File.read(_(file)))
    tpl  = _('templates/index.whtml')
    ctx  = {
      :lang  => lang, 
      :picture => data["picture"],
      :title   => data["title"][lang],
      :text    => data["text"][lang]
    }
    WLang::file_instantiate tpl, ctx
  end

  # Resolves `file` from the public folder
  def _(file)
    self.class._(file)
  end

  ############################################################## Auto start

  # start the server if ruby file executed directly
  run! if app_file == $0
end

