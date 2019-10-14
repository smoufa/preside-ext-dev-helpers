component extends="coldbox.system.Interceptor" {

	public void function configure() {}

	public void function postLayoutRender( event, interceptData={} ) {
	
		var layout = trim( interceptData.layout ?: "" );
		
		if ( layout != "admin" ) {
		    return;
		}
		
        var renderedView = trim( renderView( view="/admin/dev/_quickConsoleAndReloadLinks" ) );
        
        if ( len( renderedView ) ) {
            interceptData.renderedLayout = ( interceptData.renderedLayout ?: "" ).reReplaceNoCase( '<ul class="breadcrumb">((.|\n)*?)</ul>', '<ul class="breadcrumb">\1</ul>#chr(10)##renderedView#' );
        }
	}
}