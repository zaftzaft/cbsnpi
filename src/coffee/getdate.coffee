module.exports = ->
  d = new Date
  dy = d.getFullYear()
  dm = d.getMonth() + 1
  da = d.getDate()
  "#{dy}/#{dm}/#{da}"


