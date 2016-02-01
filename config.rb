Time.zone = 'London'

###
# Page options, layouts, aliases and proxies
###

# Set the default layout
set :layout, 'layout'

# Per-page layout changes:
page "/*.xhtml", layout: 'layout'
page "/articles/*.xhtml", layout: 'article' # It appears that the above setting overides the article setting in the blog helper

# Ignore Icons used for folders
ignore "*Icon*"

###
# Helpers
###

# Blog
activate :blog do |blog|
  blog.permalink = '{year}/{month}/{day}/{title}.xhtml'
  blog.sources = 'articles/{year}-{month}-{day}-{title}.xhtml'
  blog.taglink = 'tags/{tag}.xhtml'
# blog.layout = 'article'
  blog.year_link = '{year}.xhtml'
  blog.month_link = '{year}/{month}.xhtml'
  blog.day_link = '{year}/{month}/{day}.xhtml'
  blog.tag_template = 'tag.xhtml'
  blog.calendar_template = 'calendar.xhtml'
  blog.new_article_template = 'blank-article'
end

# Activate directory indices and remove file extensions from urls
activate :directory_indexes
set :index_file, 'index.xhtml'

# Relative links
set :relative_links, true
activate :relative_assets, sources: '.css, .htm, .html, .xhtml'

# Markdown settings
set :markdown_engine, :redcarpet
set :markdown, input: "GFM"
set :markdown,	:fenced_code_blocks => true,
				:input => 'GFM',
			   	:layout_engine => :erb,
			   	:with_toc_data => true,
               	:xhtml => true

# Syntax highlighting support
activate :syntax, css_class: 'code_quote'

# Build-specific configuration
configure :build do
  activate :gzip, exts: '.css, .htm, .html, .js, .svg, .xhtml, .xml'
  activate :minify_html, remove_quotes: false
  # activate :minify_css
end

# Copy files to build folder after build
after_build do |builder|
  print "After_build fixes... "
  system("cp \README.markdown #{config[:build_dir]+'/README.markdown'}")
  system("cp \licence.txt #{config[:build_dir]+'/licence.txt'}")
  puts "done."
end

# Deploy to GitHub
activate :deploy do |deploy|
  deploy.build_before = true
  deploy.deploy_method = :git
  deploy.branch = 'master'
  deploy.commit_message = 'Published from build of source branch'
end