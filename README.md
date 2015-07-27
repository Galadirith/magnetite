# Magnetite

Magnetite is a thin wrapper to a
[lean distribution](https://github.com/Galadirith/MathJax/tree/release-2.4.0-electron)
of MathJax built for use in
[Electron](https://github.com/atom/electron) apps and
[Atom](https://github.com/atom/atom) packages. It facilitates the loading of
the MathJax environment and converting a LaTeX equation string to a HTML
rendered equation.

## Installation

```bash
$ npm install --save magnetite
```

## Usage

To convert a DOM element that containts LaTeX equation strings to HTML
equations:

```javascript
// load magnetite
var magnetite = require('magnetite');

// capture the DOM element
var dom = document.querySelector('.myMaths');

// process DOM element
magnetite.process(dom);
```

No [preprocessing](http://docs.mathjax.org/en/latest/options/tex2jax.html) is
performed on the DOM element. If you want a LaTeX equation string to be
converted to a HTML equation block then you must wrap the string in `<script>`
tags:

```html
<!-- For inline equations -->
<script type="math/tex">x+\sqrt{1-x^2}</script>

<!-- For displayed equations -->
<script type="math/tex; mode=display">
  \sum_{n=1}^\infty {1\over n^2} = {\pi^2\over 6}
</script>
```

All such `<script>` elements in the DOM element will be converted to HTML
equations. The supported list of LaTeX commands can be found at
[Supported LaTeX commands](http://docs.mathjax.org/en/latest/tex.html#tex-commands).

## API

### `magnetite.load()`

Load the MathJax environment. You do not have to explicitly call
`magnetite.load()` as it is automatically called when you invoke
`magnetite.process(dom)`. However if you wish to pre-load MathJax then you can
call this method directly.

Magnetite loads MathJax with the following configuration:

```javascript
jax: ["input/TeX","output/HTML-CSS"]
extensions: []
TeX:
  extensions: ["AMSmath.js","AMSsymbols.js","noErrors.js","noUndefined.js"]
messageStyle: "none"
showMathMenu: false
```

It is derived from the
[`TeX-AMS_HTML`](http://docs.mathjax.org/en/latest/config-files.html#the-tex-ams-html-configuration-file)
MathJax combined configuration that is used by
[math.stackexchange.com](http://math.stackexchange.com/) and
[stackedit.io](https://stackedit.io) as a base for their MathJax configurations.

#### Return

- **Boolean** `magnetite.load()`:  
`true` if Magnetite was able to load MathJax or had previously loaded MathJax.
`false` if MathJax has already been loaded but not by Magnetite.

### `magnetite.process(dom)`

Convert LaTeX equation strings in `dom` to HTML equations. If no MathJax
environment has been loaded then `magnetite.load()` will be called before `dom`
is processed. LaTeX equation strings must be wrapped in `<script>` tags:

```html
<!-- For inline equations -->
<script type="math/tex">x+\sqrt{1-x^2}</script>

<!-- For displayed equations -->
<script type="math/tex; mode=display">
  \sum_{n=1}^\infty {1\over n^2} = {\pi^2\over 6}
</script>
```

All such `<script>` elements in `dom` will be converted to HTML equations.

#### Parameters

- **[HTMLElement](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement) |
HTMLElement Array |
[HTMLCollection](https://developer.mozilla.org/en/docs/Web/API/HTMLCollection)**
`dom`:  
The DOM element(s) that you want to be processed by MathJax.

#### Return

- **Boolean** `magnetite.process(dom)`:  
`true` if `dom` was successfully queued for processing asynchronously by
MathJax, `false` otherwise. The truth of the return value does not indicate if
MathJax will be able to successfully process `dom`.

## License

Magnetite is released under the [MIT license](LICENSE.md).
