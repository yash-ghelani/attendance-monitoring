/**
 * File will run when the show code screen is open,
 * and check for students joining, and add their names
 * to the screen
 */

 document.addEventListener("DOMContentLoaded", function() {

  //Globals
  var resultsBox = $("#studentCounter")
  var checkInterval = 3000

  //Will wait before sending next request
  function reset(){
    setTimeout(get_count,checkInterval)
  }

  //Main ajax call to get count
  function get_count(){
    //Extract session ID from html
    session_id = resultsBox.attr("code")
    //Call ajax request
    $.ajax({
      type: "POST",
      contentType: "application/json; charset=utf-8",
      url: "/attendance/quick",
      data : JSON.stringify({session_id:session_id}),
      dataType: "json",
      success: function (result) {
        //Check result is integer and update text
        if (result === parseInt(result, 10)){
          resultsBox.text(result)
        }else{
          resultsBox.text("N/A")
        }
        
        reset()
      },
      error: function (){
         console.log("Error during ajax request") 
         reset()
      }
     });
  }

  //Call on page load
  get_count()

});