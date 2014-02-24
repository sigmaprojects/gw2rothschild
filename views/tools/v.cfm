<cfscript>
iserv = getModel('ItemService');

i = iserv.get( event.getValue('id',9272) );
writedump(var=i,format='text');
writedump(var=i.getItemType(),format="text");
abort;
</cfscript>