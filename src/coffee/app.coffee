clipboard = require "clipboard"
Vue = require "vue"
getDate = require "./getdate.coffee"
getTitle = require "./webview-title.coffee"

contentVM = new Vue
  el: "#content"

  data:
    interval: 1000
    intervalOptions: [
      {text: "10秒", value: 10000}
      {text: "1秒", value: 1000}
      {text: "100ms", value: 100}
      {text: "10ms", value: 10}
    ]
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
      @timer = true
      do timer = () =>
        return unless @timer
        line = clipboard.readText()

        if @prev isnt line

          if /^https?:\/\//.test(line) and @references
            getTitle line, (title) =>
              @add "#{title}, #{line}"

          else
            @add line

        @prev = line
        setTimeout timer, @interval

    disable: ->
      @timer = null

    toggle: ->
      if @timer then @disable() else @enable()

    refHelp: ->
      alert "URL をコピーした際に、タイトルを取得します。"
      event.preventDefault()
