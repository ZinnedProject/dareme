CKEDITOR.editorConfig = function( config )
{
    config.toolbar_MyToolbar =
 [   
//http://docs.cksource.com/CKEditor_3.x/Developers_Guide/Toolbar
    { name: 'basicstyles', items : [ 'Bold','Italic','Underline','-','RemoveFormat' ] },
    { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent',
    '-','JustifyLeft','JustifyCenter'] },
    { name: 'links', items : [ 'Link','Unlink'] },
    { name: 'insert', items : [ 'Image','Smiley'] },
    '/',
    { name: 'styles', items : ['Format','Font','FontSize' ] },
    { name: 'colors', items : [ 'TextColor'] },
    { name: 'tools', items : [ 'Maximize', '-','About' ] }
];

    config.toolbar = 'MyToolbar';

    config.language = 'en'
    //config.width = '725'
    config.height = '300'

 // The location of a script that handles file uploads in the Image dialog.
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";

 // Rails CSRF token
  config.filebrowserParams = function(){
    var csrf_token = jQuery('meta[name=csrf-token]').attr('content'),
        csrf_param = jQuery('meta[name=csrf-param]').attr('content'),
        params = new Object();
    
    if (csrf_param !== undefined && csrf_token !== undefined) {
      params[csrf_param] = csrf_token;
    }
    
    return params;
  };
  
  config.addQueryString = function( url, params ){
    var queryString = [];

    if ( !params )
      return url;
    else
    {
      for ( var i in params )
        queryString.push( i + "=" + encodeURIComponent( params[ i ] ) );
    }

    return url + ( ( url.indexOf( "?" ) != -1 ) ? "&" : "?" ) + queryString.join( "&" );
  };
  
  // Integrate Rails CSRF token into file upload dialogs (link, image, attachment and flash)
  CKEDITOR.on( 'dialogDefinition', function( ev ){
    // Take the dialog name and its definition from the event data.
    var dialogName = ev.data.name;
    var dialogDefinition = ev.data.definition;
    var content, upload;
    
    if (jQuery.inArray(dialogName, ['link', 'image', 'attachment', 'flash']) > -1) {
      content = (dialogDefinition.getContents('Upload') || dialogDefinition.getContents('upload'));
      upload = (content == null ? null : content.get('upload'));
      
      if (upload && upload.filebrowser['params'] == null) {
        upload.filebrowser['params'] = config.filebrowserParams();
        upload.action = config.addQueryString(upload.action, upload.filebrowser['params']);
      }
    }
  });

}