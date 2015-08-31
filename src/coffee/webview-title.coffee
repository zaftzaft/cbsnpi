$webview = document.getElementById "webview"

module.exports = (url, callback) ->
  fn = (e) ->
    callback e.title
    $webview.removeEventListener "page-title-set", fn

  $webview.addEventListener "page-title-set", fn

  $webview.src = url
