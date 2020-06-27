document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementsById("token_submit") != null) {
      Payjp.setPublicKey("pk_test_ccd65669bdb3e11991c876a6");
      //自分のテスト公開鍵を記述
      let btn = document.getElementById("token_submit"); //送信ボタンをbtnに格納
      btn.addEventListener("click", e => { //送信ボタンがクリックした時
        e.preventDefault();
        let card = { //card情報の作成
          card_number: document.getElementById("card_number").value,
          expiration_year: document.getElementById("expiration_year").value,
          expiration_month: document.getElementById("expiration_month").value,
          security_code: document.getElementById("security_code").value
        }; //入力されたデータを取得する
        Payjp.createToken(card, (status, response ) => {
          //カード情報をpayjpに送りカードトークン（response.id）を取得する
          if (status === 200) { //正常値の時
            $("#card_number").removeAttr("name");
            $("#security_code").removeAttr("name");
            $("#expiration_month").removeAttr("name");
            $("#expiration_year").removeAttr("name"); 
            //name属性を削除してdataベースに送らないようにする
            $("#submit-btn").append(
              $('<form type="hidden" name="payjp-token">').val(response.id)
            );
            document.Form.submit();
            alert("登録が完了しました"); 
          } else {
            alert("カード情報が正しくありません。");
          }
        });
      });
    }
  },
  false
);
