component extends="coldbox.system.Interceptor" {

	public void function configure() {}

	public void function afterConfigurationLoad( event, interceptData ) {
		var settings          = getController().getConfigSettings();
		var features          = settings.features           ?: {};
		var localLoginFeature = features.oneClickLocalLogin ?: {};
		var environment       = settings.environment        ?: "";
		
		// only append the one-click local login provider in case the feature is enabled and the environment is local
		if ( environment != "local" ) {
			localLoginFeature.enabled = false;
		}
		
		if ( isBoolean( localLoginFeature.enabled ?: "" ) && localLoginFeature.enabled ) {
			settings.adminLoginProviders.prepend( "oneClickLocalLogin" );
		}		
	}
}
