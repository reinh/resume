#!/usr/bin/ruby1.8
# A Sinatra app for displaying one's resume in multiple formats

require 'rubygems'
require 'sinatra'
require 'less'
require 'rdiscount'
require 'maruku'

get '/' do
   title = "Dan Mayer's Resume"
   resume = RDiscount.new(resume_data, :smart).to_html
   erubis :index, :locals => { :title => title, :resume => resume, :formats => true }
end

get '/style.css' do
   content_type 'text/css', :charset => 'utf-8'
   less :style
end

get '/latex' do
  content_type 'application/x-latex'
  doc = Maruku.new(resume_data)
  doc.to_latex_document
end

get '/markdown' do
  content_type 'application/markdown'
  resume_data
end

def resume_data
  File.read("data/resume.md")
end
