var express = require('express');
var app = express();

app.use(express.static('vendor'));
app.use(express.static('public'));
app.use(express.static('app'));
app.use(express.static('spec'));

var server = app.listen(3000, function () {

});
