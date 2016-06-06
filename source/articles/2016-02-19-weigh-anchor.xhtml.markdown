---

title: Weigh anchor
subtitle: Styling links
date: 2016-02-19 09:00 GMT
tags: CSS, links, selectors, rel
description: >
  The web, and Wikipedia is a prime example, is a multitude of documents linked together. It does lots of other things, but mostly it’s links and documents. This is an abrupt note on stylesheet selectors for links and pseudo-conventions for styling them.

---

The selectors below, make use of attribute selectors with wildcards. Descriptions of these can be found at [6.3. Attribute selectors—<abbr title="World Wide Web Consortium" class="initialism">W.3.C.</abbr>’s Selectors Level 3](https://www.w3.org/TR/css3-selectors/#attribute-selectors).

## Identifying links

### Types

Links could be divided into the following broad types (and currently are being, by me):

* <dfn>internal</dfn> to the page,
* <dfn>local</dfn> to another part of the website,
* <dfn>e-mail</dfn> addresses,
* <dfn>downloadable resources</dfn> (internal or external), and
* <dfn>external</dfn> to another location on the Internet.

#### Ascertaining the broad link type

##### Internal to the page

Search for any link element (`a`) with an `href` attribute that begins with “#”:

``` css
a[href^='#']
```

##### External and local

The way to distinguishing between external and local links depends on how your website is configured: whether you are using absolute links, relative links, or a mixture of both.

###### Absolute links

For absolute links, (assuming your server is “example.com”) the following selector will identify your local links:

``` css
[href*='example.com']
```

I have omitted the `http` since a page might be accessed over `http` or `https`. The `*` wildcard signifies that you are looking for an attribute that contains the quoted value (`'example.com'`).


###### Relative links

For relative links, the following will select external links:

``` css
a[href^='http']
```

###### Mixed absolute and relative links

For a mixture of absolute and relative links (which is the most likely scenario) and again assuming that your server is “example.com”, the following selector will select all external links:

``` css
a[href^='http']:not([href*='example.com'])
```

This is also the most fool-resistant approach. It searches for all links with `href` attributes that begin with “http” but don’t contain “example.com”.

Please note however that these approaches are not idiot-proof. For instance, you could still link to an internal document fragment using an absolute reference and the selector your mark-up matches will be the local one rather than the internal one.

##### E-mail links

Unless you’re playing silly-buggers with contact forms or some esoteric obfuscation, e-mail inks can be easily selected using:

``` css
a[href^='mailto:']
```

##### Downloadable resources

For downloadable resources you need to target the file extension such as for *Portable Document Format* files:

``` css
a[href$='.pdf']
```

### The `rel` attribute

<abbr title="Hypertext Mark-up Language" class="initialism">H.T.M.L.</abbr>5 allows other types to be defined using the `rel` attribute([4.8.4 Link types—<abbr title="Hypertext Mark-up Language" class="initialism">H.T.M.L.</abbr>5](https://www.w3.org/TR/html5/links.html#linkTypes)).

Some of these are not for action by the website user such as `rel="stylesheet"` but the following are often worth highlighting visually:

* [`author`](https://www.w3.org/TR/html5/links.html#link-type-author),
* [`help`](https://www.w3.org/TR/html5/links.html#link-type-help),
* [`next`](https://www.w3.org/TR/html5/links.html#link-type-next),
* [`prev`](https://www.w3.org/TR/html5/links.html#link-type-prev), and
* [`tag`](https://www.w3.org/TR/html5/links.html#link-type-tag).

To select these links:

``` css
a:[rel~=value]
```

Where “value” is one of the possible `rel` values above. The tilde above (~) allows `rel` to have multiple space separated values where one of them matches your value.

### States

Links can be in the following states (ordered by <abbr title="Cascading Style Sheets" class="initialism">C.S.S.</abbr> specificity:

* *Unvisited*, a link your user-agent doesn’t know or remember that you’ve visited;
* *Visited*, a link your user-agent knows or doesn’t remember you’ve visited;
* *Hover*—on mouse interfaces—, a link the pointer is hovering over; and
* *Active*, a link that is in the process of being followed.

If you’re styling all the above states, the selectors should be in the same order:

``` css
a:link
…
a:visited
…
a:hover
…
a:active
```

For a brief, yet more informative discussion of the order of link state selectors, see: [Link Specificity on Eric Meyer’s homepage](http://meyerweb.com/eric/css/link-specificity.html).

## Visual styling

### Link types

#### Internal

Immediately followed by the [section sign](https://en.wikipedia.org/wiki/Section_sign). There is no convention for an internal page link, but if there was one (and there should be) it should be the *section sign*. A convention that no one else abides by is no convention, unless … you screw your eyes real tight and wish it so.

#### Local

A plain link, no adornment.

#### E-mail

Immediately followed by an envelope icon which is in no way anachronistic to someone like me who insists on “*e-mail*”.

#### Downloadable resources

If you use routinely included particular kinds of downloadable files it is a good idea to indicate them with an icon immediately following the link. Regardless you should at least include the file extension as this will be transparent to all users.

#### External

Immediately followed by the usual external link [arrow out of box icon](https://commons.m.wikimedia.org/wiki/File:Icon_External_Link.svg).

### General styling notes

#### Colours

The convention is that links are *underlined* and that unvisited links are of a blueish hue and that visited links are of a purplish hue. Those have been the default colours since the web began and are familiar to users of [DuckDuckGo](https://duckduckgo.com), [Google](https://www.google.co.uk), and [Wikipedia](https://en.wikipedia.org/wiki/Main_Page) amongst innumerable others. If you want people to learn a new colour scheme, just for your site … interesting.

#### Icons

It is best not to use icons to highlight the [states](#states) since they can change whilst a user is on the page (`:hover`) and the document will need to reflow to accommodate them.

If you use icons for link types, try to make them small and unobtrusive. If you’re using unicode glyphs or `&font-face` with [Font Awesome](https://fortawesome.github.io/Font-Awesome/), [IcoMoon](https://icomoon.io/) <abbr lang="la" title="et cetera">&amp;c.</abbr> or similar try to ensure that the colour of the icon matches the link state—just to emphasize that the icon refers to that link rather than other adjacent text.