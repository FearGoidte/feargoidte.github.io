---

title: Previously known as ‘coming up next!’
subtitle:
date: 2016-06-16 08:18 BST
image: /images/2016-06-16-previously-known-as-coming-up-next.svg
meta_image: /images/2016-06-16-previously-known-as-coming-up-next.png
width: 640
height: 480
tags: prev, next, Middleman
description: Sequentially linking web documents, a simple mark-up and styling example with some wooly logical thinking.

---

<blockquote>
<footer>The opening line of <cite>One Way or Another</cite> by Nigel Harrison and Debbie Harry</footer>
One way or another, I’m gonna find ya’
</blockquote>

## Background

The [`next` and `prev` `rel` link attributes](http://www.w3.org/TR/html5/links.html#sequential-link-types) are most useful for documents that fall into a nice narrative sequence such as the chapters in a book. However, they also make a popular linear navigation aid for chronologically ordered articles such as blogs—which is the example that I am using here.

## Which where? When what?

In determining the order of *next* and *previous* there is little to recommend either choice, but I am following the convention that <dfn>next</dfn> is newer and <dfn>previous</dfn> is older. Also that *previous* comes first in the document and displays left, as in going back through a book or back along a line of text and that *next* comes after and displays right as in moving forward through a book or along a line of text.

## Mark-up

Next and previous links are marked-up in an un-ordered list and use the `rel` and `accesskey` attributes. An additional link to a list of all the documents in the sequence is given in between the `next` and `prev` links:

``` xml
<div role="navigation" class="page-navigation">
	  <ul>
			<li><a href="older-document.xhtml" rel="prev" accesskey="p" title="Previous article: Title of older document">Title of older document</a></li>
			<li><a href="archives.xhtml">All documents</a></li>
			<li><a href="newer-document.xhtml" title="Next article: Title of newer document" rel="next" accesskey="n">Title of newer document</a></li>
	  </ul>
</div><!-- End role=navigation -->
```

The access key attribute values follow the convention [SAK2014: Standard Access Keys 2014](https://www.standardaccesskeys.com/SAK2014/)

The title attribute is set and explicitly states whether the link is *next* or *previous*. This is for non-visual browsers but also if you were to hide the text of the link and use only a symbol instead, it could describe the link via a tooltip.

In both the first and last documents of a sequence, there will only be one link (either *previous* **or** *next*—depending on your logic).

It could be considered that a list element is overkill. Whilst I do not subscribe to the radical *no item* list agendum ([The <code>ul</code> element on <abbr title="World Wide Web Consortium">W.3.C.</abbr>’s <abbr title="HyperText Markup Language">H.T.M.L.</abbr>5 Recommendation](http://www.w3.org/TR/html5/grouping-content.html#the-ul-element")), I am existentially comfortable with the notion that a list of one item is nevertheless a list. It may have dwindled down from a mighty tally; be an unlimited catalogue in initial, singular, or embryonic form; or it might just be a list of things that encompasses but one thing.

### Generating in a Middleman static blog

I use the following code to generate the above mark-up in a middleman static website (I’m presupposing that you have the [`middleman-blog`](https://github.com/middleman/middleman-blog) extension):

``` eruby
<% if current_article.previous_article || current_article.next_article # if any links %>
<div role="navigation" class="post-navigation>
	<ol">
<% end # if any links %>
	<% prev_article = current_article.previous_article %>
		<% if prev_article %>
		<li><%= link_to prev_article.title, prev_article.url, title: "Previous article: #{prev_article.title}", rel: 'prev', accesskey: 'p' %></li>
		<% end # if prev article %>
		<li><a href="<%= url_for "/archives.xhtml" %>">All articles</a></li>
		<% next_article = current_article.next_article %>
		<% if next_article %>
		<li><%= link_to next_article.title, next_article.url, title: "Next article: #{next_article.title}", rel: 'next', accesskey: 'n' %></li>
		<% end # if next article %>
<% if current_article.previous_article || current_article.next_article # if any links %>
	</ol>
</div><!--End post navigation-->
<% end # if any links %>
```

## Visual and print styling

### Visual

``` css
@charset utf-8;

body {
	line-height : 1.4;
	padding : 0 1.4em
}

.page-navigation {
	position : relative
}

.page-navigation a {
	width : 33%
}

.page-navigation a,
.page-navigation a[rel=next]::after,
.page-navigation a[rel=prev]::before {
	position : absolute;
	top : 0
}

.page-navigation li,
.page-navigation ul {
	display : inline
}

.page-navigation a[rel=next] {
	right : 0%;
	text-align : right
}

.page-navigation a[rel=prev] {
	left : 0
}

.page-navigation a:not([rel=next],[rel=prev]) {
	left : 33%;
	text-align : center
}

.page-navigation a[rel=next]::after {
	content : " ☞";
	right : -1.4em
}

.page-navigation a[rel=prev]::before {
	content : "☜ ";
	left : -1.4em
}
```

View an [example of the screen styling and mark-up on Codepen](http://codepen.io/FearGoidte/details/eprEpO/)

### Print

Navigation serves no purpose in a printed version of the document so for the print stylesheet add:

``` css
.page-navigation {
	display : none
}
```