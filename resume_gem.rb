require 'rubygems'
require 'maruku'
require 'rdiscount'
require 'launchy'
require 'fileutils'
require 'less'
require 'erubis'

class Resume

  def initialize(resume_data = 'resume.yml', resume_content = 'resume.md')
    @resume = resume_data.is_a?(String) ? YAML::load_file(resume_data) : resume_data
    @resume_content = resume_content.is_a?(String) ? File.read(resume_content) : resume_content
  end

  def mission_statement
    @resume['mission_statement']
  end

  def contact_information
    @resume['contact_information']
  end

  def text
    @resume_content
  end

  def latex
    doc = Maruku.new(@resume_content)
    doc.to_latex_document
  end

  def html
    title = "Dan Mayer's Resume"
    resume = RDiscount.new(@resume_content, :smart).to_html
    eruby = Erubis::Eruby.new(File.read('./views/index.erubis'))
    eruby.result(binding())    
  end

  def write_html_and_css_to_disk(root_path = './tmp')
    FileUtils.mkdir_p root_path unless File.exists?(root_path)
 
    css = Less::Engine.new(File.new("views/style.less")).to_css
    tmp_css = File.join(root_path,'style.css')
    File.open(tmp_css, 'w') {|f| f.write(css) }

    tmp_file = File.join(root_path,'index.html')
    File.open(tmp_file, 'w') {|f| f.write(self.html) }
    tmp_file
  end

  def open_html
    tmp_file = write_html_and_css_to_disk()
    Launchy::Browser.new.visit("file://"+File.expand_path(tmp_file))
  end

end
