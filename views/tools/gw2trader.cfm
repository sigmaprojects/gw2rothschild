<cfscript>
	
	

//uri = 'http://api.guildwarstrade.com/1/items?ids=123,345,684,654,356,178&fields=name,sell,buy,supply,demand,category,img';
uri = 'http://api.guildwarstrade.com/1/bulk/items.json';


httpService = new http();
httpService.setMethod('get');
httpService.setURL( uri );
	
result = httpService.send().getPrefix();

j = deSerializeJson(result.filecontent);

writedump(var=j,top=5);


api = new model.cfgw2tradeapi.cfGW2TradeAPI();

r = api.getItems();

writedump(var=r,top=3); 

abort;
</cfscript>
