component extends="preside.system.base.AdminHandler" {

	property name="messagebox"     inject="messagebox@cbmessagebox";
	property name="dumpLogService" inject="dumpLogService";

	public void function preHandler( event ) {
		super.preHandler( argumentCollection=arguments );

		prc.pageIcon = "fa-bug";
		event.addAdminBreadCrumb(
			  title = translateResource( "cms:dumpLogs.breadcrumbTitle" )
			, link  = event.buildAdminLink( linkTo="dumpLogs" )
		);
	}

	public void function index( event, rc, prc ) {
		prc.logs  = dumpLogService.listDumpLogs();

		prc.pageTitle    = translateResource( "cms:dumpLogs.page.title" );
		prc.pageSubTitle = translateResource( "cms:dumpLogs.page.subtitle" );
	}

	public void function view( event, rc, prc ) {
		var log = dumpLogService.readDumpLog( rc.log ?: "" );

		if ( Len( Trim( log ) ) ) {
			event.renderData( data=log, type="HTML" );
		}
	}

	public void function deleteLogAction( event, rc, prc ) {
		dumpLogService.deleteDumpLog( rc.log ?: "" );
		messagebox.info( translateResource( "cms:dumpLogs.log.deleted.confirmation" ) );
		setNextEvent( url=event.buildAdminLink( "dumpLogs" ) );
	}

	public void function deleteAllAction( event, rc, prc ) {
		dumpLogService.deleteAllDumpLogs();
		messagebox.info( translateResource( "cms:dumpLogs.all.logs.deleted.confirmation" ) );
		setNextEvent( url=event.buildAdminLink( "dumpLogs" ) );
	}
}