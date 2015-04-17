require('coffee-script/register');
var gulp = require('gulp');
var gutil = require('gulp-util');
var coffee = require('gulp-coffee');
var jasmine = require('gulp-jasmine');
var reporters = require('jasmine-reporters');

gulp.task('coffee', function() {
  gulp.src('./app/scripts/**/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./public/assets/scripts'))
});

gulp.task('jasmine', function () {
  return gulp.src('spec/**/*.coffee')
    .pipe(jasmine());
});

gulp.task('default', ['coffee', 'jasmine']);
