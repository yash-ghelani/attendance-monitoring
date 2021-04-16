/**
 * File will run when the show code screen is open,
 * and check for students joining, and add their names
 * to the screen
 */

 document.addEventListener("DOMContentLoaded", function() {

  //Globals
  var resultsBox = $("#newStudents")
  var checkInterval = 3000

  //Will wait before sending next request
  function reset(){
    setTimeout(check_join,checkInterval)
  }

  //Prevent duplicates
  function is_student_on_screen(username){
    var duplicate = false;
    resultsBox.children().each(function() {
      if($(this).attr("name") == username){
        return duplicate = true
      }
    });
    return duplicate;
  }

  //Check for new students joining
  function check_join () {
    session_id = resultsBox.attr("code")
    console.log("Using session ID: "+session_id)
    $.ajax({
      type: "POST",
      contentType: "application/json; charset=utf-8",
      url: "/attendance/quick",
      data : JSON.stringify({session_id:session_id}),
      dataType: "json",
      success: function (result) {
        for (var i = 0; i < result.length; i++) {
          data=result[i]
          username=data[0].toUpperCase()
          if(!is_student_on_screen(username)){
            formData=
            `
            <div name=${username} class="col mt-3"><div class="p-2 bg-success text-white rounded text-center">${username}</div></div>
            `
            resultsBox.prepend(formData);
          }
          
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
  check_join()

});