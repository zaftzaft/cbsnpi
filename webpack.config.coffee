webpack = require "webpack"

module.exports =
  entry:
    app: ["./src/coffee/app.coffee"]
  output:
    filename: "bundle.js"
  module:
    loaders: [
      {test: /\.coffee$/, loader: "coffee"}
      {test: /\.json$/, loader: "json"}
    ]
  target: "atom"
  __product:
    plugins: [
      new webpack.optimize.UglifyJsPlugin
        compress:
          warnings: false
        sourceMap: false
        mangle: true
      #new webpack.optimize.OccurenceOrderPlugin true
    ]

