---

title: Reading whilst watching (and listening)
subtitle: More comprehensible subtitles
date: 2016-03-25 21:15 GMT
image: /images/2016-03-25-reading-whilst-watching-and-listening.svg
meta_image: /images/2016-03-25-reading-whilst-watching-and-listening.png
width: 640
height: 361
tags: utf-8, .srt, subtitles, SubRip
description: >
  A short note on typography for the <cite>SubRip text file format</cite> for providing subtitles for films.

---

Subtitles are generally read whilst you’re trying to simultaneously watch a film *and* listen to the voices to gauge the emotion and intention of the character or person speaking. That is a lot to ask of a partially-shaved monkey; and anything that can speed comprehension is a boon. Poor spelling, straight quotation marks, and lazy punctuation are an unnecessary burden.

I have a tendency to frequently rewatch films—though with varying degrees of attention—so for me, the fifteen minutes or half an hour it takes for me to edit the subtitles has some quality of investment. By uploading the edited subtitles to a site such as [Subscene](https://subscene.com/u/998178), others can benefit from, or be subjected to, your pernicketiness.

## Specifying encoding

You always want to use [utf-8](https://www.ietf.org/rfc/rfc3629.txt). Other than accented letters; it enables you to use curly quotes, horizontal ellipses, and varying widths of dash. The mechanism for declaring the encoding of a `.srt` file is to use the [byte-order mark](https://www.w3.org/International/questions/qa-byte-order-mark.en.php#answer).

## Conventions particular to subtitles

The only two widely-supported styling options for the text are the bold (`<b>`) and italic (`<i>`) mark-up elements. Computers tend to embolden fonts by drawing over them with bigger, thicker pen rendering ugly results so I only use italics.

Use italic to emphasis an individual word in speech where it is emphasized in the dialogue, “she said *what*?”; to indicate the dialogue is being spoken by someone off camera, out of focus, or in the background whilst another character is in the foreground and in focus; and for intertitles.

An em dash (—) indicates the beginning of a line of dialogue. If two characters’ or people’s dialogue is on the screen at the same time, each characters line is introduced with an em dash:

<pre>—Are you going to sit down?<br />
—Give me a second to take off my coat.</pre>

<aside>I usually format initialisms using intervening full-stops. This habit is hardly a popular stylist choice but for subtitles it definitely does make them easier to digest.</aside>

## Naming subtitles files

My own video players of preference, [Plex](https://plex.tv) and [V.L.C.](https://www.videolan.org/vlc/), favour a naming convention of a film title followed by the year of release in brackets (“<cite xml:lang="es">Relatos salvajes</cite> (2014)”) for a folder containing the film and subitle file similarly name with an [I.S.O. code](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) signifying the language ([Adding Local Subtitles to Your Media](https://support.plex.tv/hc/en-us/articles/200471133-Adding-Local-Subtitles-to-Your-Media)):

<pre><samp>
/Films<br />
   /Relatos salvajes (2014)<br />
      Relatos salvajes (2014).m4v<br />
      Relatos salvajes (2014).<em>en</em>.srt<br />
</samp></pre>

## Common corrections

### “I” impersonating “l”

Many subtitles contain the capital letter *I* masquerading as a lowercase *L*. On some sans-serif fonts the characters are indistinguishable (as is the number *1*) but using a serif font, they are quite dissimilar. Since this bamboozles my spellchecker, I use the following [grep](https://en.wikipedia.org/wiki/Grep) pattern (in [BBEdit](http://www.barebones.com/products/bbedit/) my text editor of choice) to identify them.

An uppercase *I* immediately preceded by a lowercase letter:

``` grep
[a-z]I
```

## <span xml:lang="fr">Fin</span>

<cite>SubRip text file format</cite> is a convention rather than a standard, hence the brevity of this note. Additional information about using the whole gamut of graphemes available in English are plentiful elsewhere and probably lurking elsewhere on this site. Happy captioning.