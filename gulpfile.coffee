gulp = require "gulp"
$ = do require "gulp-load-plugins"
_ = require "lodash"
webpackConfig = require "./webpack.config.coffee"
webpackProductConfig = _.extend {}, webpackConfig, webpackConfig.__product

buildDest = "./build/source/dist"


gulp.task "webpack", ->
  gulp
    .src "./src"
    .pipe $.webpack webpackConfig
    .pipe gulp.dest "./dist"

gulp.task "jade", ->
  gulp
    .src "./src/jade/index.jade"
    .pipe $.jade()
    .pipe gulp.dest "./dist"

gulp.task "stylus", ->
  gulp
    .src "./src/stylus/style.styl"
    .pipe $.stylus()
    .pipe gulp.dest "./dist"


gulp.task "default", ->
  $.watch "./src/**/*.+(coffee|jade)", ->
    gulp.start "webpack"

  $.watch "./src/jade/index.jade", ->
    gulp.start "jade"

  $.watch "./src/stylus/style.styl", ->
    gulp.start "stylus"

  gulp.start "webpack"
  gulp.start "jade"
  gulp.start "stylus"


gulp.task "build-webpack", ->
  gulp
    .src "./src"
    .pipe $.webpack webpackProductConfig
    .pipe gulp.dest buildDest

gulp.task "build-stylus", ->
  gulp
    .src "./src/stylus/style.styl"
    .pipe $.stylus
      compress: true
    .pipe gulp.dest buildDest

gulp.task "build-jade", ->
  gulp
    .src "./dist/index.html"
    .pipe gulp.dest buildDest

gulp.task "build-main", ->
  gulp
    .src "./main.js"
    .pipe $.uglify()
    .pipe gulp.dest "./build/source"

gulp.task "build", ["build-webpack", "build-stylus", "build-jade", "build-main"]
