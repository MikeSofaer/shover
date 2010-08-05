require 'sinatra'
#require 'em-websocket'

get '/' do
%{
<ul id="throat" 
  style= "text-align: center;
          list-style-type: none;
          font-family: 'Lucida Console', Monaco, monospace;
          font-size: 24pt;
          font-weight: bold;"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"/>
<script>ws = new WebSocket("ws://localhost:8080/");
 ws.onmessage = function(evt) {
   $("#throat").prepend("<li margin-top='200px' margin-bottom='50px'>" +evt.data + "</li>" )
 }
 </script>
 }
end
