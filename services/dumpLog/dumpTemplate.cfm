<cfoutput><!DOCTYPE html>
<html>
    <head>
        <title>Dump #HTMLEditFormat( structKeyList( dumps, ", " ) )#</title>
    </head>
    <body>
        <cfloop collection="#dumps#" item="key">
            <cfdump var="#dumps[ key ]#" label="#key#" />
        </cfloop>
    </body>
</html>
</cfoutput>