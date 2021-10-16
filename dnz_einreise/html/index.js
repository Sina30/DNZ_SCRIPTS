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
        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://dnz_einreise/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('http://dnz_einreise/exit', JSON.stringify({}));
        return
    })
    //when the user clicks on the submit button, it will run
    $("#submit").click(function () {
        // if there are no errors from above, we can send the data back to the original callback and hanndle it from there
        $.post('http://dnz_einreise/main', JSON.stringify({}));
        return;
    })
})
