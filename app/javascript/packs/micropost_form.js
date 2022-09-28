$('#micropost_image').bind('change', function(){
  var size_in_metabytes = this.files[0].size/1024/1024;
  if(size_in_metabytes > 5){
    alert(I18n.t('error_alert'));
  }
});
