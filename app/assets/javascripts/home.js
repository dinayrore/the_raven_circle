///////////////////
// Crystal Ball //
//////////////////

//global vars for current quote and author in view
var currentQuote = '';
var currentAuthor = 'Raven';

//update quote and author in view with fade in/out animation.
function getQuote(){
    //instantiate new XHR object
    var request = new XMLHttpRequest();
    //fade out current quote and author
    TweenMax.to([text, author], 0.3,{opacity: 0});
    //initialize GET request. Add output of Math.random to URI query to avoid repeat quotes
    request.open('GET', 'https://cors-anywhere.herokuapp.com/https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en&' + Math.random(), true);

    request.onload = function() {
      //when results of AJAX call have fully loaded check to see if call was successful
      if (request.status >= 200 && request.status < 400) {
        //store result of call in var data and convert to JSON object
        var data = JSON.parse(request.responseText);
        //update view with new quote and author
        currentQuote = text.innerHTML = data.quoteText;
        currentAuthor = author.innerHTML = "-" + data.quoteAuthor;
        //fade up quote new quote and author
        TweenMax.to([text, author], 0.3,{opacity: 1});
      }
    };
    //send AJAX GET request to quote API
    request.send();
  };
  //on page load generate first quote
  window.onload = getQuote();

  //new quote button and tweet quote button
  var newQuote = document.querySelector('#new-vision');
  newQuote.addEventListener("click", getQuote);
