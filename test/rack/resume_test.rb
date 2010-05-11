require 'resume'
require 'test/unit'
require 'rack/test'

set :environment, :test

class ResumeTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  #todo make tests user independant
  def test_title_matches_user
    get '/'
    assert last_response.ok?
    assert_match "<title>Dan Mayer's Resume</title>", last_response.body
  end

  def test_it_includes_a_email
    get '/'
    assert last_response.body.match(/dan@mayerdan\.com/)
  end

  def test_it_can_convert_to_latex
    get '/latex'
    assert last_response.ok?
    assert_match "begin{document}", last_response.body
  end

  def test_it_can_display_markdown
    get '/markdown'
    assert last_response.ok?
    assert_match "Daniel Mayer", last_response.body
  end

  def test_it_supports_linked_formats
    get '/'
    assert_match "HTML", last_response.body
    assert_match "LaTeX", last_response.body
    assert_match "Markdown", last_response.body
  end
  
  def test_it_displays_powered_by
    get '/'
    assert_match "powered by", last_response.body
    assert_match "Ruby Resume", last_response.body
  end

end
