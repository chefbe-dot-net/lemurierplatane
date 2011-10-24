require 'yaml'
require 'kramdown'
require 'dialect'
require 'sinatra/base'
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

  get '/:lang/:chapter/' do
    file = _("pages/#{params[:lang]}/#{params[:chapter]}/index.md")
    serve file, params[:lang]
  end

  get '/:lang/:chapter/:page' do
    file = _("pages/#{params[:lang]}/#{params[:chapter]}/#{params[:page]}.md")
    serve file, params[:lang]
  end

  ############################################################## Error handling

  # error handling
  error do
    'Sorry, an error occurred'
  end

  ############################################################## Helpers

  # Serves a given wlang file
  def serve(file, lang = settings.default_lang)
    if File.exists?(file)
      menu = kramdown(encode(File.read(_("pages/#{lang}/menu.md"))))
      text = kramdown(encode(File.read(file)))
      tpl  = _('templates/index.whtml')
      ctx  = {
        :environment => settings.environment,
        :lang        => lang, 
        :text        => text,
        :menu        => menu
      }
      wlangtpl = WLang::template(encode(File.read(tpl)), "whtml")
      wlangtpl.source_file = tpl
      wlangtpl.instantiate ctx
    else
      not_found
    end
  end

  # Resolves `file` from the public folder
  def _(file)
    self.class._(file)
  end
  
  def kramdown(text)
    encode(Kramdown::Document.new(text).to_html)
  end

  def encode(text)
     if text.respond_to?(:force_encoding)
       text.force_encoding("UTF-8")
     else
       text
     end
  end
  
  ############################################################## Auto start

  # start the server if ruby file executed directly
  run! if app_file == $0
end

