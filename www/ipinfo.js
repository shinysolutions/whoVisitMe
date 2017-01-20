// IP info;
$(document).ready(function(){
  var I = 0
  var tt = setInterval(function(){
    var L = $("#log");
    $.get("http://ipinfo.io", function(e) {
      L.val(Date() + "  ipInfo|" + e.ip + "," + e.city + "," + e.loc);
      L.trigger("change");
    }, "jsonp");
    if(L.val().length > 0) {
      clearInterval(tt)
    }
  }, 100)
});

