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
                display(true)
            } else {
                display(false)
            }
        }
        else if (event.data.type == "test") {
            $(".materialien50").text(event.data.pistolenteil + "/50");
            var pistolenteile=event.data.pistolenteil;
            $(".materialien100").text(event.data.heavypistolenteil + "/100");
            var heavypistolenteile=event.data.heavypistolenteil;
            $(".materialien150").text(event.data.revolverteil + "/150");
            var revolverteile=event.data.revolverteil;

            if(event.data.pistolenteil >= 50){
                $("#herstellen50").prop("disabled",false);
                $(".materialien50").css("color", "green");
            } else {
                $("#herstellen50").prop("disabled",true);
                $(".materialien50").css("color", "red");
            }

            if(event.data.heavypistolenteil >= 100){
                $("#herstellen100").prop("disabled",false);
                $(".materialien100").css("color", "green");
            } else {
                $("#herstellen100").prop("disabled",true);
                $(".materialien100").css("color", "red");
            }

            if(event.data.revolverteil >= 150){
                $("#herstellen150").prop("disabled",false);
                $(".materialien150").css("color", "green");
            } else {
                $("#herstellen150").prop("disabled",true);
                $(".materialien150").css("color", "red");
            }


        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://dnz_waffendealer/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('http://dnz_waffendealer/exit', JSON.stringify({}));
        return
    })
    //when the user clicks on the submit button, it will run
    $("#herstellen50").click(function () {
        // if there are no errors from above, we can send the data back to the original callback and handle it from ther
        $.post('http://dnz_waffendealer/pistole', JSON.stringify({
       
        }));
        return;
    })


    $("#herstellen100").click(function () {
        // if there are no errors from above, we can send the data back to the original callback and handle it from ther
        $.post('http://dnz_waffendealer/heavypistole', JSON.stringify({
            
        }));
        return;
    })


    $("#herstellen150").click(function () {
        // if there are no errors from above, we can send the data back to the original callback and handle it from ther
        $.post('http://dnz_waffendealer/revolver', JSON.stringify({
            
        }));
        return;
    })
})
