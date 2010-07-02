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
    puts toto
  end
  def test_to_file
       converter = TotoFromTumblr.new(FILENAME)
       converter.to_file
       flunk "add assertion!"
       #FIXME add assertion
  end
  def test_from_dir
     converter = TotoFromTumblr.new(FILENAME)
     converter.from_dir("./test/tumblrExamples")

  end

end
