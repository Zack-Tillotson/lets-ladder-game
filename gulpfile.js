require('coffee-script/register');

var gulp = require('gulp');
var gutil = require('gulp-util');
var coffee = require('gulp-coffee');
var cjsx = require('gulp-cjsx');
var sass = require('gulp-sass');

gulp.task('coffee', function() {
  gulp.src('app/scripts/**/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./public/assets/scripts'));
});

gulp.task('spec-coffee', function() {
  gulp.src('spec/scripts/**/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('public/spec/scripts'))
});

gulp.task('cjsx', function() {
  gulp.src('app/scripts/views/**/*.cjsx')
    .pipe(cjsx({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('public/assets/scripts/views/'));
});

gulp.task('sass', function () {
  gulp.src('./app/styles/**.sass')
    .pipe(sass({indentedSyntax: true}))
    .pipe(gulp.dest('./public/assets/styles'));
});

gulp.task('default', ['coffee', 'spec-coffee', 'cjsx', 'sass']);
