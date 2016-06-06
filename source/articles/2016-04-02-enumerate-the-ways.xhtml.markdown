---

title: Enumerate the ways
subtitle: Nested ordered and unordered lists with hanging markers
date: 2016-04-02 22:25 BST
image: /images/2016-04-02-enumerate-the-ways.svg
tags: generated content, lists, markers, ol, ul, ::before
description: >
  The visual formatting of the <a href="https://www.w3.org/TR/html5/grouping-content.html#the-ol-element"><code>ol</code></a> and <a href="https://www.w3.org/TR/html5/grouping-content.html#the-ul-element"><code>ul</code></a> list elements and in particular; using generated content for the markers, setting them outside the list text, and having them ‘hang’ in the margin of the parent element.

---

## Background

The styles I use are designed to produce certain outcomes and have specific limitations which might conflict with your own needs. The full stylings used here as well as list examples is available on the Codepen ([<cite>Nested ordered and unordered lists with hanging markers</cite>](http://codepen.io/FearGoidte/pen/xVXJyg)).

### Adaptability of styles

A list is <dfn>nested</dfn> when it is the direct descendent of another list as in the following stylesheet selector examples:

* `ol > li > ol` and
* `ul > li > ol`.

The number of direct-ancestor list elements a list has determines its nesting <dfn>level</dfn>.

#### Ordered lists

Ordered lists are numbered 1., 1.1, 1.1.1 <abbr lang="la" title="et cetera">&amp;c.</abbr>

These styles should able to nest ordered lists to an infinite level or at least beyond the point where the width of the numbering exceeds available screen width.

##### `reversed="reversed"`

Regrettably, at the moment, the only way I know of visually expressing the meaning of the [`reversed="reversed"`](https://www.w3.org/TR/html5/grouping-content.html#attr-ol-reversed) attribute for ordered lists depends on knowing the total number of list items and using a style to ‘count down’ from that number. I have omitted that styling since it is *not* adaptive and therefore of limited use.


#### Unordered lists

Unordered lists are formatted to have different markers for each nesting depth up to a depth of five lists. This being (excluding the first level) the most that can be expressed using the mark-up [`h1` to `h6` heading elements](https://www.w3.org/TR/html5/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements).

### Hanging and outside markers

I find it easier on the eye, and easier to comprehend, when markers are outside of the list-item text and the markers for the top level of the list are hanging in the left-hand margin (unless the text direction is right-to-left) of its parent element.

## The styles

### Margins between lists

I use a standard margin of one line between many elements including `ol` and `ul`. In the case of `line-height : 1.5` on the `body` or the `html` element this would equate to a standard vertical margin of `1.5rem`. However, for nested lists I want them to abut each other vertically:

``` css
ol,
ul {
	margin : 1.4em 0;
	padding : 0
}

ol > li > ol,
ol > li > ul,
ul > li > ol,
ul > li > ul {
	margin : 0
}
```

### Outside markers

By changing the display of `li` to table you enable the `li::before` pseudo element to have the `table-cell` display property and hang outside the list item text. On paged media it will also prevent list items from breaking across pages. `list-style : none` disables the usual user-agent display styles.

``` css
li {
	display : table;
	list-style : none
}

li::before {
	display : table-cell
}
```

### Hanging markers on top-level lists

The padding on the `body` element creates the space for the list markers of top-level lists to hang-in. I use `padding` rather than `margin` so that if a background colour is set on `body` the list marker is within the boundaries of the coloured background. The padding is set to an amount that can just about accommodate an ordered list marker up till “999” as well as a small remainder to leave space between the marker and the list text. The greater the padding the less horizontal space is available which is of particular concern for narrow screens.

If the parent element of the `ol` or `ul` is floated, it will have to have the same padding as `body` to create the same space for .

For the top level lists, their markers need to be ‘pulled’ left into the margin of their parent element. The `position : relative` of the `li` element allows the `li::before` pseudo element to be absolutely positioned. I pull the list marker left by the same length quantity as the padding above.

The markers pseudo element’s default width is only sufficient to contain the marker. I prefer the top level of ordered lists to be aligned right so I need to specify a width for the marker, as I am using `.2em` padding between the list markers and the list text so for the top-level list’s markers I specify a width equal to the above `body` padding, the left positioning and minus .`2em` to make the marker padding consistent for all levels:

``` css
body {
	padding : 0 1.9em
}

li {
	position : relative
}

li::before {
	left : -1.9em;
	width : 1.7em;
	position : absolute;
	text-align : right
}
```

### Undoing the positioning top level positioning for nested list markers

The below selectors again use `>` to ensure that they are targeting only list items that are directly descended from other list items.

The only positive styling is the `padding-right : .2em` which is equivalent to the difference between the left positioning and width values for top level list items above.

The other stylings merely reset the value since the left positioning and right are align are only used for top level lists.

``` css
li > ol > li::before,
li > ul > li::before {
	padding-right : .2em;
	position : static;
	text-align : initial;
	width : auto
}
```

### Setting counters

In their [<cite>Cascading Style Sheets Level 2 Revision 1 (<abbr title="Cascading Style Sheets" class="initialism">C.S.S.</abbr> 2.1) Specification</cite>](https://www.w3.org/TR/CSS21/) the [<abbr title="World Wide Web Consortium" class="initialism">W.3.C.</abbr> recommended resetting counters on the `ol` element](https://www.w3.org/TR/CSS21/generate.html#scope). Unfortunately, they seem to have been as perplexed by their counter rules as everyone else. Reseting counters on the `ol` element means that *an ordered list which is the descendent of a sibling element of a previous ordered list will behave as a continuation of the previous list*. Quite a mouthful; suffice to say, reset counters on the `first-child` of an ordered list.

It is necessary to specify “counter” for top level ordered lists and then “counters” for nested ordered lists to be able to display a properly numbered ordered list within an unordered list.

Since I am using full stops to punctuate the numbers in nested ordered list markers they can become quite wide and have too much space for my taste (as with initialisms). I constrict them with a small amount of negative `letter-spacing`.

``` css
ol > li:first-child {
	counter-reset : item
}

ol > li::before {
	content : counter(item) ". ";
	counter-increment : item;
	letter-spacing : -.025em
}

ol > li > ol > li::before {
	content : counters(item, ".") ". "
}
```

## Unordered lists

Again, I am using `>` to ensure that lists are at a descendent level in relation to another unordered list:

``` css
ul > li::before {
	content : "➢"
}

ul > li > ul > li::before {
	content : "✽"
}

ul > li > ul > li > ul > li::before {
	content : "✦"
}

ul > li > ul > li > ul > li > ul > li::before {
	content : "✯"
}

ul > li > ul > li > ul > li > ul > li > ul > li::before {
	content : "✤"
}
```

### Unsetting styles

To remove the above generated styles for ordered and unordered styles:

``` css
.no-markers > li::before {
	display : none
}

.no-markers > li:first-child {
	counter-reset : none
}
```

The `no-markers` class is for illustrative purposes.

## All styles

I like to verbosely annotate my styles and then strip those comments (as well as any whitespace) before uploading them. The following styles are therefore replete with comments that echo the above article:

``` css
body {
	padding : 0 1.9em
}

ol,
ul {
	margin : 1.4em 0;
	padding : 0
}

ol > li > ol,
ol > li > ul,
ul > li > ol,
ul > li > ul {
	margin : 0 /* Remove margins between lists nested within other lists */
}

li {
	display : table /* Needed to enable “table-cell” display on “li::before” */;
	list-style : none /* Remove automatic markers */;
	position : relative /* This allows the top–nesting-level of lists to have their markers absolutely positioned into the margin of their parent element */
}

li::before {
	display : table-cell /* Means that the marker is placed outside of item text */;
	left : -1.4em /* For top level only, equal to the horizontal padding on the body element minus the same “.2em” as the padding on nested list items below */;
	width : 1.2em /* For top level only, creates space for list items up to “999” and enables “text-align : right” */;
	position : absolute;
	text-align : right /* For top level only, my personal preference for the variable width list numbers within the top level of an ordered list */
}

ol > li:first-child {
	counter-reset : item
}

ol > li::before {
	content : counter(item) ". ";
	counter-increment : item;
	letter-spacing : -.025em
}

ol > li > ol > li::before {
	content : counters(item, ".") ". " /* It is necessary to specify ‘counter’ for top level ordered lists and then ‘counters’ for nested ordered lists to be able to display a properly numbered ordered list within an unordered list */
}

li > ol > li::before,
li > ul > li::before {
	padding-right : .2em;
	position : static /* Undo the positioning for top level items */;
	text-align : initial;
	width : auto
}

ul > li::before {
	content : "➢"
}

ul > li > ul > li::before {
	content : "✽"
}

ul > li > ul > li > ul > li::before {
	content : "✦"
}

ul > li > ul > li > ul > li > ul > li::before {
	content : "✯"
}

ul > li > ul > li > ul > li > ul > li > ul > li::before {
	content : "✤"
}

.no-markers > li::before {
	display : none
}

.no-markers > li:first-child {
	counter-reset : none
}
```