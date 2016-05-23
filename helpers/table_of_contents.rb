def table_of_contents(page)
  if config.markdown_engine == :redcarpet && config.markdown[:with_toc_data]
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML_TOC,
                                       fenced_code_blocks: true,
                                       xhtml: true)
    file = ::File.read(page.source_file)
    tocpre = '<nav><h2>Table of contents</h2>'
    tocpost = '</nav>'
    # ignore YAML frontmatter
    file = file.gsub(/^(---\s*\n.*?\n?)^(---\s*$\n?)/m, '')
    file = file.gsub(' & ', ' &amp; ')
    # Switch to ordered lists
    toc = renderer.render(file)
    toc = toc.sub('<ul>', '<ol property="dcterms:tableofContents">')
    toc = toc.gsub('<ul>', '<ol>')
    toc = toc.gsub('</ul>', '</ol>')
    tocpre + toc + tocpost unless toc.empty?
  end # End check for Redcarpet and toc_data
end
