'use strict';

var http = require("http");

console.log(process.argv);

var redirectUrl = `http://${process.argv[0]}`;

http.createServer(function(request, response){
    response.writeHead(302,  {Location: redirectUrl})
    response.end();
}).listen(3030);