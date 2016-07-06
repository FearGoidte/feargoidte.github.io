---

title: In brief … abbreviations
subtitle: The long way to saying something quickly
date: 2016-06-18 09:06 BST
image: /images/2016-06-18-in-brief-abbreviations.svg
thumbnail:
  url: /images/2016-06-18-in-brief-abbreviations.png
  height: 555
  width: 640
tags: abbr, acronym, contraction, clipping, initialism
description: How to use and abuse these linguist amputees.

---

Abbreviations are shortcuts that have arisen as writers try to spend more time thinking about the words to come and less time writing down the words that they already have in mind. This is a usage and styling guide for abbreviations, acronyms, contractions, clippings, and initialisms in web documents and includes some code examples.

Where possible, abbreviations should be avoided due to their propensity towards jargon and their limited shelf life. For example, unless specificity is necessary, use “mark-up” instead of “<abbr title="eXtensible Hypertext Mark-up Language" class="initialism">X.H.T.M.L.</abbr>”.

As a general rule, words should be written as they would be pronounced. Mark-up can’t be used inside the `title` element or inside attributes, so the formatting you use in those circumstances should be unambiguous.

Since my adoption of the Gregorian Calendar, I’ve blogged on this subject twice before. Nine years ago I referenced the following quote:

<blockquote>
<footer>‘Roger’ commenting on <cite><a href="http://web.archive.org/web/20060326005449/http://www.huddledmasses.org/2004/10/27/sick-of-semantics/">Sick of Semantics</a></cite> on Huddledmasses.org (<a href="https://archive.org">archive.org</a> link)</footer>
Semantic markup is silly. I see the same terms commonly defined and that by logical extension is foolish. If you don’t know what <abbr title="Really Simply Syndiation" class="initialism">R.S.S.</abbr> means, for instance, having it explained to you as Really Simply Syndiation means <em>nothing</em>. If you already have an <abbr title="Really Simply Syndiation" class="initialism">R.S.S.</abbr> reader, meaning you actually care about <abbr title="Really Simply Syndiation" class="initialism">R.S.S.</abbr>, then you don’t need it explained.
</blockquote>

This raises a number of a issues:

* visual browsers are not the only devices for which mark-up is designed, it is also used by speech and braille readers as well as web crawlers for search engines. `abbr` is not just a hook to attach an explanative `title` attribute, but also to make it clear that what it contains is not a pronounceable word;
* recognition; the abbreviation may be common currency at the moment but obscure at a later date. It may be familiar in the United Kingdom but unusual in Australia. Abbreviations are not the exclusive preserve of technical terms;
* the same collection of capital letters could stand for one thing in one context and something else in another: <dfn>A.A.</dfn> for *Alcoholics Anonymous*, or for *The Automobile Association*;
* whilst you might make your abbreviations clear at the beginning of a document or a series of documents, that data could be reused through syndication excerpts, or just cut and pasting, and the abbreviations stripped of their context, meaning, and intended pronunciation;
* the title attribute of `abbr` is also potentially useful for search engines and other robotic user agents where the individual words that comprise an initialism or acronym might be of interest on their own to collect references; and
* translation, the title attribute provides something to translate that is not dependent on formatting.

## Clippings and contractions

Contractions are made by omitting the middle letters of a word, such as Dr for Doctor.

British English follows formal French usage where a full stop only follows clippings, where some of the letters are ‘clipped’ off from a word towards the end as in the abbreviation for abbreviation: “<abbr title="abbreviation">abbr.</abbr>”.

Both of these should be marked-up using `abbr` tags including the relevant title in every instance.

## Initialisms &amp; acronyms

Initialisms are a group of, *usually*, initial letters used as an abbreviation for a name or expression. In initialisms, each letter is pronounced separately, in acronyms the initial letters form a pronounceable word.

<cite><abbr title="eXtensible Hypertext Mark-up Language" class="initialism">X.H.T.M.L.</abbr>5</cite> has abandoned the distinction between initialisms (`abbr`) and acronyms (`acronym`), so there is no purpose to formatting them differently. At least this clears up the confusion of abbreviations such as <abbr title="Frequently Asked Questions" class="initialism">F.A.Q.</abbr> which some people treat as an acronym and others as an initialism.

