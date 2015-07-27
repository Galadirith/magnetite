#
# mathjax-helper
#
# This module will handle loading the MathJax environment and provide a wrapper
# for calls to MathJax to process LaTeX equations.
#

loadedByMagnetite = false

module.exports =

  load: ->
    if MathJax?
      return loadedByMagnetite ? true : false
    else if document.querySelector('script[src*="MathJax.js"]')?
      return loadedByMagnetite ? true : false

    mathjaxPath = require.resolve 'MathJax'

    script = document.createElement 'script'
    script.addEventListener 'load', () ->
      configureMathJax()
      return
    script.type = 'text/javascript'
    script.src  = mathjaxPath + '?delayStartupUntil=configured'

    document.getElementsByTagName("head")[0].appendChild(script)
    loadedByMagnetite = true

    return true

  process: (dom) ->
    if MathJax?
      MathJax.Hub.Queue ["Typeset", MathJax.Hub, dom]
      return true
    else if script = document.querySelector('script[src*="MathJax.js"]')?
      script.addEventListener 'load', () ->
        MathJax.Hub.Queue ["Typeset", MathJax.Hub, dom]
        return
      return true
    else
      load()
      script = document.querySelector('script[src*="MathJax.js"]')
      script.addEventListener 'load', () ->
        MathJax.Hub.Queue ["Typeset", MathJax.Hub, dom]
        return
      return true

    return false

#
# Configure MathJax environment. Similar to the TeX-AMS_HTML configuration with
# a few unnessesary features stripped away
#
configureMathJax = ->
  MathJax.Hub.Config
    jax: ["input/TeX","output/HTML-CSS"]
    extensions: []
    TeX:
      extensions: ["AMSmath.js","AMSsymbols.js","noErrors.js","noUndefined.js"]
    messageStyle: "none"
    showMathMenu: false
  MathJax.Hub.Configured()
  return
