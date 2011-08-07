Mondrian
========

Mondrian compiles a grid specification to well-formatted (X)HTML. It is meant to create flexible grid-based layouts from scratch without using pre-defined building blocks. The ultimate goal of Mondrian is to be a Markdown or Textile for layouts, providing human-readable and editable output. If you hate editing CSS/HTML but still want a decent looking site, Mondrian may be just what you're looking for.

Philosophy
==========

Divs
----
Mondrian views the world as a recursively nested set of `div`s. If that sounds scary, it isn't! The simplest Mondrian layout looks like this:

```
mydiv
```

This would compile into the following HTML:

```html
<div id="mydiv">
</div>
```

Nesting
-------
Mondrian uses `{ }` to signify horizontal nesting and `[ ]` to signify vertical nesting (`{ }` have horizontal nibs while `[ ]` are straight up and down).

```
mydiv {
  column1
  column2
  column3
}
```

would lay out three columns horizontally next to each other inside the parent div `mydiv`.

```
mydiv [
  row1
  row2
  row3
]
```

Note that nesting is recursive, so placing three columns inside `row2` is perfectly legal:

```
mydiv [
  row1
  row2 {
    col1
    col2
    col3
  }
  row3
]
```

A document starts out in vertical nesting, so you can imagine an invisible set of `[ ]` surrounding it.

Sizing/Specifiers
-----------------
If you leave each div 'bare' (without qualifiers) Mondrian assumes you want a div that will take up all available space given to it. To change this, you put modifiers after the div name and before the nesting bracket (if any). You can add CSS sizes or special Mondrian keywords, currently these are simply `left`, `center`, `right`, `kill`, and `keep`. The last two are discussed in the next section. CSS sizes mean 'width' when in horizontal nesting and 'height' in vertical nesting.

A typical blog layout in Mondrian might look like this:

```
header 100px
content {
  leftsidebar 100px
  posts 80% left [
    post1
    post2
    post3
  ]
}
footer 100px
```

Generation
----------

Currently, Mondrian generates XHTML for you to hand edit, with divs being labeled and randomly colorized to aid in easy visualization of your layout. The plan is to eventualy have a straightforward way to embed text to facilitate automatic template engine code.

Mondrian's limited layout may seem peculiar at first -- how do you specify margins? What about semantic concerns? All these extra divs seem too low-level, like a step backward in web design. This is how Mondrian's approach differs from previous web-design methods.

Mondrian expects the computer to do the heavy lifting, not you. Mondrian automatically 'optimizes out' shell divs used for layout purposes (such as the `content` div in the blog post above). In this process it ends up elevating content-centric divs to first-class citizens, much as the [One True Layout](http://www.positioniseverything.net/articles/onetruelayout/), [Holy Grail](http://www.alistapart.com/articles/holygrail/), or [960.gs](http://960.gs/) operate. However, those are either heavily restricted (960 pixels, that's it!) or require way too much effort and a slide rule to computer all the position hacks. With Mondrian you just specify margins as empty divs with the `kill` attribute specified, and _Mondrian just takes care of it_. It will result in automatically computed margins on the divs that touch it. If you have a shell div you'd like to keep for semantic reasons (perhaps you have some CSS selector that depends on a div not disappearing, or a div that gets filled via a JS call), simply add the `keep` attribute. Mondrian will make sure things work out OK.

Verification
------------

The advantage of Mondrian's view of a page over traditional CSS is Mondrian can verify several things about your layout. For example, it can prevent a 600px wide div from being nested inside a 500px one. It can verify that there is only one freely-sized div within a context, preventing unpredictable lengths or strange resizings of pages when switching resolutions. Mondrian catches these design problems at "compile time" and can go a long way toward creating cross-browser repeatable layouts with minimal fuss.

Getting Started
--------

You will need the [OCaml](http://caml.inria.fr/ocaml/) compiler to build Mondrian. If you use Debian/Ubuntu, try:

```bash
sudo aptitude install ocaml-base-nox ocaml-batteries-included ocaml-findlib ocaml-findlib-wizard
```

Then simply

```bash
cd parser/
make
./mondrian -m xhtml < mylayout > mysite.html
```

You can run `./mondrian --help` for further help.

Thanks
------
If you have used Mondrian to make your website, spread the word!
