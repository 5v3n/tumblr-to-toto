# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'tumblr_to_toto'


class TumblrToTotoTest < Test::Unit::TestCase
  FILENAME = File.join(File.dirname(__FILE__),'tumblrExamples', '449450161.html')
  EXPECTED_OLD_URL = "http://5v3n.com/post/449450161/new-book-about-workplace-culture-rework"
  def test_initialize
    converter = TumblrToToto.new(FILENAME)
    assert(converter, "Init failed...")
  end
  def test_load_file
    converter = TumblrToToto.new(FILENAME)
    assert(converter.file_content, "Nothing loaded...")
  end
  def test_extract_xml_part
    converter = TumblrToToto.new(FILENAME)
    xml_part = converter.xml_part  
    assert(xml_part, "No xml part extracted...")
    end
  def test_to_toto
    converter = TumblrToToto.new(FILENAME)
    toto = converter.to_toto
    assert(toto.body, "No post body extratced! ")
    assert(toto.date, "No post date extratced! ")
    assert(toto.slug, "No post slug extratced! ")
    assert(toto.title, "No post title extratced! ")
    assert(toto.tags, "No post tag(s) extracted!")
  end
  def test_extract_old_url
    converter = TumblrToToto.new(FILENAME)
    article = converter.to_toto
    assert(article.old_url, "No old url extracted!")
    assert(article.old_url == EXPECTED_OLD_URL, "Wrong old URL extracted. Expected #{EXPECTED_OLD_URL}, but was #{article.old_url}")
   end
end