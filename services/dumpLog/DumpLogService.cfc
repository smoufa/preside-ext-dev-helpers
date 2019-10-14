/**
 * @singleton true
 */
component {

// CONSTRUCTOR
    public any function init(
          string logsMapping  = "/logs"
        , string logDirectory = ExpandPath( "#arguments.logsMapping#/dump-logs" )
    ) {
        _setLogDirectory( arguments.logDirectory );

        return this;
    }

// PUBLIC API METHODS
    public void function dumpLog() {
        var rendered = "";
        var fileName = "dump-" & GetTickCount() & ".html";
        var filePath = _getLogDirectory() & "/" & filename;
        var dumps = arguments;
        var key = "";

        savecontent variable="rendered" {
            include template="dumpTemplate.cfm";
        }
        FileWrite( filePath, Trim( rendered ) );
        _cleanupLogFiles();
    }

    public array function listDumpLogs() {
        var files    = DirectoryList( _getLogDirectory(), false, "query", "dump-*.html" );
        var dumpLogs = [];

        for ( var file in files ) {
            var title    = REMatchNoCase( "<\s*title[^>]*>(.*?)<\s*\/\s*title>", FileRead( _getLogDirectory() & "/" & file.name ) );
            var dumpVars = title.len() ? ReplaceList( title[1] , "<title>,</title>", "#chr(10)# ,#chr(10)#" ) : "";

            dumpVars = replace( dumpVars, "Dump ", "" );

            dumpLogs.append( { date=file.dateLastModified, filename=file.name, title=dumpVars } );
        }

        dumpLogs.sort( function( a, b ) {
            return a.date < b.date ? 1 : -1;
        } );

        return dumpLogs;
    }

    public string function readDumpLog( required string logFile ) {
        try {
            return FileRead( _getLogDirectory() & "/" & arguments.logFile );
        }
        catch ( any e ) {
            return "";
        }
    }

    public void function deleteDumpLog( required string logFile ) {
        try {
            return FileDelete( _getLogDirectory() & "/" & arguments.logFile );
        }
        catch ( any e ) {
        }
    }

    public void function deleteAllDumpLogs() {
        listDumpLogs().each( function( item ) {
            deleteDumpLog( item.filename );
        } );
    }

// PRIVATE HELPERS
    private void function _cleanupLogFiles() {
        var files             = DirectoryList( _getLogDirectory(), false, "query", "*.html", "datelastmodified asc" );
        var maxFilesToKeep    = 50;
        var fileCountToDelete = files.recordCount - maxFilesToKeep;
        var filesDeleted      = 0;
        var currentRow        = 0;
        var fileToDelete      = "";

        while ( filesDeleted < fileCountToDelete ) {
            currentRow++;
            fileToDelete = files.directory[ currentRow ] & "/" & files.name[ currentRow ];
            try {
                FileDelete( fileToDelete );
                filesDeleted++;
            }
            catch ( any e ) {
                break;
            }
        }
    }

// GETTERS AND SETTERS
    private any function _getLogDirectory() {
        return _logDirectory;
    }
    private void function _setLogDirectory( required any logDirectory ) {
        _logDirectory = Replace( arguments.logDirectory, "\", "/", "all" );
        _logDirectory = ReReplace( _logDirectory, "/$", "" );

        if ( !DirectoryExists( _logDirectory ) ) {
            DirectoryCreate( _logDirectory, true );
        }
    }
}