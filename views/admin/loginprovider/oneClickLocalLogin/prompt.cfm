<cfif isFeatureEnabled( "oneClickLocalLogin" )>
	<cfoutput>
		<p class="text-center">
			<a class="btn btn-info" href="#event.buildAdminLink( "loginProvider.oneClickLocalLogin.dologin" )#">
				<i class="fa fa-key fa-fw"></i> 
				#translateResource( "cms:one.click.local.login.btn" )#
			</a>
		</p>
	</cfoutput>
</cfif>