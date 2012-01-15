require 'case'
class LangTest < Case

  def test_default_language
    get('/')
    assert_equal "fr", body[/lang="(.*)"/, 1]
  end

  def test_english
    get('/en')
    assert_equal "en", body[/lang="(.*)"/, 1]
    get('/en/')
    assert_equal "en", body[/lang="(.*)"/, 1]
  end

  def test_french
    get('/fr')
    assert_equal "fr", body[/lang="(.*)"/, 1]
    get('/fr/')
    assert_equal "fr", body[/lang="(.*)"/, 1]
  end

  def test_dutch
    get('/nl')
    assert_equal "nl", body[/lang="(.*)"/, 1]
    get('/nl/')
    assert_equal "nl", body[/lang="(.*)"/, 1]
  end

end
