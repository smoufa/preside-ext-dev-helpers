component extends="preside.system.handlers.admin.SystemInformation" {

	public void function index( event, rc, prc ) {
		var tab = rc.tab ?: "";
		var tabs = [ "general", "extensions", "healthchecks", "heartbeats" ];

		if ( isFeatureEnabled( "featureInfo" ) ) {
			tabs.append( "features" );
		}

		if ( !tabs.findNoCase( tab ) ) {
			tab = tabs[ 1 ];
		}

		prc.renderedTab = renderViewlet( event="admin.systemInformation._#tab#Tab", args={} );

		prc.pageTitle = translateResource( "cms:systemInformation.menu.title" );
		prc.tabs = [];

		for( var theTab in tabs ) {
			prc.tabs.append({
				  active    = theTab == tab
				, link      = event.buildAdminLink( linkto="systemInformation", queryString="tab=#theTab#" )
				, title     = translateResource( "cms:systemInformation.tab.#theTab#.title" )
				, iconClass = translateResource( "cms:systemInformation.tab.#theTab#.iconClass" )
			});
		}
	}

// viewlets
	private string function _featuresTab( event, rc, prc, args={} ) {
		var getDescriptions = function( k,v ) {
			return translateResource( uri="features:features.#k#.description", defaultValue="#v.description ?: ''#" );
		}

		var features = getSetting( "features" );

		var enabledFeatures = structFilter( features, function( key, value ) {
		     return isTrue( value.enabled ?: false );
		});
		var disabledFeatures = structFilter( features, function( key, value ) {
		     return !isTrue( value.enabled ?: false );
		});

		args.enabledFeatures = structMap( enabledFeatures, getDescriptions);
		args.disabledFeatures = structMap( disabledFeatures, getDescriptions);

		return renderView( view="/admin/systemInformation/_featuresTab", args=args );
	}
}