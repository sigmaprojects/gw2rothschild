<cfscript>
	
ius = getModel('ItemUpdateService');


id = 31086;
tid = createuuid();

ius.updateItemFromAnet(id,tid);



abort;
	
</cfscript>