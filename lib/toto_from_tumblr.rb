# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'nokogiri'
require 'toto_article'

class TotoFromTumblr
  attr_accessor :file_content, :filename, :xml_part, :article
  def initialize(filename=nil)
    @filename = filename
    @file_content = ""
    if @filename 
      @file_content = load_file(@filename)
    end
  end
  # loads a file line by line & return its content
  def load_file(filename)
     File.open(filename, "r").each_line do |line|
      @file_content << line
    end
    @file_content
  end
  # extracts the xml part of the saved tumblr post & returns a nokogiri xml document
  def xml_part
    #TODO think about using nokogiri for loading the file, like:
    #doc = Nokogiri::XML::Document.parse(@file_content) 
    start_index = @file_content.index(%{<?xml version="1.0" encoding="UTF-8"?>})
    end_index = @file_content.index(%{END TUMBLR XML -->})
    @xml_part = @file_content.slice(start_index, end_index)
    xml_doc = Nokogiri::XML::Document.parse(@xml_part)
  end
  # creates a valid toto blog entry object
  def to_toto
    @xml_part = xml_part unless @xml_part #feeling dizzy reading this...
    #extracted necessary info
    post = @xml_part.search('//post').first #TODO think about... if it's ok to just take the first entry
    if post #FIXME handle npes (y-combinator?)
      title = post.search('regular-title').children.to_s
      body = CGI::unescapeHTML(post.search('regular-body').children[0].to_s)
      tags = Array.new
      post.search('tag').children.each {|tag| tags << tag.to_s }
      slug = post['slug'] 
      date = post['date']
      type = post['type']
      old_url = post['url-with-slug']
    end
    @article = TotoArticle.new(title, body, date, tags, slug, type, old_url)
  end
  def to_file(article_file_name=nil, article_file_path="./")
    self.to_toto
    date = Time.new
    path = File.join(article_file_path, date.strftime("%Y%m%d%H%M"), @article.type)
    FileUtils.makedirs(path)
    if article_file_name
      name = article_file_name
    else
        name=@article.file_name
    end
    File.open(File.join(path, name), 'w') { |file|  
      #file.makedirs(path)
      file.puts @article.to_s }
  end
  def from_dir(directory="./")
    Dir[File.join(directory, "*")].each do |file|
      converter = TotoFromTumblr.new(file)
      converter.to_file()
    end
  end


end
