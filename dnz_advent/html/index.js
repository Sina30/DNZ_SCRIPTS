$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        } else  if (item.type === "checkadvent") {
            if (event.data.claimed === event.data.daytoday) {
                var d = new Date();
                var dd = d.getDate();
                var tag = "#i" + dd;
                $(tag).css( "display", "none" );
            } else {
            }
        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://dnz_advent/exit', JSON.stringify({}));
            return
        }
    };

    $( window ).load(function() {
        var d = new Date();
        var dd = d.getDate();
        var tag = "#i" + dd;
        $(tag).css( "display", "block" );
      });
	
	
    //when the user clicks on the submit button, it will run
$("#submit").click(function () {
    $.post('http://dnz_advent/main', JSON.stringify({
    }));
    return;
})


$("#close").click(function () {
$.post('http://dnz_advent/exit', JSON.stringify({}));
return
})
	
	
$("#i1").click(function () {
$.post('http://dnz_advent/i1', JSON.stringify({}));
return
})

$("#i2").click(function () {
$.post('http://dnz_advent/i2', JSON.stringify({}));
return
})

$("#i3").click(function () {
$.post('http://dnz_advent/i3', JSON.stringify({}));
return
})

$("#i4").click(function () {
$.post('http://dnz_advent/i4', JSON.stringify({}));
return
})

$("#i5").click(function () {
$.post('http://dnz_advent/i5', JSON.stringify({}));
return
})

$("#i6").click(function () {
$.post('http://dnz_advent/i6', JSON.stringify({}));
return
})

$("#i7").click(function () {
$.post('http://dnz_advent/i7', JSON.stringify({}));
return
})

$("#i8").click(function () {
$.post('http://dnz_advent/i8', JSON.stringify({}));
return
})

$("#i9").click(function () {
$.post('http://dnz_advent/i9', JSON.stringify({}));
return
})

$("#i10").click(function () {
$.post('http://dnz_advent/i10', JSON.stringify({}));
return
})

$("#i11").click(function () {
$.post('http://dnz_advent/i11', JSON.stringify({}));
return
})

$("#i12").click(function () {
$.post('http://dnz_advent/i12', JSON.stringify({}));
return
})

	$("#i13").click(function () {
$.post('http://dnz_advent/i13', JSON.stringify({}));
return
})

$("#i14").click(function () {
$.post('http://dnz_advent/i14', JSON.stringify({}));
return
})

$("#i15").click(function () {
$.post('http://dnz_advent/i15', JSON.stringify({}));
return
})

$("#i16").click(function () {
$.post('http://dnz_advent/i16', JSON.stringify({}));
return
})

$("#i17").click(function () {
$.post('http://dnz_advent/i17', JSON.stringify({}));
return
})

$("#i18").click(function () {
$.post('http://dnz_advent/i18', JSON.stringify({}));
return
})

	$("#i19").click(function () {
$.post('http://dnz_advent/i19', JSON.stringify({}));
return
})

$("#i20").click(function () {
$.post('http://dnz_advent/i20', JSON.stringify({}));
return
})

$("#i21").click(function () {
$.post('http://dnz_advent/i21', JSON.stringify({}));
return
})

$("#i22").click(function () {
$.post('http://dnz_advent/i22', JSON.stringify({}));
return
})

$("#i23").click(function () {
$.post('http://dnz_advent/i23', JSON.stringify({}));
return
})

$("#i24").click(function () {
$.post('http://dnz_advent/i24', JSON.stringify({}));
return
})

})