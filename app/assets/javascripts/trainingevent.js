document.addEventListener('page:load', function(){
  populateemployeelist();
});

$(document).ready(function () {
  populateemployeelist();
});

function populateemployeelist() {
  $("#trainingevent_courseversionid").change(function(event) {
    //window.location = "/trainingevent/show?cvid=" + $("#trainingevent_courseversionid").val() + "/";
	$.ajax({
      url: "/trainingevent/getemployeelist",
      type: "GET",
      data: {cvid: $(this).val()},
      success: function(data) {
        $("#trainingevent_employeeid").children().remove();
        // Create options and append to the list
        var listitems = []; 
        $.each(data,function(key, value) { 
          listitems += '<option value="' + value[1]+ '">' + value[0] + '</option>';    
	    }); 
        $("#trainingevent_employeeid").append(listitems);
      }
    })
  });
}