$(function() {
  // 画像用のinputを生成する関数
  const buildFileField = function(index) {
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[images_attributes][${index}][src]"
                    id="item_images_attributes_${index}_src">
                  </div>`;
    return html;
  }

  // プレビュー用のimgタグを生成する関数
  const buildImg = function(index, url) {
    const html = `<div id="previews-box" data-preview="${index}">
                    <img data-index="${index}" src="${url}" width="100px" height="100px">
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];

  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // ラベルタグの更新
    $('.item-photo__area--label').attr('for',`item_images_attributes_${fileIndex[0]}_src`)

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {
      // 新規画像追加の処理
      $('#previews').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
    }
    // 削除機能
    $('#previews').on('click', '.js-remove', function() {
      //プレビュー要素とinput要素を取得
      var preview_num = $(this).parent();
      var target_num = $(preview_num).data('preview')
      console.log(target_num)

      //プレビュー要素を削除
      preview_num.remove();

    //input要素を削除
      $(`#item_images_attributes_${target_num}_src`).remove();
      $('').prop("checked", true);
    }
    );
  });

  // 商品説明の字数カウント
  $(".item-info--description__textarea").keyup(function(){
    let count = $(this).val().length;
    $("#words-count").text(count);
  });

  //必須部分の検証
  //画像
  $('.form-content').on('submit',function(e){
    let imageLength = $('#previews').children().length;
    if(imageLength ==''){
      $('body, html').animate({ scrollTop: 0 }, 500);
      $('#error-image').text('画像がありません');
      return false;
    }else if(imageLength >10){
      $('body, html').animate({ scrollTop: 0 }, 500);
      $('#error-image').text('画像を10枚以下にして下さい');
      return false;
    }else{
      return true;
    }
  });

  //商品名
  $('#item_name').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-name').text('入力してください');
      $(this).css('border-color','red');
    }else{
      $('#error-name').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });

  //商品説明
  $('#item_detail').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-text').text('入力してください');
      $(this).css('border-color','red');
    }else{
      $('#error-text').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });

  //カテゴリーのエラーハンドリング
  $('#item_category_id').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-category').text('選択してください');
      $(this).css('border-color','red');
    }else{
      $('#error-category').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });

  //状態
  $('#item_status').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-condition').text('選択してください');
      $(this).css('border-color','red');
    }else{
      $('#error-condition').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });

   //送料負担
   $('#item_delivery_fee').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-deliveryburden').text('選択してください');
      $(this).css('border-color','red');
    }else{
      $('#error-deliveryburden').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });

   //発送元
   $('#item_start_address').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-area').text('選択してください');
      $(this).css('border-color','red');
    }else{
      $('#error-area').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });

  //発送までの日数
  $('#item_shipping_date').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-shipping_date').text('選択してください');
      $(this).css('border-color','red');
    }else{
      $('#error-shipping_date').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });

  //価格
  $('#item_price').on('blur',function(){
    let value = $(this).val();
    if(value < 300 || value > 9999999){
      $('#error-price').text('300以上9,999,999以下で入力してください');
      $(this).css('border-color','red');
    }else{
      $('#error-price').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
});