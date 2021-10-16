$(document).on('click', 'div.card-columns div.card div.card-body a', function() {
  var model = $(this).attr('model');
  $.post('http://dnz_garage/iQNrotJKsNbEJMq',  JSON.stringify({ model: $(this).attr('model') }));
}) ;

$(document).ready(function(){
function byegarage() {
  $(".home").css("display", "none");
}
function hallogarage() {
  $(".home").css("display", "block");
}
function hallodnz() {
  $(".garagen-container").css("display", "block");
}
function byednz() {
  $(".garagen-container").css("display", "none");
}

window.addEventListener('message', function(event){
  var item = event.data;
  if(item.zeEIyWXmNgTDxvH == true) {
    hallodnz();
    hallogarage();
  }
  if(item.zeEIyWXmNgTDxvH == false) {
    byednz();
    byegarage();
  }
  if(item.saubermachen == true) {
  $('#testEmpty').html('');
  }
  if(item.hinzufugen == true) {
      var fahrzeugname = item.name

      if(fahrzeugname == 'RS7') {
        fahrzeugname = 'Audi RS7';
      } else if (fahrzeugname == 'GT63SAMG'){
        fahrzeugname = 'AMG GT63s';
      } else if (fahrzeugname == 'BALLER2'){
        fahrzeugname = 'Baller v2';
      } else if (fahrzeugname == 'BALLER'){
        fahrzeugname = 'Baller';
      } else if (fahrzeugname == 'rmodlp750'){
        fahrzeugname = 'Aventador';
      }

      var dasauto = '<div class="card" style="border: 1px solid #434a4d;">' +
                          '<img class="card-img-top" src="fahrzeuge/' + item.name + '.png">' +
                          '<div class="card-body">' +
                          ' <h5 class="card-title"><center>'+ fahrzeugname +'</center></h5><hr>' +
                          ' <h6 class="card-subtitle mb-2" style="font-family: Poppins; color: rgb(179, 179, 179);"><small><b>Kennzeichen: </b>'+ item.model +'<br><b>Treibstoff: </b>' + item.tank + '%<br><b>Zustand: </b>'+ item.fahrzeugzustand +'% <br><b>Motor:</b> ' + item.motor + '% </small></h6>' +
                            '<hr>' +
                          '<center><a href="#" model="'+ item.model +'" class="btn btn-dark">Ausparken <i class="fa fa-car" aria-hidden="true"></i></a></center>' +
                          '</div>' +
                        '</div>';
    $(".card-columns").append(dasauto);
  }
});

document.onkeyup = function (data) {
  if (data.which == 27 ) {
  $.post('http://dnz_garage/close', JSON.stringify({}));
  }
};

});
