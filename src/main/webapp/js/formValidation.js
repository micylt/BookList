// takes form elements by name, not id
$(document).ready(function() {
	$('#registerform').validate({
		errorClass: "error",
		rules:{
			'first_name':{
				required: true,
			},
			'last_name':{
				required: true,
			},
			'email':{
				required: true,
				email: true,
			},
			'pwd':{
				required: true,
				minlength: 5
			},
			'pwdcnf':{
				required: true,
				minlength: 5,
				equalTo: "#pwd"
			}
		},
		messages:{
			'first_name':{
				required:"This field is required."
			},
			'last_name':{
				required:"This field is required."
			},
			'pwd':{
				required:"This field is required.",
				minlength:"Your password must be at least 5 character long."
			},
			'pwdcnf':{
				required:"This field is required.",
				minlength:"Your password must be at least 5 character long.",
				equalTo:"Your password does not match."
			}
		}
	});
});