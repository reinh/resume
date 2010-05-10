require 'lib/resume_gem'
require 'test/unit'

class ResumeGemTest < Test::Unit::TestCase

  def test_mission_statement
    resume = Resume.new({'mission_statement' => 'mission'})
    assert_equal "mission", resume.mission_statement
  end

  def test_contact_information
    resume = Resume.new({'contact_information' => "phone: 511-2305\nemail:test@test.com"})
    assert_equal "phone: 511-2305\nemail:test@test.com", resume.contact_information
  end

  def test_contact_information_includes_resume_url
    resume = Resume.new({'contact_information' => "phone: 511-2305\nemail:test@test.com",
                        'resume_url' => 'http://resume.com'})
    assert_match "http://resume.com", resume.contact_information
  end

  def test_text
    resume = Resume.new({})
    assert_match "Daniel Mayer", resume.text
  end

  def test_latex
    resume = Resume.new({})
    assert_match "begin{document}", resume.latex
  end

  def test_html
    resume = Resume.new({})
    assert_match "<p>", resume.html
  end

end
