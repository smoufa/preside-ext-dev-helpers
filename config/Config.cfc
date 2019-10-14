component {
    
    public void function configure( required struct config ) {
        
        var conf     = arguments.config;
		var settings = conf.settings;

        settings.features.oneClickLocalLogin = { enabled=false, siteTemplates=[ "*" ], widgets=[] };
        settings.features.dumpLogs           = { enabled=false, siteTemplates=[ "*" ], widgets=[] };
        settings.features.devQuickLinks      = { enabled=false, siteTemplates=[ "*" ], widgets=[] };

        settings.adminConfigurationMenuItems.append( "dumpLogs" );

        settings.adminPermissions[ "dumpLogs" ] = [ "navigate" ];

        settings.adminRoles.sysAdmin.append( "dumpLogs.*" );
        
        conf.interceptors.prepend( { class="app.extensions.preside-ext-dev-helpers.interceptors.OneClickLoginDelayedConfigLoader", properties={} } );
        conf.interceptors.prepend( { class="app.extensions.preside-ext-dev-helpers.interceptors.AdminDevQuickLinksInjector"      , properties={} } );
    }
}