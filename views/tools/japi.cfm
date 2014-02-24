<cfscript>
	
	
t = createObject('java','javax.net.ssl.HttpsURLConnection');
writedump(t);


s = createObject('java','com.sun.net.ssl.internal.www.protocol.https.HttpsURLConnectionOldImpl');
writedump(s);


api = createObject('java','cz.zweistein.gw2.api.GW2API');
		
writedump(api);

recipes = api.getRecipes();

writedump(recipes);
abort;
	



abort;
</cfscript>