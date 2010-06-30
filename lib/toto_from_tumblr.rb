# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'nokogiri'
require 'toto_article'

class TotoFromTumblr
  attr_accessor :file_content, :filename
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
    #doc.search('//h1') 
    start_index = @file_content.index(%{<?xml version="1.0" encoding="UTF-8"?>})
    end_index = @file_content.index(%{END TUMBLR XML -->})
    @xml_part = @file_content.slice(start_index, end_index)
    xml_doc = Nokogiri::XML::Document.parse(@xml_part)
  end
  # creates a valid toto blog entry object
  def to_toto
    @xml_part = xml_part unless @xml_part #feeling dizzy reading this...
    toto_article = TotoArticle.new
    #extracted necessary info
    post = @xml_part.search('//post')
    if post #FIXME handle npes (y-combinator?)
      toto_article.title = post.search('regular-title').children
      toto_article.body = CGI::unescapeHTML(post.search('regular-body').children[0].to_s)
      post.search('tag').children.each {|tag| toto_article.tags << tag }
      toto_article.slug = "" #TODO find out how to get the key value pairs in the xml tag!
      toto_article.date = ""
    end
    toto_article
  end


end
