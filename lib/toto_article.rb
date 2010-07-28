require 'cgi'

class TotoArticle
  attr_accessor :title, :body, :tags, :slug, :date, :extension, :file_name, :type, :old_url
  # instantiate the article. Left out optional parameters are generated, e.g. <code>date</code> with the current date etc.
  def initialize(title, body, date, tags=Array.new, slug=nil, type=nil, old_url=nil, file_extension="txt" )
    @title = title
    @body = body
    @tags = tags
    if slug && slug != ""
      @slug = slug
    else
      @slug = CGI::escape(@title) #TODO test, does this actually work as an url?
    end
    @date = Time.parse(date)
    @type = type
    @old_url = old_url #valuable if you migrate your disqus comments!
    @file_extension = file_extension
    @file_name = "#{@date.strftime("%Y-%m-%d")}-#{@slug}.#{@file_extension}" 
  end
  def to_s
    toto_post = ""
    if @title.index(":") #yaml couldn't cope with ':', so we'l escape it
      post_title = @title.gsub!(":", "&#58;")
    else
      post_title = @title
    end
    toto_post << "---\n"
    toto_post << "title: #{post_title}\n"
    toto_post << "date: #{@date.strftime("%Y\/%m\/%d")}\n"
    toto_post << "tags: #{@tags.join(', ')}\n" if @tags && !@tags.empty?
    toto_post << "slug: #{@slug}\n" if @slug && @slug != ""
    toto_post << "old_url: #{@old_url}\n" if @old_url && @old_url != ""
    toto_post << "\n\n"
    toto_post << @body.to_s
  end
end
