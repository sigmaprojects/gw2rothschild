<cfscript>

itemService = getModel('ItemService');

uri = 'http://www.gw2spidy.com/api/v0.9/json/all-items/all';
cfhttp = new http(url=uri,method='get').send().getPrefix(); 

json = deSerializeJson( cfhttp.fileContent );

writedump(var=json,top=4);
abort;
for(itemdata in json.results) {
	item = ItemService.new(itemdata);
	item.setID( itemdata.data_id );
	
	
	itemService.save(item);
}

</cfscript>


<cfabort>