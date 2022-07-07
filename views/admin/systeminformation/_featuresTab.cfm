<cfscript>
	pageTitle           = args.pageTitle ?: "";
	enabledFeatures     = args.enabledFeatures  ?: {};
	enabledFeatureNames = structKeyArray( enabledFeatures );
	arraySort( enabledFeatureNames, "textnocase", "asc" );

	disabledFeatures     = args.disabledFeatures  ?: {};
	disabledFeatureNames = structKeyArray( disabledFeatures );
	arraySort( disabledFeatureNames, "textnocase", "asc" );
</cfscript>

<cfoutput>
	<table class="table">
		<thead>
			<tr>
				<th>#translateResource( uri="cms:systeminformation.features.table.feature.th" )#</th>
				<th>#translateResource( uri="cms:systeminformation.features.table.enabled.th" )#</th>
				<th>#translateResource( uri="cms:systeminformation.features.table.description.th" )#</th>
			</tr>
		</thead>
		<tbody>
			<cfloop array="#enabledFeatureNames#" item="feature">
				<tr>
					<td>#feature#</td>
					<td>#renderContent( "boolean", true, [ "adminDatatable", "admin" ] )#</td>
					<td>#enabledFeatures[ feature ]#</td>
				</tr>
			</cfloop>
			<cfloop array="#disabledFeatureNames#" item="feature">
				<tr>
					<td>#feature#</td>
					<td>#renderContent( "boolean", false, [ "adminDatatable", "admin" ] )#</td>
					<td>#disabledFeatures[ feature ]#</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</cfoutput>