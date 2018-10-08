$(function(){
  if(window.devicePixelRatio > 1){
    $('img[data-interchange]').each(function() {
      var retina = function() {
        $(this).unbind('load').width($(this).width()).attr('src', $(this).attr("data-interchange"));
      };
      if( this.complete ) {
        retina.apply(this)
      } else {
        $(this).on('load', retina)
      }
    });
  }
});
