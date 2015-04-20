require('coffee-script/register');
var gulp = require('gulp');
var gutil = require('gulp-util');
var coffee = require('gulp-coffee');

gulp.task('coffee', function() {
  gulp.src('app/scripts/**/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./public/assets/scripts'));
  gulp.src('spec/scripts/**/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('public/spec/scripts'))
});

gulp.task('default', ['coffee']);
