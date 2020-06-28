document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) {
      //情報が空ではない状態で追加ボタン押すと
      Payjp.setPublicKey("pk_test_ccd65669bdb3e11991c876a6");
      //自分のテスト公開鍵を記述
      let submit = document.getElementById("token_submit"); //送信ボタンをsubmitに格納
      submit.addEventListener("click", e => { //送信ボタンがクリックした時
        e.preventDefault(); //一度止まる
        let card = { //card情報の作成
          number: document.getElementById("card_number").value,
          exp_year: document.getElementById("expiration_year").value,
          exp_month: document.getElementById("expiration_month").value,
          cvc: document.getElementById("security_code").value
        }; //入力されたデータを取得する
        Payjp.createToken(card, function(status, response )  { //トークンを生成
          //カード情報をpayjpに送りカードトークン（response.id）を取得する
          if (status === 200) { //正常値の時
            $("#card_number").removeAttr("name");
            $("#security_code").removeAttr("name");
            $("#expiration_month").removeAttr("name");
            $("#expiration_year").removeAttr("name"); 
            //name属性を削除してdataベースに送らないようにする
            $("#charge-form").append( //form_withのid
              $('<form type="hidden" name="payjp_token">').val(response.id)
            ); //取得したトークンを送信できる状態にする
            document.authenticity_token.submit();
            //form_withのname
            alert("登録が完了しました"); 
          } else {
            alert("カード情報が正しくありません。");
          }
        });
      });
    }
  }
);