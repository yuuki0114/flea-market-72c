$(document).ready(function(){
      // ラベルのサイズ変更
      let num = $("#previews").children().length + 1
      let items_width = num*123.5
      let label_width = 615 - items_width
      let down_num = $("#previews").children().length - 4
      let down_items_width = down_num*123.5
      let down_label_width = 615 - down_items_width
      if (num == 10) {
        $(".item-photo__area--label").css("display", "none")
      } else if (num > 5){
        $(".item-photo__area").css({"display":"block", "position":"relative"})
        $(".item-photo__area--label").css({"width":down_label_width, "position":"absolute", "right":"0"})
        $(".label-text").css("display", "none")
        $("#previews").css("display", "flex")
      } else if (num == 5){
        $(".item-photo__area").css("display", "block")
        $(".item-photo__area--label").css({"width":"100%", "top":""})
        $(".label-text").css("display", "block")
        $("#previews").css("width", "100%")
        $(".sell-photo").css("height", "417px")
      } else {
        $(".item-photo__area--label").css("width", label_width)
        $(".label-text").css("display", "none")
        $("#previews").css({"display":"flex", "width":items_width})
      }  
});

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
                    <img data-index="${index}" src="${url}" width="123px" height="100px">
                    <div class="js-remove">削除する</div>
                  </div>`;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];

  $(document).ready(function(){
    let preview_count = $("#previews").children().length
    if(preview_count != 0){
      // 新しく画像を追加するタグを生成
      $('#image-box').append(buildFileField(preview_count));
      // 追加要素のラベルタグを読み込む
      $('.item-photo__area--label').attr('for',`item_images_attributes_${preview_count}_src`)
      // file_fieldの不要な配列要素の削除
      fileIndex.splice(0, preview_count);
    }});

  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // ラベルタグの更新
    $('.item-photo__area--label').attr('for',`item_images_attributes_${fileIndex[0]}_src`)
    
    // ラベルのサイズ変更
    let num = $("#previews").children().length + 1
    let items_width = num*123.5
    let label_width = 615 - items_width
    let down_num = $("#previews").children().length - 4
    let down_items_width = down_num*123.5
    let down_label_width = 615 - down_items_width
    if (num == 10) {
      $(".item-photo__area--label").css("display", "none")
    } else if (num > 5){
      $(".item-photo__area").css({"display":"block", "position":"relative"})
      $(".item-photo__area--label").css({"width":down_label_width, "position":"absolute", "right":"0"})
      $(".label-text").css("display", "none")
      $("#previews").css("display", "flex")
    } else if (num == 5){
      $(".item-photo__area").css("display", "block")
      $(".item-photo__area--label").css({"width":"100%", "top":""})
      $(".label-text").css("display", "block")
      $("#previews").css("width", "100%")
      $(".sell-photo").css("height", "417px")
    } else {
      $(".item-photo__area--label").css("width", label_width)
      $(".label-text").css("display", "none")
      $("#previews").css({"display":"flex", "width":items_width})
    }

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
  });

  // 削除機能
  $('#previews').on('click', '.js-remove', function() {
  //プレビュー要素とinput要素を取得
    var preview_num = $(this).parent();
    var target_num = $(preview_num).data('preview')

  //プレビュー要素を削除
    preview_num.remove();

  //input要素を削除
    $(`#item_images_attributes_${target_num}_src`).remove();
    $('').prop("checked", true);

    // db保存済みの画像を削除
    var destroy_num = $(`#destroy-box_${target_num}`)
    destroy_num.prop("checked", true);

    //削除時のラベルのサイズ変更
    let remove_num = $("#previews").children().length
    let remove_items_width = remove_num*123.5
    let remove_label_width = 615 - remove_items_width
    let remove_down_num = $("#previews").children().length - 5
    let remove_down_items_width = remove_down_num*123.5
    let remove_down_label_width = 615 - remove_down_items_width
    if (remove_num == 0 || remove_num == 5) {
      $(".item-photo__area--label").css("width", "100%")
      $("#previews").css("width", remove_items_width)
      $(".label-text").css("display", "block")
    } else if (remove_num >= 1 && remove_num <= 4){
      $(".item-photo__area--label").css({"width":remove_label_width, "position":"absolute", "right":"0", "top":"0"})
      $("#previews").css("width", remove_items_width)
      $(".item-photo__area").css("position", "relative")
      $(".sell-photo").css("height", "231px")
    } else {
      $(".item-photo__area--label").css({"width":remove_down_label_width, "display":"block"})
      }
    }
  );

  // 商品説明の字数カウント
  $(".item-info--description__textarea").keyup(function(){
    let count = $(this).val().length;
    $("#words-count").text(count);
  });

  //販売手数料の計算
  $('#item_price').on('change',function(){
    let value = $(this).val();
    if(value >= 300 && value <= 9999999){
      let commission = Math.floor(value * 0.1);
      let profit = (value - commission);
      $('.commission--amount').text('¥' + commission);
      $('.profit--amount').text('¥' + profit);
    }else{
      $('.commission--amount').html('ー');
      $('.profit--amount').html('ー');
      
    }
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
  $('.form-content').on('submit',function(e){
    $(".sell-footer__button--blue").prop("disabled", false);  // submitボタンのdisableを解除
    $(".sell-footer__button--blue").removeAttr("data-disable-with");  // submitボタンのdisableを解除(Rails5.0以降はこちらも必要)
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

  //親カテゴリーのエラーハンドリング
  $('#category-parent').on('blur',function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-category').text('選択してください');
      $(this).css('border-color','red');
      }
    else{
      $('#error-category').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
  // 子カテゴリーのエラーハンドル
  $(document).on('blur','#category-children',function(){
    let value = $(this).val();
    if(value == ""){
      $(this).css('border-color','red');
      }
    else{
      $('#error-category').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
  // 孫カテゴリーのエラーハンドル
  $(document).on('blur','#category-grandchildren',function(){
    let value = $(this).val();
    if(value == ""){
      $(this).css('border-color','red');
      }
    else{
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
    // fileIndexの先頭の数字を使ってinputを作る
    $('#image-box').append(buildFileField(fileIndex[0]));
    fileIndex.shift();
    // 末尾の数に1足した数を追加する
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
  });

  $('#image-box').on('click', '.js-remove', function() {
    $(this).parent().remove();
    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
  });
});
