<cfscript>
	logs = prc.logs ?: [];
</cfscript>

<cfoutput>
	<cfif not logs.len()>
		<p><em>There are no dump logs to see here.</em></p>
	<cfelse>
		<div class="top-right-button-group">
			<a class="pull-right inline red confirmation-prompt" href="#event.buildAdminLink( linkTo='dumpLogs.deleteAllAction' )#" data-global-key="c" title="#translateResource( "cms:dumpLogs.delete.all.logs.link" )#">
				<button class="btn btn-danger btn-sm">
					<i class="fa fa-trash"></i>
					#translateResource( "cms:dumpLogs.delete.all.logs.btn" )#
				</button>
			</a>
		</div>


		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th>#translateResource( "cms:dumpLogs.table.header.date" )#</th>
					<th>#translateResource( "cms:dumpLogs.table.header.filename" )#</th>
					<th>#translateResource( "cms:dumpLogs.table.header.title" )#</th>
					<th>#translateResource( "cms:dumpLogs.table.header.actions" )#</th>
				</tr>
			</thead>
			<tbody data-nav-list="1" data-nav-list-child-selector="> tr">
				<cfloop array="#logs#" index="i" item="log">
					<tr class="clickable" data-context-container="1">
						<td>#renderContent( "datetime", log.date, [ "admindatatable", "admin" ] )#</td>
						<td>
							<a href="#event.buildAdminLink( linkTo='dumpLogs.view', queryString='log=' & log.filename )#" data-context-key="v" target="_blank">
								<i class="fa fa-fw fa-external-link"></i> #log.filename#
							</a>
						</td>
						<td>
							<span data-rel="popover" data-trigger="hover" data-placement="left" data-content="#HtmlEditFormat( '<pre>#log.title#</pre>' )#" data-html="true">#left( log.title, "30" )#...</span>
						</td>
						<td>
							<div class="action-buttons btn-group">
								<a class="red confirmation-prompt" href="#event.buildAdminLink( linkTo='dumpLogs.deleteLogAction', queryString='log=' & log.filename )#" data-context-key="d" title="#translateResource( "cms:dumpLogs.delete.log.link" )#">
									<i class="fa fa-trash"></i>
								</a>
							</div>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	</cfif>
</cfoutput>