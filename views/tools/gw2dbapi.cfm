<cfscript>

dbus = getModel('GW2DBUpdateService');
dbus.updateItems();

/*
gw2dbapi = new gw2rothchild.lib.cfgw2dbapi.cfGW2DBAPI();
	
i = gw2dbapi.getAllItems();

writedump(var=i,top=2);
*/
abort;
</cfscript>