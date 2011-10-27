require 'yaml'
require 'kramdown'
require 'epath'
require 'dialect'
require 'sinatra/base'
class WebApp < Sinatra::Base

  # PUBLIC of the web application
  PUBLIC  = Path(__FILE__).dir.dir/:public
  PAGES   = PUBLIC/:pages

  ############################################################## Configuration
  # Serve public pages from public
  set :public_folder, PUBLIC

  # A few configuration options for logging and errors
  set :logging, true
  set :raise_errors, true
  set :show_exceptions, false

  # Domain specific configuration
  set :default_lang, "fr"

  ############################################################## Routes

  get '/' do
    file, lang = decode_url("")
    text   = kramdown(file.read)
    header = kramdown((PAGES/lang/"header.md").read)
    wlang(:lang => lang, :text => text, :header => header, :template => :index)
  end

  get %r{^/(.+)} do
    file, lang = decode_url(params[:captures].first)
    menu   = kramdown((PAGES/lang/"menu.md").read)
    header = kramdown((PAGES/lang/"header.md").read)
    text   = kramdown(file.read)
    wlang(:lang => lang, :text => text, :menu => menu, :header => header, :template => :page)
  end

  ############################################################## Error handling

  # error handling
  error do
    'Sorry, an error occurred'
  end

  ############################################################## Helpers

  # Serves a given wlang file
  def wlang(ctx)
    ctx = ctx.merge(:environment => settings.environment)
    tpl = PUBLIC/:templates/"html.whtml"
    WLang::file_instantiate(tpl, ctx)
  end
  
  module Tools

    def kramdown(text)
      Kramdown::Document.new(text).to_html
    end

    def decode_url(url)
      if url.empty?
        [PAGES/'index.md', settings.default_lang]
      else
        found = PAGES/url
        found = found/:index if found.directory?
        if found.replace_extension('.md').file?
          [found.replace_extension('.md'), url.split('/').first]
        else
          not_found
        end
      end
    end

  end
  include Tools
  ############################################################## Auto start

  # start the server if ruby file executed directly
  run! if app_file == $0
end

