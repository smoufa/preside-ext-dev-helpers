# Preside Extension: Development Helpers

This is an extension for [Preside](https://www.preside.org) to provide some useful small helpers for local development.

* an easy way for developers to login to the Preside Admin locally with one click
* quick links to reload the app and show the Preside console
* ability to log data dumps

Attention: Use with extreme caution and on your own risk. This is purely intended to be used on local developer machines, not in any other environment.

## Installation

From the root of your application, type the following command in a terminal:

    box install preside-ext-dev-helpers --saveDev

## Usage

### One-Click Local Login
Within your application's Config.cfc, enable it:

    settings.features.oneClickLocalLogin.enabled = true;

The Admin Login changes (only locally) adding a simple button to click for login (no credentials needed). The logged-in user has sysadmin permissions.
The traditional login is still available optionally.
(This makes use of the [Preside Admin Login Provider](https://docs.preside.org/devguides/adminloginproviders.html) concept).

### Preside Admin Quick Links
Within your application's Config.cfc, enable it:

    settings.features.devQuickLinks.enabled = true;

Within the Preside Admin on the right side of the bread crumb navigation, you will find 2 links:

* console - toggles the Developer console (tough to get to on some non-english keyboards)
* re-init - does a fwreinit (framework reload) on the current page

### Dump Logs
In order to use dump logs, enable the feature in your Config.cfc:

    settings.features.dumpLogs.enabled = true;

Within a handler or view, use the following

    dumpLog( myvar );
    ...
    dumpLog( myvar=myvar );
    ...
    dumpLog( a=1, b=server, c=myvar );
    ...

Or use the service, e.g. within your own service

    component {

        property name="dumpLogService" inject="dumpLogService";

        function myFunction() {

            ...
            dumpLogService.dumpLog( myvar );
            ...
            dumpLogService.dumpLog( myvar=myvar );
            ...
            dumpLogService.dumpLog( a=1, b=server, c=myvar );
            ...
        }
    }

If you are using Preside 10.11 or greater you can make use of a nice little short cut.
Instead of injecting the dumplogservice you can directly call the dumplog method as follows:

    $helpers.dumpLog( myvar );

This works on all services that are annotated as being a presideservice.

Head over to Preside Admin > System > Dump Logs to check the dumps there.

### Feature Information
Within your application's Config.cfc, enable it:

    settings.features.featureInfo.enabled = true;

It add a Features tab to the System Information page and allows an admin user to see what app features are available and enabled or disabled. Devs can also describe their features either by providing a description in the feature definition or in i18n:

i18n/features.properties:

    features.mycoolfeature.description=This is a cool feature

or in your Config.cfc:

    features.mycoolfeature = { enabled: true, description: "This is a cool feature" };

## Contribution

Feel free to fork and pull request. Any other feedback is also welcome - preferable on the Preside Slack channel.