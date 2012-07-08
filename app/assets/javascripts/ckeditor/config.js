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
    config.height = '500'

}