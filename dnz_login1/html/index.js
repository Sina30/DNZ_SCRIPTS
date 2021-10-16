/*
-- @Project: FiveM Tools dnz_login
-- @License: GNU General Public License v3.0
*/

// Define the `nui` module
var nui = angular.module('nui', []);

// Define the `PhoneListController` controller on the `phonecatApp` module
nui.controller('nuiController', function nuiController( $scope, $document, $window ) {
	
	$scope.submitEnter = function(event) {
		var username = $("#username").val();
		var password = $("#password").val();
		
        if( username != '' && password != '' ) {	
			$.post('http://dnz_login2/dnz_loginsystem:LoginServer', JSON.stringify({
				username: $("#username").val(),
				password: $("#password").val()
			}));
		} else {
		
			$('#errorcode').delay(100).fadeIn('slow').delay(2500).fadeOut('slow');
		}
	}	

	$( ".einloggen" ).click(function() {
		$(this).css("background-color", "#777777");
		$(".registrieren").css("background-color", "#969696");
		
	  });
	
	  $( ".registrieren" ).click(function() {
		$(this).css("background-color", "#777777");
		$(".einloggen").css("background-color", "#969696");
		
	  });

	$scope.registerEnter = function(event) {
		var username = $("#username").val();
		var password = $("#password").val();
        if( username != '' && password != '' ) {	
			$.post('http://dnz_login2/dnz_loginsystem:register', JSON.stringify({
				username: $("#username").val(),
				password: $("#password").val()
			}));
		} else {
			$('#errorcode').delay(100).fadeIn('slow').delay(2500).fadeOut('slow');
		}
	}	

	
    window.addEventListener('message', function(event) {		
        if ( event.data.type == 'EnableGuiLogin' ) {					
            document.body.style.display = event.data.StatusJs ? "block" : "none"; // If data 'StatusJs' is enable, change css to 'block'			
		}	
		
		if ( event.data.type == 'errorcode' ) {					
			if (event.data.errortyp == '1') {
				$('#wronglogin').delay(100).fadeIn('slow').delay(2500).fadeOut('slow');
			} else if (event.data.errortyp =='2'){
			} else if (event.data.errortyp =='3'){
				$('#vergeben').delay(100).fadeIn('slow').delay(2500).fadeOut('slow');
			} else if (event.data.errortyp =='4'){
				$('#hastschon').delay(100).fadeIn('slow').delay(5500).fadeOut('slow');
				$('#registerbutton').prop("disabled", true);
			} else if (event.data.errortyp =='5'){
				$('#keinaccount').delay(100).fadeIn('slow').delay(5500).fadeOut('slow');
				$('#loginbutton').prop("disabled", true);
			} else if (event.data.errortyp =='6'){
				$('#accountinvalid').delay(100).fadeIn('slow').delay(5500).fadeOut('slow');
				$('#loginbutton').prop("disabled", true);
				$('#registerbutton').prop("disabled", true);
			} else if (event.data.errortyp =='7'){
				$('#gebannt').delay(100).fadeIn('slow');
				$('#loginbutton').prop("disabled", true);
				$('#registerbutton').prop("disabled", true);
			}
					
        }	
    });
	
});