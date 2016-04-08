Time.zone = 'London'

###
# Page options, layouts, aliases and proxies
###

# Set the default layout
set :layout, 'layout'

# Ignore Icons used for folders
ignore '*Icon*'

# Ignore submodule files (currently not used)
ignore '*.git'
ignore 'stylesheets/partials/images/*'
ignore 'stylesheets/partials/sampler.xhtml'
ignore 'stylesheets/partials/readme'

###
# Helpers
###

# Blog
activate :blog do |blog|
  blog.permalink = '{year}/{month}/{day}/{title}.xhtml'
  blog.sources = 'articles/{year}-{month}-{day}-{title}.xhtml'
  blog.taglink = 'tags/{tag}.xhtml'
  blog.layout = 'article'
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
set :trailing_slash, false

# On GitHub pages, 404 page must be "404.html" or "404.md"
page '/404.html', directory_index: false
page '/google65d5e4337d3800b9.html', directory_index: false

# Relative links
set :relative_links, true
activate :relative_assets

# Markdown settings
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true,
               input: 'GFM',
               layout_engine: :erb,
               with_toc_data: true,
               xhtml: true

# Syntax highlighting support
activate :syntax, css_class: 'code-quote'

# Development-specific configuration
configure :development do
  set :https, true # Ensures consistency if also deployed over https
end

# Build-specific configuration
configure :build do
  activate :gzip
  activate :minify_html, remove_quotes: false
  activate :minify_css
end

# Copy files to build folder after build
after_build do
  print 'After_build fixes … '
  system("cp \licence.txt #{config[:build_dir] + '/licence.txt'}")
  system("cp \README.markdown #{config[:build_dir] + '/README.markdown'}")
  puts 'done.'
end

# Deploy to GitHub
activate :deploy do |deploy|
  deploy.build_before = true
  deploy.branch = 'master'
  deploy.clean = true
  deploy.commit_message = 'Published from build of source branch'
  deploy.deploy_method = :git
end
