$(function() {
  Payjp.setPublicKey('pk_test_ccd65669bdb3e11991c876a6');
  $("#charge_form").on('click', function(e){
    e.preventDefault();
    var year = $("#exp_year").val()
    var month = $("#exp_month").val()
    exp_year = String(year);
    exp_month= String(month);
    let card = {
      number: $("#number").val(),
      cvc: $("#cvc").val(), 
      exp_month: exp_month,
      exp_year: exp_year
    };
    Payjp.createToken(card, function(status, response){

      if (status === 200) {
        $("#all-form").append(
          $('<input type="hidden" name="payjp-token">').val(response.id)
        );
        $('#all-form').submit();
      } else {
        alert("カード情報が正しくありません。");
      }
    });
  });
});
        // $("#form").append($('<input name="payjp_token" type="hidden">').val(response.id));
        // $("#form").submit();
//         $(".card_number").removeAttr("name");
//         $(".security_code").removeAttr("name");
//         $(".exp_month").removeAttr("name");
//         $(".exp_year").removeAttr("name");
//         $("#form").append($(`<input type="hidden" name="payjpToken" value=${token}>`).val(token));
//         $("#form").get(0).submit();
//         let token = response.id;
//         alert("カード情報を登録しました");
//       }
//       else {
//         $("#charge_form").prop('disabled', false);
//         alert('カード情報が登録できませんでした');
//       }
//     });
//   });
// });
