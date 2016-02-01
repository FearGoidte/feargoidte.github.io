def table_of_contents(page) # https://gist.github.com/backflip/7446094
  if config.markdown_engine == :redcarpet && config.markdown[:with_toc_data]
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML_TOC,fenced_code_blocks: true, xhtml:true,)
    file = ::File.read(page.source_file)
    tocpre = '<nav><h2>Table of contents</h2>'
    tocpost = '</nav>'
  # ignore YAML frontmatter
    file = file.gsub(/^(---\s*\n.*?\n?)^(---\s*$\n?)/m,'')
    file = file.gsub('&','&amp;')
    file = file.gsub('"','&quot;')
    file = file.gsub("'",'&apos;')
    file = file.gsub('<','&lt;')
    file = file.gsub('>','&gt;')
    toc = renderer.render(file)
    toc = toc.sub('<ul>','<ol property="dc:tableofContents">')
    toc = toc.gsub('<ul>','<ol>')
    toc = toc.gsub('</ul>','</ol>')
    tocpre + toc + tocpost unless toc.empty?
  else
   "You’re not using Redcarpet as your Markdown processor and/or you are not using the “with_toc_data” option"
  end # End check for Redcarpet and toc_data
end