<cfscript>

cfGW2SpidyAPI = new lib.cfgw2spidyapi.cfGW2SpidyAPI();



//writedump( var=cfGW2SpidyAPI.getGemPrice(), top=3 );

r = cfGW2SpidyAPI.getAllItems();
writedump(var=r,top=2);




abort;
</cfscript>