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
        if (event.data.type === "ui") {
            if (event.data.status == true) {
                $(".meinweed").text(event.data.meinweed + "/3");
                var meinweed=event.data.meinweed
                $(".meinebaggies").text(event.data.meinebaggies + "/1");
                var meinebaggies=event.data.meinebaggies
                var nix = 0;
                if(nix >= meinweed){
                    $(".meinweed").attr("src","https://i.imgur.com/TFAeUmF.png");
                   
                } else {
                    $(".meinweed").attr("src","https://i.imgur.com/Scb1fOf.png");
                }
                if(event.data.meinebaggies >= 40){
                    $(".meinebaggies").attr("src","https://i.imgur.com/5PSABw8.png"); 
                } else {
                    $(".meinebaggies").attr("src","https://i.imgur.com/I3otPvG.png");
                    
                }
                display(true)
            } else {
                display(false)
            }
        }
        else if (event.data.type == "test") {
            $(".meinweed").text(event.data.meinweed + "/3");
            var meinweed=event.data.meinweed
            $(".meinebaggies").text(event.data.meinebaggies + "/1");
            var meinebaggies=event.data.meinebaggies
            var nix = 2;
            var baggiesneed = 1;
            $("#submit").prop("disabled",false);

            if(nix >= meinweed){
                $(".weedbild").attr("src","https://i.imgur.com/nRl8m4c.png");
                $("#submit").prop("disabled",true);
            } else {
                $(".weedbild").attr("src","https://i.imgur.com/UBhK6kN.png");
            }
            if(meinebaggies == 0){
				$(".baggiesbild").attr("src","https://i.imgur.com/nGUaT3b.png");
                $("#submit").prop("disabled",true);
            } else {
                $(".baggiesbild").attr("src","https://i.imgur.com/QROgld9.png"); 
            }
                
            }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://dnz_w_verarbeiter/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('http://dnz_w_verarbeiter/exit', JSON.stringify({}));
        return
    })
    //when the user clicks on the submit button, it will run
    $("#submit").click(function () {
        setTimeout(function(){
            $("#warten").show();
        }, 1000); 
        // if there are no errors from above, we can send the data back to the original callback and handle it from ther
        $.post('http://dnz_w_verarbeiter/sammeln', JSON.stringify({}));
        $(this).hide(0).delay(30900).show(0);
        return;
    })
})
