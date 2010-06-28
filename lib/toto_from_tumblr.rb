# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'nokogiri'

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
  def xml_part
    Nokogir::
    start_index = @file_content.index(%{<?xml version="1.0" encoding="UTF-8"?>})
    end_index = @file_content.index(%{END TUMBLR XML -->})
    @xml_part = @file_content.slice(start_index, end_index)
  end
  def to_toto

  end


end
