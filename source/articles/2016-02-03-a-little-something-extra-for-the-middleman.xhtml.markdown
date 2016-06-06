---

title: A&#160;little something eXtra for the&#160;Middleman
date: 2016-02-03 10:00 GMT
tags: Middleman, application/xhtml+xml, Markdown, Redcarpet, XHTML, Ruby
image: /images/2016-02-03-a-little-something-extra-for-the-middleman.svg
description: >
  A short inexhaustive guide to adapting <a href="https://middlemanapp.com">Middleman 4.0.0</a> to output <abbr title="eXtensible Hypertext Mark-up Language" class="initialism">X.H.T.M.L.</abbr> rather than <abbr title="Hypertext Mark-up Language" class="initialism">H.T.M.L.</abbr>

---

*Whilst the following article might still have some use for converting an existing site, I have put together an [<abbr title="eXtensible Hypertext Mark-up Language" class="initialism">X.H.T.M.L.</abbr> Middleman template](https://github.com/FearGoidte/middleman-templates-blog-xhtml) which, in one fell swoop, sets up up everything*.

I’m not going to prattle on about which mark-up version is better. Suffice to say, I made the switch a long time ago and prefer to use <abbr title="eXtensible Hypertext Mark-up Language" class="initialism">X.H.T.M.L.</abbr>

This is based on a vanilla setup of Middleman <em>4.0.0</em> and middleman-blog with the [blog template used to initiate the Middleman skeleton project](https://middlemanapp.com/basics/blogging/). `my_test_website` is used to refer to the directory which contains the Middleman skeleton project files.

## Markdown

Since <abbr title="eXtensible Hypertext Mark-up Language" class="initialism">X.H.T.M.L.</abbr> has strict syntax you’ll want to switch your Markdown render to its <abbr title="eXtensible Hypertext Mark-up Language" class="initialism">X.H.T.M.L.</abbr> version. In the case of [Redcarpet](https://github.com/vmg/redcarpet) (the default in Middleman 4.0.0), by adding the following to `my_test_website\config.rb`:

``` ruby
# Markdown settings
set :markdown_engine, :redcarpet
set :markdown, xhtml: true
```

## Directory indices

It’s always a good idea to use ‘pretty’ <abbr title="uniform resource locator" class="initialism">U.R.L.</abbr>s which exclude file extensions since they leave us open to changing language in the future and [Cool <abbr title="uniform resource identifier">U.R.I.</abbr>s don’t change](http://www.w3.org/Provider/Style/URI.html).

Directory indices in Middleman default to `index.html` so in `my_test_website\config.rb` underneath:

``` ruby
# Activate directory indices and remove file extensions from urls
activate :directory_indexes
```

Add the line:

``` ruby
set :index_file, 'index.xhtml'
```

## Blog settings

The blog helper defaults to specifying `.html` files, so in `my_test_website\config.rb` you need to change the following settings:

``` ruby
  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"
```

To (a simple find and replace from `.html` to `.xhtml`):

``` ruby
  blog.permalink = '{year}/{month}/{day}/{title}.xhtml'
  blog.sources = '{year}-{month}-{day}-{title}.xhtml'
  blog.taglink = 'tags/{tag}.xhtml'
  blog.year_link = '{year}.xhtml'
  blog.month_link = '{year}/{month}.xhtml'
  blog.day_link = '{year}/{month}/{day}.xhtml'
  blog.tag_template = 'tag.xhtml'
  blog.calendar_template = 'calendar.xhtml'
```

The important thing is to uncomment all the lines that now contain `.xhtml`.

## Source file extensions

In the directory `my_test_website\source` files, you need to change:

* `calendar.html.erb` to `calendar.xhtml.erb`
* `index.html.erb` to `index.xhtml.erb`
* `tag.html.erb` to `tag.xhtml.erb`

As well as any other none-article\blog `.xhtml` files you want to add to source.

For any existing articles/post you need to change the extensions from `html.markdown` to `xhtml.markdown`.

Since Middleman 4.0.0.rc.2:

<blockquote>
<footer><cite><a href="https://github.com/middleman/middleman/blob/master/CHANGELOG.md#400rc2">Middleman change log</a></cite></footer>
Rather than applying layouts to all files which are not <code>.txt</code>, <code>.css</code>, <code>.js</code>, <code>.json</code>: the new behavior is to only default layouts to active for <code>.html</code>
</blockquote>

This means that in `my_test_website\config.rb` you need to replace:

``` ruby
# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }
```

with:

``` ruby
# Per-page layout changes:
page '/*.xhtml', layout: 'layout'
page '/articles/*.xhtml', layout: 'article'
```

This behaviour is set to change again soon so that the default layout will be applied to `.htm` and `.xhtml` files as well as `.html`. This will make the above two lines redundant. Middleman’s new behaviour makes the other page settings redundant as well as the line:

``` ruby
page "/feed.xml", layout: false
```

## The layout file

Open `my_test_website\source`

Delete the blank last line.

Add a trailing slash to

``` xml
    <meta name="viewport" content="width=device-width, initial-scale=1">
```

``` xml
    <meta name="viewport" content="width=device-width, initial-scale=1" />
```

Delete

``` xml
    <meta charset="utf-8" />
```

Replace:

``` xml
<!doctype html>
<html>
```

With:

``` xml
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-gb-oxendict">
```

Where `en-gb-oxendict` matches the [language code](http://www.w3.org/International/articles/language-tags/) for the language of the website.

## Envoi

If you followed the above steps, you should now have a Middleman build serving up <abbr title="eXtensible Hypertext Mark-up Language" class="initialism">X.H.T.M.L.</abbr>