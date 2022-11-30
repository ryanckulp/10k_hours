xml.instruct! :xml, version: "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title Project.current.name
    xml.description Project.current.tagline

    xml.image do
      xml.title Project.current.name
      xml.url Project.current.avatar.url
      xml.link root_url
    end

    Post.published.order('created_at DESC').each do |post|
      xml.item do
        xml.title post.title
        xml.description post.meta_description
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post_url(post.slug)
      end
    end
  end
end
