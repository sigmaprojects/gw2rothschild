<cfscript>


writedump(var=application.executorService.getStatus(),label="executorService Status");



writedump(var=application.ItemUpdateTask.getResults(),label="ItemUpdateTask Run Count: #application.ItemUpdateTask.getResults().runCount#")
writedump(var=application.ItemUpdateTask.getRunStatus(),label="Task Status");




writedump(var=application.MarketDataUpdateTask.getResults(),label="ItemUpdateTask Run Count: #application.MarketDataUpdateTask.getResults().runCount#")
writedump(var=application.MarketDataUpdateTask.getRunStatus(),label="Task Status");




writedump(application.executorService);
</cfscript>





<cfabort>