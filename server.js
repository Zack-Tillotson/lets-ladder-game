var express = require('express');
var app = express();

app.use(express.static('public'));
app.use(express.static('app'));

var server = app.listen(3000, function () {

});