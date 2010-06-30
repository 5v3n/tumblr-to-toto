require 'cgi'

class TotoArticle
  attr_accessor :title, :body, :tags, :slug, :date, :extension
  def initialize(title, body, date, tags=Array.new, slug=nil, file_extension="txt" )
    @title = title
    @body = body
    @tags = tags
    if slug && slug != ""
      @slug = slug
    else
      @slug = CGI::escape(@title) #TODO test, does this actually work as a url?
    end
    @date = Time.parse(date)
    @file_extension = file_extension
    @file_name = "#{@date.strftime("%Y-%m-%d")}-#{@slug}.#{@file_extension}" #TODO find aproriate conversion
  end
  def to_s
    toto_post = ""
    toto_post << "title: #{@title}\n"
    toto_post << "date: #{@date.strftime("%Y-%m-%d")}\n"
    if @tags
    toto_post << "tags: "
    @tags.each {|tag| toto_post << "#{tag}, "}
    toto_post.chop!.chop! #yeah, take this unnecessary ", "!
    toto_post << "\n"
    end
    toto_post << "slug: #{@slug}" unless @slug==""
    toto_post << "\n\n"
    toto_post << @body.to_s
  end
  def generate_date_string
    
  end
end