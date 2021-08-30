document.addEventListener('DOMContentLoaded', function(){
  if ( document.getElementById('item-image')){
    const ImageList = document.getElementById('image-list');

    const createImageHTML = (blob) => {
      // div要素生成
      const imageElement = document.createElement('div');
      imageElement.setAttribute('class', "image-element")
      let imageElementNum = document.querySelectorAll('.image-element').length

      // 表示する画像を生成
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('class', 'new-item-img')  // 8/30追記 プレビュー表示リサイズ用のCSS

      // ファイル選択ボタン生成
      const inputHTML = document.createElement('input')
      inputHTML.setAttribute('id', `item_image_${imageElementNum}`)
      inputHTML.setAttribute('name', 'item[images][]')
      inputHTML.setAttribute('type', 'file')

      // HTMLの要素をブラウザに表示
      imageElement.appendChild(blobImage);
      imageElement.appendChild(inputHTML);
      ImageList.appendChild(imageElement);

      inputHTML.addEventListener('change', (e) => {
        file = e.target.files[0];
        blob = window.URL.createObjectURL(file);

        createImageHTML(blob)
      var maxWidth = 300;
      var maxHeight = 300
      })
    };

    document.getElementById('item-image').addEventListener('change', function(e){
      // const imageContent = document.querySelector('img');
      // if (imageContent){
      //   imageContent.remove();
      // }
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
;
    });
  } 
});