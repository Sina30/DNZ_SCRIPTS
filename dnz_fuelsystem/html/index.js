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
        else if (event.data.type == "anzahl") {
            $(".literanzahl").text(event.data.current + " Liter");
            $(".needsprit").text(event.data.fehlt);
            if (event.data.current > "99.9") {
                $(".submit").show();
                $(".close").hide();
            } else if (event.data.fehlt < "1") {
                $(".spritpreis1").text("$0");
            }
            }
            else if (event.data.type == "rechnung") {
                $(".spritpreis1").text("$" + event.data.rechnung);
            }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://LegacyFuel/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('http://LegacyFuel/exit', JSON.stringify({}));
        return
    })
    //when the user clicks on the submit button, it will run
    $("#submit").click(function () {
        $(".spritpreis1").text("$0");
        // if there are no errors from above, we can send the data back to the original callback and handle it from ther
        $.post('http://LegacyFuel/main', JSON.stringify({
            
        }));
        return;
    })
})
