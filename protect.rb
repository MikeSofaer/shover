require 'sinatra'

get '/' do
%{
<ul id="throat" 
  style= "text-align: center;
          list-style-type: none;
          font-family: 'Lucida Console', Monaco, monospace;
          font-size: 24pt;
          font-weight: bold;">
  <li margin-bottom='10px'>SPEAK, HUMAN</li>
  <li id='stairs'>          
    <form id="human" style="text-align:center;">
      <input id="question" type="text" style="text-align:center;
                                              height:60;
                                              width:500;"/>
    </form>
  </li>
</ul>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"/>
<script>ws = new WebSocket("ws://localhost:8080/");
  ws.onmessage = function(evt) {
    $("#stairs").after("<li margin-top='200px' margin-bottom='50px'>" +evt.data + "</li>" )
  }

  $("#human").submit(
    function(evt) {
      evt.preventDefault();
      ws.send($("#question")[0].value);
      $('#question')[0].value='';
    }
  )
</script>
}
end
