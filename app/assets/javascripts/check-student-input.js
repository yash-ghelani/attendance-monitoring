/**
 * File will run when student types into the enter code screen
 * and validate the code, it will display the details on screen
 * if they are valid
 */

 document.addEventListener("DOMContentLoaded", function() {

  //setup before functions
  var typingTimer;                //timer identifier
  var doneTypingInterval = 500;  //time in ms
  var running = false; //Is a search running?
  var inputBox = $("#session_code_session_code")
  var spinnyBoi = $("#loadingIcon")
  var resultsBox = $("#results")
  //When student starts typing start countdown
  inputBox.keyup(function(){
    //Reset timer if still typing
    clearTimeout(typingTimer);
    if (inputBox.val()) {
      typingTimer = setTimeout(doneTyping, doneTypingInterval);
    }else{
      resultsBox.empty()
    }
  });

  //Start running ajax request
  function startRunning(){
    spinnyBoi.toggleClass("d-none")
    running=true
  }

  //Stop running ajax request
  function stopRunning(){
    spinnyBoi.toggleClass("d-none")
    running=false
  }

  //Student finished typing, execute
  function doneTyping () {
    if(!running){
      //TODO we can add REGEX validation here to take load off SERVER
      startRunning()
      //Empty the current contents to avoid duplication
      resultsBox.empty()
      var code = inputBox.val()
      //Send an AJAX request to the controller
      $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "/student/quick",
        data : JSON.stringify({session_code:code}),
        dataType: "json",
        success: function (result) {
          //If the result isn't false (code valid)
          if(result){
            //HTML to inject
            var title = result["session_title"]
            formHtml=`
            <p class="text-success">Code Valid</p>
            <p><b>${title}</b></p>
            `
            resultsBox.append(formHtml);
          }else{
            formHtml=`
            <p class="text-danger">Code Invalid</p>
            `
           resultsBox.append(formHtml);
          }
          stopRunning()
        },
        error: function (){
           console.log("Error during ajax request")
           stopRunning()
        }
       });
    }
  }

  //Call when page loads to validate QR codes
  if(inputBox.val()){
    doneTyping();
  }

});