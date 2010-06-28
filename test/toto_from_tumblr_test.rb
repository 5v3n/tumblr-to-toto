# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'toto_from_tumblr'

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
    puts xml_part
    assert("No xml part extracted...", xml_part)
  end
end
