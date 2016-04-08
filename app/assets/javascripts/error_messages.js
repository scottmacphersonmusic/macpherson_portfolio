document.addEventListener("DOMContentLoaded", function(event) {

  function useJavascript() {
    var p = document.createElement('p');
    var content = document.createTextNode('JavaScript is getting tested!!!');
    p.appendChild(content);
    document.body.appendChild(p);
  };


  var link = document.getElementById('link');
  link.addEventListener('click', useJavascript, false);
});