It used to be the convention that since each letter of an initialism or acronym represented an abbreviated word, each letter would be followed by a full stop to indicate the clipped letters.

This convention has fallen into abeyance (elsewhere) on the dubious grounds that the result looks fussy and that the fact that the letters are in uppercase should be sufficient to indicate that they form an initialism or acronym.

Loathe as I am to use uppercase for formatting, I do not want to totally rule it out. Properly peppering initialism and acronyms with full stops makes it clear and unambiguous what they are to all user agents without them having to have prior knowledge of them.

The first instance of an acronym or initialism should be followed by it being written out in full: Irish Republican Army (<dfn>I.R.A.</dfn>). Any instance with an adjacent definition should be contained within a `dfn` element but should not be wrapped in an `abbr`; all other instances should be contained *within* the `abbr` element with the appropriate `title` attribute.

### Latinate

Although obvious when visually represented to an English speaker they become more obscure to translation software and speech readers especially when accounting for the options when formatting them (<abbr lang="la" title="exempli gratia" class="initialism">e.g.</abbr> “ie”, “i.e.”, “i. e.”).

To my mind, the most sensible approach is to mark them up as `abbr` with the `title` containing the English translation, so: `<abbr title="that is">i.e.</abbr>`. This also alleviates the confusion people have between the differing uses of <abbr xml:lang="la" title="exempli gratia">e.g.</abbr> and <abbr xml:lang="la" title="id est">i.e.</abbr>.

However, due to my personal misfortune in having gone to one of *those* schools, I prefer to use Latin in the *title* and mark-up the element as being in Latin (`xml:lang="la"`).

The three most commonly used latinate initialisms are:

* <abbr lang="la" title="exempli gratia" class="initialism">e.g.</abbr> (`<abbr lang="la" title="exempli gratia" class="initialism">e.g.</abbr>`)
* <abbr lang="la" title="et cetera">&amp;c.</abbr> (`<abbr lang="la" title="et cetera">&c.</abbr>`)
* <abbr lang="la" title="id est" class="initialism">i.e.</abbr> (`<abbr lang="la" title="id est" class="initialism">i.e.</abbr>`)

Style guides often recommend that these these initialisms should be followed by a comma, personally I think that a fullstop abutting a comma is visually confusing. It also creates issues of comprehension when the initialism is followed by a list, the comma can imply that the initialism is part of the list. Therefore though they should be preceded by punctuation (bracket, semi colon, comma, <abbr lang="la" title="et cetera">&amp;c.</abbr>) they should not be immediately followed by any.

### Names

Wikipedia has a list of [literary personæ](https://en.wikipedia.org/wiki/List_of_literary_initials) known, primarily, by the initials of their first and middle name(s) with their surname in full. In formal or polite documents people are also often referred to in this manner as well as in lists of names such as registers.

Individual initials must be separated by fullstops otherwise it is ambiguous as to whether they constitute a word in capital letters or letters to be spelt out. It is important to use a non-breaking space between the last initial and the surname to minimise the chance of them being struck asunder by an inopportune line-break. I use a Narrow No-Break Space `&#8239;` to reduce the gap between the initials and the surname and thereby emphasis their indivisibility: J.P.&#8239;Donleavy.

**Note:** I find it advisable to use character entity references for non-standard spaces in mark-up since it is easier to identify them in the source code than if they had been simply entered directly in a document.

## Styling

I like to maintain the convention that links and only links, should be underlined. I also try to avoid abbreviations appearing in a line on their own at the end of a run of text, hence `break-before : avoid`:

``` css
abbr {
	border-bottom : none;
	break-before : avoid;
	text-decoration : none
}
```

Some fonts are excessively generous with the white-space they afford to punctuation so I *very* slightly reduce letter spacing for initialisms by assigning them a `class`. I find long runs of uppercase ‘shouty’ so, in mitigation, I reduce their font-size:

``` css
abbr.initialism {
	font-size : .9em;
	letter-spacing : -.05em
}
```