<cffunction name="dumplog" returntype="void" access="public" output="false">
    <cfset getSingleton( "dumpLogService" ).dumplog( argumentCollection=arguments ) />
</cffunction>