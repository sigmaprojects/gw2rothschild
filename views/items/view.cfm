<cfset Event.addAssets('
	/includes/javascript/lib/jquery-migrate-1.2.1.min.js,
	/includes/javascript/lib/highcharts/js/highstock.js,
	/includes/javascript/lib/highcharts/js/modules/exporting.js,
	/includes/javascript/lib/moment-langs.min.js,
	/includes/javascript/lib/tt.js,
	/includes/javascript/items/itemview.js,
	/includes/javascript/watchlist/watchlist.js
') />

<!---
<script type="text/javascript" src="http://static-ascalon.cursecdn.com/current/js/syndication/tt.js"></script>
--->
<script type="text/javascript">
$(function() {

	ItemViewObj = new ItemView();
	ItemViewObj.setItem_ID( <cfoutput>#rc.Item.getID()#</cfoutput> );
	ItemViewObj.setupCharts();
	new Watchlist();

});
</script>



<cfoutput>

<div class="row-fluid" style="margin-left:3%; margin-right:3%;">

	<h2>
		<img src="#rc.Item.getImageSrc()#" width="30" height="30" />
		<!---
		<cfif !IsNull(rc.Item.getGW2DB_External_ID()) && isNumeric(rc.Item.getGW2DB_External_ID()) && rc.Item.getGW2DB_External_ID() gt 0>
			<a href="http://www.gw2db.com/items/#rc.Item.getGW2DB_External_ID()#">#rc.Item.getName()#</a>
		<cfelse>
			#rc.Item.getName()#
		</cfif>
		--->
		#rc.Item.getName()#

		
		<cfif prc.isLoggedIn>
			<div style="float:right;">
				<cfif getModel('WatchlistService').isUserWatching(rc.Item,prc._user.id) eq true>
					<span class="glyphicon glyphicon-star unwatch" data-item_id="#rc.Item.getID()#" title="Remove from watchlist"></span>
				<cfelse>
					<span class="glyphicon glyphicon-star-empty watch" data-item_id="#rc.Item.getID()#" title="Add to watchlist"></span>
				</cfif>
			</div>
		</cfif>

	</h2>



	<table class="table">
		<tr>
			<td><strong>Sell</strong></td>
			<td class="align-right gw2currency" data-amount="#rc.Item.getLast_Min_Sale()#"></td>
		
			<td><strong>Buy</strong></td>
			<td class="align-right gw2currency" data-amount="#rc.Item.getLast_Max_Offer()#"></td>

			<td><strong>Rarity</strong>
			</td>
			<td class="text-left"><cfif rc.Item.hasRarity()>#rc.Item.getRarity().getName()#</cfif>
			</td>
			
			<td><strong>Level</strong></td>
			<td>#rc.Item.getLevel()#</td>

		</tr>
		<tr>

			<td><strong>Supply</strong></td>
			<td class="text-left">#rc.Item.getSupply()#</td>
			
			<td><strong>Demand</strong></td>
			<td>#rc.Item.getDemand()#</td>
			
			<td><strong>Last Update:</strong></td>
			<td class="text-left">
				<cftry>
					<cfset lastUpdate = getModel('MarketDataUpdateService').getLastUpdated() />
					<cfif !IsNull(lastUpdate) && isDate(lastUpdate)>
						#relativeDate( DateConvert( "UTC2Local", lastUpdate) )#
					</cfif>
					<cfcatch type="any"></cfcatch>
				</cftry>
			</td>
					
			<td><strong>Last Changed</strong></td>
			<td class="text-left">
				<cftry>
					#relativeDate(DateConvert( "UTC2Local", rc.Item.getMarketUpdated() ))#
					<cfcatch type="any"></cfcatch>
				</cftry>
			</td>
			
		</tr>
	</table>


	<div id="price_chart" style="height:300px"></div>
	<p></p>
	<div id="volume_chart" style="height:300px"></div>

</div>
</cfoutput>
