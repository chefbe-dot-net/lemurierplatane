require 'webapp_test'
class WelcomeTest < WebAppTest

  def test_root
    visit('/')
    assert page.has_content?("Fran")
    assert page.has_content?("Nederlands")
    assert page.has_content?("English")
  end

  def test_english
    visit('/en')
    assert page.has_content?("Welcome")

    visit('/en/')
    assert page.has_content?("Welcome")

    visit('/en/index')
    assert page.has_content?("Welcome")
  end

  def test_french
    visit('/fr')
    assert page.has_content?("Bienvenue")

    visit('/fr/')
    assert page.has_content?("Bienvenue")

    visit('/fr/index')
    assert page.has_content?("Bienvenue")
  end

  def test_dutch
    visit('/nl')
    assert page.has_content?("Welkom")

    visit('/nl/')
    assert page.has_content?("Welkom")

    visit('/nl/index')
    assert page.has_content?("Welkom")
  end

end
