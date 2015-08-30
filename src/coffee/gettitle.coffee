request = require "request"

module.exports = (url, callback) ->
  tr = /<title>(.*?)<\/title>/
  request url, (err, resp, body) ->
    return callback err if err
    if tr.test body
      callback null, body.match(tr)[1]
    else
      callback null, null
