# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'toto_from_tumblr'


class TotoFromTumblrTest < Test::Unit::TestCase
  FILENAME = File.join(File.dirname(__FILE__),'tumblrExamples', '449450161.html')
  EXPECTED_OLD_URL = "http://5v3n.com/post/449450161/new-book-about-workplace-culture-rework"

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
    assert("No xml part extracted...", xml_part)
    end
  def test_to_toto
    converter = TotoFromTumblr.new(FILENAME)
    toto = converter.to_toto
    assert("No post body extratced! ", toto.body)
    assert("No post date extratced! ", toto.date)
    assert("No post slug extratced! ", toto.slug)
    assert("No post title extratced! ", toto.title)
    assert("No post tag(s) extracted!", toto.tags)
  end
  def test_extract_old_url
    converter = TotoFromTumblr.new(FILENAME)
    article = converter.to_toto
    assert("No old url extracted!", article.old_url)
    assert("Wrong old URL extracted. Expected #{EXPECTED_OLD_URL}, but was #{article.old_url}", article.old_url == EXPECTED_OLD_URL)
    puts article.to_s
  end
#  def test_to_file
#    converter = TotoFromTumblr.new(FILENAME)
#    converter.to_file
#    flunk "add assertions!"
#  end
  def test_from_dir
    converter = TotoFromTumblr.new(FILENAME)
    converter.from_dir("./test/tumblrExamples")
    flunk "add assertions!"
  end

end
