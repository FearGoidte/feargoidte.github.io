---

title: “Tag!”, Middleman is it
subtitle: Adding descriptions to tags
date: 2016-02-19 10:30 GMT
image: /images/2016-02-19-tag-middleman-is-it.svg
meta_image: /images/2016-02-19-tag-middleman-is-it.png
width: 640
height: 422
tags: Middleman, eRuby, YAML, XHTML, blogging, rel
description: >
  Doing more with the <a href="https://middlemanapp.com/basics/blogging/">middleman-blog</a> extension’s tags. Adding descriptions, names with inline mark-up, and the tag <code>rel</code> attribute. This is assuming that you have setup a blank blog as per <dfn><a href="/2016/02/02/would-have-worn-gloves#nav_main">If I’d known there’d be so much typing, I would have worn gloves</a></dfn>.

---

## Displaying tags alphabetically

Especially with a long list of tags, and extra-especially when accessing them through voice or touch; it would be nice to have an idea of where you are in the list. Alphabetically ordering the tags gives someone and idea of where they are and the direction to go in to find a particular tag (up/back forward/behind).

The current ruby code displays tags in articles (`current_article.tags`) in the order in which they are entered in the front matter of that post, and for archives (`blog.tags`) *I think* they are displayed in the order in which they first appear in an article:

``` eruby
<% blog.tags.each do |tag, articles| %>
```

To re-order them alphabetically:

``` eruby
<% blog.tags.sort{ |a, b| a.to_s.downcase <=> b.to_s.downcase }.each do |tag, articles| %>
```

The `to_s.downcase` changes the tags to lowercase for sorting purposes, otherwise they are ordered by uppercase, and then by lowercase as two separate but adjacent logical lists.

## Descriptions and names with inline mark-up

These are instructions to optionally create descriptions for tags as well as names with inline mark-up that can be used for link text and as titles on tag archives.

### <abbr title="YAML Ain’t Markup Language" class="initialism">YAML</abbr> data
Create a new `.yaml` file to hold the data: `/data/tags.yaml`.

Add entries to the file in the following format:

``` yaml
XHTML:
  name: <abbr title="eXtensible Hypertext Mark-up Language" class="initialism">X.H.T.M.L.</abbr>
  description: >
    Extensible Hypertext Markup Language is part of the family of <abbr title="eXtensible Markup Language" class="initialism">X.M.L.</abbr> markup languages. It mirrors or extends versions of Hypertext Markup Language (<dfn class="initialism">H.T.M.L.</dfn>).
application/xhtml+xml:
  name: <code>application/xhtml+xml</code>
  description: >
    The <dfn>application/xhtml+xml</dfn> media type (<a href="http://www.rfc-editor.org/rfc/rfc3236.txt">RFC3236</a>) is the primary media type for <abbr title="eXtensible Hypertext Mark-up Language" class="initialism">X.H.T.M.L.</abbr> Family documents.
```

Where the first line “`XHTML:`” matches the tag as referenced in your article’s front matter and “`name: <abbr title="eXtensible Hypertext Mark-up Language" class="initialism">X.H.T.M.L.</abbr>`” matches the name of the tag as you would like it displayed within the body of your documents (links and titles).

### Article headers

Code for listing the tags in the article header:

``` eruby
<% if current_article.tags %>
<dl>
	<dt>Tagged with</dt>
	<% current_article.tags.sort{ |a,b| a.to_s.downcase <=> b.to_s.downcase }.each do |tag| %>
		<% if data.tags[tag] %>
	<dd><a href="<%= url_for tag_path(tag) %>" rel="tag"><%= data.tags[tag].name %></a></dd>
		<% else %>
	<dd><%= link_to tag, tag_path(tag), rel: 'tag' %></dd>
		<% end %>
	<% end %>
</dl>
<% end %>
```

For the article headers, the tag links have `rel="tag"` attributes. Read more about this attribute at [4.8.4.12 Link type “tag”—<cite><abbr title="Hypertext Mark-up Language" class="initialism">H.T.M.L.</abbr>5
A vocabulary and associated <abbr title="application programming interface" class="initialism">A.P.I.</abbr>s for <abbr title="Hypertext Mark-up Language" class="initialism">H.T.M.L.</abbr> and <abbr title="eXtensible Hypertext Mark-up Language" class="initialism">X.H.T.M.L.</abbr></cite>](https://www.w3.org/TR/html5/links.html#link-type-tag).

### Article summaries

Code for listing the tags in article summaries:

``` eruby
<% if article.tags %>
<footer>
<dl>
	<dt>Tagged with</dt>
	<% article.tags.sort{ |a,b| a.to_s.downcase <=> b.to_s.downcase }.each do |tag| %>
		<% if data.tags[tag] %>
			<% if current_page.url == tag_path(tag) %>
	<dd><%= data.tags[tag].name %></dd>
		   <% else %>
	<dd><a href="<%= url_for tag_path(tag) %>"><%= data.tags[tag].name %></a></dd>
			<% end %>
		<% else %>
			<% if current_page.url == tag_path(tag) %>
	<dd><%= tag %></dd>
		   <% else %>
	<dd><%= link_to tag, tag_path(tag) %></dd>
			<% end %>
		<% end %>
<% end %>
</dl>
</footer>
<% end %>
```
### Main archive

Code for listing links to the tag archives on a main archive page:

``` eruby
<ol>
<% blog.tags.sort{ |a,b| a.to_s.downcase   <=> b.to_s.downcase   }.each do |tag, articles| %>
	<% if data.tags[tag] %>
	<li><a href="<%= url_for tag_path(tag) %>"><%= data.tags[tag].name %></a> (<%= spell_out(articles.size) %>)—<%= data.tags[tag].description %></li>
	<% else %>
	<li><%= link_to "#{tag}", tag_path(tag) %> (<%= spell_out(articles.size) %>)</li>
	<% end %>
<% end %>
</ol>
```

The above depends on having a `\helpers\spell_out.rb` file containing:

``` eruby
def spell_out(value)
  value = value.to_i
  if value >= 0 && value < 11
    return %w(zero one two three four five six seven eight nine ten)[value]
  else
    return value
  end
end

```

### Tag archives

This code is for the generated individual tag archives (`source\tag.xhtml.erb`):

``` eruby
<% if data.tags[tagname] %>
<h1 property="dcterms:title">Articles tagged <em><%= data.tags[tagname].name %></em></h1>
<p>
<%= data.tags[tagname].description %>
</p>
<% else %>
<h1 property="dcterms:title">Articles tagged <em><%= tagname %></em></h1>
<% end %>
```

## Conclusion

A little short on exposition but contains all the necessary code.