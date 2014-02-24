<cfsetting showdebugoutput="false">
<cfset event.showdebugpanel("false")>
<cfset viewContent = renderView() />
<cftry>
	<cfset getMyPlugin('JSMin').minifyToHead( ArrayToList(Event.getAssets(type='js')) ) />
	<cfcatch></cfcatch>
</cftry>

<cftry>
	<cfset getMyPlugin('JSMin').minifyToHead( ArrayToList(Event.getAssets(type='css')) ) />
	<cfcatch></cfcatch>
</cftry>
<cfoutput>#viewContent#</cfoutput>