component {

	public void function dologin( event, rc, prc ) {
		var environment = getSetting( name="environment", defaultValue="unknown" );
		if ( environment == "local" && isFeatureEnabled( "oneClickLocalLogin" ) ) {
			event.doAdminSsoLogin( 
				  loginId              = "sysadmin"
				, userData             = {
					  email_address = "test@test.com"
					, known_as      = "System Administrator"
				}
				, rememberLogin        = true
				, rememberExpiryInDays = 90
			);
		}
	}
}