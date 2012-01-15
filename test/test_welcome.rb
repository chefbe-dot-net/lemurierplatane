require 'case'
class WelcomeTest < Case

  def test_root
    get('/')
    assert_match /Fran/, body
    assert_match /Nederlands/, body
    assert_match /English/, body
  end

  def test_english
    get('/en')
    assert_match /Welcome/, body
    get('/en/')
    assert_match /Welcome/, body
    get('/en/index')
    assert_match /Welcome/, body
  end

  def test_french
    get('/fr')
    assert_match /Bienvenue/, body
    get('/fr/')
    assert_match /Bienvenue/, body
    get('/fr/index')
    assert_match /Bienvenue/, body
  end

  def test_dutch
    get('/nl')
    assert_match /Welkom/, body
    get('/nl/')
    assert_match /Welkom/, body
    get('/nl/index')
    assert_match /Welkom/, body
  end

end
