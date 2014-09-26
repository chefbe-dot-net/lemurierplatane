require 'polygon'
require 'helpers'

class App < Polygon::Base
  helpers Helpers

  get '/sitemap.xml' do
    content_type "application/xml"
    wlang :sitemap, locals: sitemap_locals, layout: false
  end

  get "/" do
    wlang :index, locals: locals('fr', nil)
  end

  get %r{^/(fr|nl|en)/?$} do |lang|
    wlang :page, locals: locals(lang, '')
  end

  get %r{^/(fr|nl|en)/(.+)$} do |lang,path|
    if locals = locals(lang, path)
      wlang :page, locals: locals
    else
      not_found
    end
  end

  def locals(lang, path)
    base   = Path(settings.doc_folder)/lang

    locals = case path
    when NilClass
      page_locals('')
    when ->(s){ s.empty? }
      page_locals(lang)
    else
      page_locals("#{lang}/#{path}")
    end

    if locals
      locals.merge! menu: (base/'menu.md').read
      locals.merge! last_update: last_update
    end
    locals
  end

  def last_update
    ['tmp/restart.txt', 'Gemfile.lock'].map(&Path).find(&:exist?).mtime.strftime("%Y-%m-%d")
  end

end
