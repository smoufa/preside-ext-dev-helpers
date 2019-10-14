<cfif ( isFeatureEnabled( "dumpLogs" ) && hasCmsPermission( "dumpLogs.navigate" ) )>
	<cfoutput>
		<li>
			<a href="#event.buildAdminLink( linkTo="dumpLogs" )#">
				<i class="fa fa-fw fa-bug"></i>
				#translateResource( "cms:dumpLogs" )#
			</a>
		</li>
	</cfoutput>
</cfif>