---

title: Render unto me, a table of contents
subtitle: Generating a table of contents in Middleman using embedded Ruby
date: 2016-05-23 15:02 BST
image: /images/2016-05-23-render-unto-me-a-table-of-contents.svg
tags: Middleman, Markdown, eRuby, Redcarpet, XHTML
description: >
  To have an automatically generated table of contents whilst using the <a href="https://middlemanapp.com">Middleman</a> static site generator with Embedded Ruby for templates/layouts and markdown for simple formatting, I have made some modifications to a vanilla install of Middleman.

---

## Background

Please bear in mind, that I am no programmer and have merely hacked together this ugly edifice. However, since I couldn’t [DuckDuckGo](https://duckduckgo.com) a way of doing this I thought I would share my solution in case it is of use to someone else.

## Code

### Change markdown renderer to red carpet

Firstly, I am using [Redcarpet](https://github.com/vmg/redcarpet) as my markdown renderer. Installation instructions are on their site. Once it is installed, to add Redcarpet to Middleman, insert the following into Middleman’s `Gemfile`:

``` ruby
gem "redcarpet"
```

### Generate the `id` attributes for the headings

In the `config.erb` file, I made the following changes.

Switched the renderer from the default [Kramdown](http://kramdown.gettalong.org) to Redcarpet:

``` ruby
set :markdown_engine, :redcarpet
set :markdown, with_toc_data: true,
               xhtml: true
```

Create a helper file:

``` ruby
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

```

Save the above code in a new file named  and saved in the `my_test_website\helpers\table_of_contents.rb` where “`my_test_website`” is the name of your project’s directory.

### Generate the table of contents

The table of contents can then be added to a file that is processing embedded Ruby by adding the following code:

``` ruby
	<%= table_of_contents(current_page) %>
```

I tend to add this to my templates but it could also be added to an ‘article’ or ‘page’ file as long as the first of its extensions is `.erb`.

## End note

I am sure that the code above could be simplified. [*Redcarpet* has an issue rendering ampersands and other characters with its renderer](https://github.com/vmg/redcarpet/issues/529) so this code will need to be amended once that is fixed (`file = file.gsub(' & ', ' &amp; ')`).