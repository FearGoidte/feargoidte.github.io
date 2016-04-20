xml.instruct! :xml, version: '1.0', encoding: config.encoding
xml.feed 'xmlns' => 'http://www.w3.org/2005/Atom' do
  site_url = data.settings.site.base_url + '/'
  xml.title data.settings.site.name
  xml.subtitle data.settings.site.description
  xml.id URI.join(site_url, blog.options.prefix.to_s)
  xml.link 'href' => URI.join(site_url, blog.options.prefix.to_s)
  xml.link 'href' => URI.join(site_url, current_page.path), 'rel' => 'self'
  xml.updated(blog.articles.first.date.to_time.iso8601) unless blog.articles.empty?
  xml.author { xml.name data.settings.author.name }
  blog.articles[0..5].each do |article|
    xml.entry do
      xml.title(type: 'xhtml') do
        xml.div(xmlns: 'http://www.w3.org/1999/xhtml') do |x|
          x << article.title
        end
      end
      xml.link 'rel' => 'alternate', 'href' => URI.join(site_url, article.url)
      xml.id URI.join(site_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author do
        xml.name data.settings.author.name
      end
      xml.summary(type: 'xhtml') do
        xml.div(xmlns: 'http://www.w3.org/1999/xhtml') do |x|
          x << article.data.description
        end
      end
      xml.content(type: 'xhtml') do
        xml.div(xmlns: 'http://www.w3.org/1999/xhtml') do |x|
          x << article.data.description + article.body
        end
      end
    end
  end
end
