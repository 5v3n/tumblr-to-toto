# To change this template, choose Tools | Templates
# and open the template in the editor.

class TotoArticle
  attr_accessor :title, :body, :tags, :slug, :date
  def initialize(title="", date="", body="", tags=Array.new, slug="" )
    @title = title
    @body = body
    @tags = tags
    @slug = slug
    @date = date
  end
  def to_s
    toto_post = ""
    toto_post << "title: #{@title}\n"
    toto_post << "date: #{@date}\n" unless @date==""
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
end
