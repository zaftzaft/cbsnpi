Vue = require "vue"
getTitle = require "./gettitle.coffee"
getDate = require "./getdate.coffee"
clipboard = require "clipboard"

contentVM = new Vue
  el: "#content"

  data:
    interval: 1000
    prev: ""
    text: ""
    timer: null
    references: false
    date: false
    order: false

  created: ->
    log = localStorage.getItem "text"
    @text = log if log
    @$watch "text", (a) -> localStorage.setItem "text", a

    prev = localStorage.getItem "prev"
    @prev = prev if prev
    @$watch "prev", (a) -> localStorage.setItem "prev", a

  methods:
    addBreak: (t) ->
      unless /\n$/.test t
        t += "\n"
      return t

    addDate: (t, f = false) ->
      t += ", #{getDate()}" if @date; return t

    format: (text) ->
      @addBreak @addDate text

    add: (text) ->
      if @order
        @text = "#{@format text}#{@text}"
      else
        @text += @format text

    enable: ->
      @timer = setInterval =>
        line = clipboard.readText()

        if @prev isnt line

          if /^https?:\/\//.test(line) and @references
            getTitle line, (err, title) =>
              @add if err then line else "#{title}, #{line}"

          else
            @add line

        @prev = line
      , @interval

    disable: ->
      clearInterval @timer if @timer
      @timer = null

    toggle: ->
      if @timer then @disable() else @enable()

    refHelp: ->
      alert "URL をコピーした際に、タイトルを取得します。"
      event.preventDefault()
