// original
javascript:(function(){
  var URL = 'http://mustachio.heroku.com/magickly?mustachify=true&src=';
  var images = document.getElementsByTagName('img');
  var i;
  for (i = 0; i < images.length; i += 1){
    var image = images[i];
    var src = image.getAttribute('src');
    if (image.src[0] === '/'){
      image.setAttribute('src', URL + window.location.origin + src);
    } else if (src.match(/^https?:\/\//)) {
      image.setAttribute('src', URL + src);
    }
  }
})();

// JSMin'd
javascript:(function(){var URL='http://mustachio.heroku.com/magickly?mustachify=true&src=';var images=document.getElementsByTagName('img');var i;for(i=0;i<images.length;i+=1){var image=images[i];var src=image.getAttribute('src');if(image.src[0]==='/'){image.setAttribute('src',URL+window.location.origin+src);}else if(src.match(/^https?:\/\//)){image.setAttribute('src',URL+src);}}})();
