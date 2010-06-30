# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'toto_from_tumblr'
require 'cgi'

class TotoFromTumblrTest < Test::Unit::TestCase
  FILENAME = File.join(File.dirname(__FILE__),'tumblrExamples', '373863542.html')
  def test_initialize
    converter = TotoFromTumblr.new(FILENAME)
    assert("Init failed...", converter)
  end
  def test_load_file
    converter = TotoFromTumblr.new(FILENAME)
    assert("Nothing loaded...", converter.file_content)
  end
  def test_extract_xml_part
    converter = TotoFromTumblr.new(FILENAME)
    xml_part = converter.xml_part
    
    post = xml_part.search('//post')
    post_title = xml_part.search('//post').search('regular-title').children
    post_body = xml_part.search('//post').search('regular-body').children
    post_tags = xml_part.search('//post').search('tag')

    assert("Nothing extracted at all...", xml_part)
    assert("No post extratced!", post)
    assert("No post body extratced! ", post_body)
    assert("No post title extratced! ", post_title)
    assert("No post tag(s) extracted!", post_tags)
  end
  def test_to_toto
    converter = TotoFromTumblr.new(FILENAME)
    toto = converter.to_toto
    puts toto.inspect
    puts toto
  end

end
