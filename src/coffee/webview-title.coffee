$webview = document.getElementById "webview"

module.exports = (url, callback) ->
  fn = (e) ->
    $webview.stop()
    $webview.clearHistory()
    callback e.title
    $webview.removeEventListener "page-title-set", fn

  $webview.addEventListener "page-title-set", fn

  $webview.src = url
