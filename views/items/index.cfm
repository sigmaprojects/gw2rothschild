<cfset Event.addAssets('
	/includes/javascript/items/itemsearch.js,
	/includes/javascript/watchlist/watchlist.js,
	/includes/javascript/alerts/alerts.js,
	/includes/javascript/lib/typeahead.min.js,
	/includes/javascript/lib/hogan-2.0.0.js
') />
<script type="text/javascript">
$(document).ready(function() {
	new ItemSearch();
	new Watchlist();
	new Alerts();
});
</script>
<style type="text/css">
</style>
<cfoutput>


<br />
<cfif rc.watchlist && !prc.isLoggedIn>
	<div class="alert alert-info">
		To use the watchlist feature, you need to be logged in.
	</div>
</cfif>
<br />

<div class="container">
	<form method="get" action="#Event.buildLink('items.index')#" class="form-inline" role="form" id="searchitemsform">
		<div class="row">
			<div class="span12">
				<input type="hidden" name="page" value="#rc.page#" />
				<input type="hidden" name="sortorder" value="#rc.sortorder#" />
				<input type="hidden" name="watchlist" value="#rc.watchlist#" />

				<div class="form-group" data-toggle="tooltip" title="Item Type">
					<select name="itemtype_name" id="itemtype_name" data-placeholder="Item Types" class="chosen-select form-control" multiple="multiple" style="width:210px;">
						<cfloop array="#rc.ItemTypes#" index="ItemType">
							<option value="#ItemType['item_type']#" <cfif arrayContains(listToArray(rc.itemtype_name),ItemType['item_type'])>selected</cfif>>#ItemType['item_type']#</option>
						</cfloop>
					</select>
				</div>
				
				&nbsp; &nbsp;
				<div class="form-group" data-toggle="tooltip" title="Item Rarity">
					<select name="rarity_id" id="rarity_id" data-placeholder="Rarities" class="chosen-select form-control" multiple="multiple" style="width:210px;">
						<cfloop query="rc.Rarities">
							<option value="#id#" <cfif arrayContains(listToArray(rc.rarity_id),ID)>selected</cfif>>#Name#</option>
						</cfloop>
					</select>
				</div>

				&nbsp; &nbsp;  
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Keyword" name="keyword" value="#rc.keyword#" data-toggle="tooltip" title="Item keyword">
				</div>

				&nbsp; &nbsp;  
				<div class="form-group">
					<input type="text" class="form-control" placeholder="0" name="level_range" style="width:45px;" value="#listGetAt(rc.level_range,1)#" data-toggle="tooltip" title="Level Range From">
					<input type="text" class="form-control" placeholder="80" name="level_range" style="width:45px;" value="#listGetAt(rc.level_range,2)#" data-toggle="tooltip" title="Level Range To">
				</div>
				
				&nbsp; &nbsp;
				<div class="form-group" data-toggle="tooltip" title="Per Page">
					<select name="per_page" id="per_page" data-placeholder="Per page" class="chosen-select form-control" style="width:80px;">
						<cfloop from="50" to="200" index="i" step="50">
							<option value="#i#" <cfif rc.per_page eq i>selected</cfif>>#i#</option>
						</cfloop>
					</select>
				</div>
				
				&nbsp; &nbsp;
				<div class="form-group" data-toggle="tooltip" title="Sorting Options">
					<select name="sortorder_" id="sortorder_" data-placeholder="Sort" class="chosen-select form-control" multiple style="width:260px;">
						<option value="name asc" <cfif arrayContains(rc.sortOrderArr,'name asc')>selected</cfif>>Name  &uarr;</option>
						<option value="name desc" <cfif arrayContains(rc.sortOrderArr,'name desc')>selected</cfif>>Name &darr;</option>
						
						<option value="level asc" <cfif arrayContains(rc.sortOrderArr,'level asc')>selected</cfif>>Level  &uarr;</option>
						<option value="level desc" <cfif arrayContains(rc.sortOrderArr,'level desc')>selected</cfif>>Level &darr;</option>
						
						<option value="rarity_id asc" <cfif arrayContains(rc.sortOrderArr,'rarity_id asc')>selected</cfif>>Rarity  &uarr;</option>
						<option value="rarity_id desc" <cfif arrayContains(rc.sortOrderArr,'rarity_id desc')>selected</cfif>>Rarity &darr;</option>
						
						<option value="itemtype_name asc" <cfif arrayContains(rc.sortOrderArr,'itemtype_name asc')>selected</cfif>>Type  &uarr;</option>
						<option value="itemtype_name desc" <cfif arrayContains(rc.sortOrderArr,'itemtype_name desc')>selected</cfif>>Type &darr;</option>
						
						<option value="supply asc" <cfif arrayContains(rc.sortOrderArr,'supply asc')>selected</cfif>>Supply  &uarr;</option>
						<option value="supply desc" <cfif arrayContains(rc.sortOrderArr,'supply desc')>selected</cfif>>Supply &darr;</option>
						
						<option value="demand asc" <cfif arrayContains(rc.sortOrderArr,'demand asc')>selected</cfif>>Demand  &uarr;</option>
						<option value="demand desc" <cfif arrayContains(rc.sortOrderArr,'demand desc')>selected</cfif>>Demand &darr;</option>
						
						<option value="last_min_sale asc" <cfif arrayContains(rc.sortOrderArr,'last_min_sale asc')>selected</cfif>>Max Sale Price  &uarr;</option>
						<option value="last_min_sale desc" <cfif arrayContains(rc.sortOrderArr,'last_min_sale desc')>selected</cfif>>Max Sale Price &darr;</option>
						
						<option value="last_max_offer asc" <cfif arrayContains(rc.sortOrderArr,'last_max_offer asc')>selected</cfif>>Max Buy Price  &uarr;</option>
						<option value="last_max_offer desc" <cfif arrayContains(rc.sortOrderArr,'last_max_offer desc')>selected</cfif>>Max Buy Price &darr;</option>
						
						<option value="upgradecomponent_price_difference asc" <cfif arrayContains(rc.sortOrderArr,'upgradecomponent_price_difference asc')>selected</cfif>>Component Difference &uarr;</option>
						<option value="upgradecomponent_price_difference desc" <cfif arrayContains(rc.sortOrderArr,'upgradecomponent_price_difference desc')>selected</cfif>>Component Difference &darr;</option>
						
						
					</select>
				</div>

			</div>
		</div>
		
		<br />
		
		<div class="row">
			<div class="span12">
				
				<div class="checkbox form-group col-lg-2" data-toggle="tooltip" title="Item has an Upgrade Component">
					<label>
						<input type="checkbox" name="hasupgradecomponent" value="true" <cfif rc.hasUpgradeComponent>checked</cfif>> Upgraded
					</label>
				</div>
				
				<cfif prc.isLoggedIn>
					<div class="checkbox form-group col-lg-2" data-toggle="tooltip" title="Show my watchlist items">
						<label>
							<input type="checkbox" name="watchlist" value="true" <cfif rc.watchlist>checked</cfif>> Watchlist
						</label>
					</div>
				</cfif>
				
				<div class="form-group">
					<button type="submit" class="btn btn-default form-control">Submit</button>
				</div>

			</div>
		</div>
		
	</form>
</div>

<br />

<!---
<div class="modal fade" id="alertwindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
--->

<div class="panel panel-default">
	<table class="table vmiddle" id="itemtable">
		<thead>
			<tr>
				<th class="sort text-primary" data-param="sortorder" data-value="name #(rc.sortorder eq 'name asc' ? 'desc' : 'asc')#">Name</th>
				<th class="sort text-primary" data-param="sortorder" data-value="level #(rc.sortorder eq 'level asc' ? 'desc' : 'asc')#">Level</th>
				<th class="sort text-primary" data-param="sortorder" data-value="rarity_id #(rc.sortorder eq 'rarity_id asc' ? 'desc' : 'asc')#">Rarity</th>
				<th class="sort text-primary" data-param="sortorder" data-value="itemtype_name #(rc.sortorder eq 'itemtype_name asc' ? 'desc' : 'asc')#">Type</th>
				<th class="sort text-primary" data-param="sortorder" data-value="supply #(rc.sortorder eq 'supply asc' ? 'desc' : 'asc')#">Supply</th>
				<th class="sort text-primary" data-param="sortorder" data-value="demand #(rc.sortorder eq 'demand asc' ? 'desc' : 'asc')#">Demand</th>
				<th class="sort text-primary" data-param="sortorder" data-value="last_min_sale #(rc.sortorder eq 'last_min_sale asc' ? 'desc' : 'asc')#">Sale</th>
				<th class="sort text-primary" data-param="sortorder" data-value="last_max_offer #(rc.sortorder eq 'last_max_offer asc' ? 'desc' : 'asc')#">Buy</th>
				<cfif rc.hasUpgradeComponent>
					<th class="sort text-primary" data-param="sortorder" data-value="upgradecomponent_price_difference #(rc.sortorder eq 'upgradecomponent_price_difference asc' ? 'desc' : 'asc')#">C-Diff</th>
				</cfif>
				<th></th>
				<cfif prc.isLoggedIn>
					<th></th>
				</cfif>
			</tr>
		</thead>
		<tbody>
			<cfloop array="#rc.Items.Entries#" index="Item">
        	    <tr
        	    	class="item"
					data-id="#Item.getID()#"
					data-marketupdated="#DateFormat(Item.getMarketUpdated(),'mm/dd/yyyy') & ' ' & TimeFormat(Item.getMarketUpdated(),'hh:mm:ss TT')#"
				>
					<td>
						<!---
							<a href="#Event.buildLink(linkTo='alerts.edit',queryString='item_id=#Item.getID()#')#" data-toggle="modal" data-keyboard="true" data-remote="#Event.buildLink(linkTo='alerts.edit',queryString='item_id=#Item.getID()#')#" data-target="##alertwindow">x</a>
						--->
						<a href="#Event.buildLink(linkTo='items.view',queryString=Item.getID())#">
							#Item.getName()#
						</a>
					</td>
					<td>#Item.getLevel()#</td>
					<td>
						<cfif Item.hasRarity()>
							#Item.getRarity().getName()#
						</cfif>
					</td>
					<td>
						<cfif Item.hasItemType()>
							#Item.getItemType()._getItem_Type()#
						</cfif>
					</td>
					<td>
						#Item.getSupply()#
					</td>
					<td>
						#Item.getDemand()#
					</td>
					<td class="price" data-amount="#Item.getLast_Min_Sale()#">
						#Item.getLast_Min_Sale()#
					</td>
					<td class="price" data-amount="#Item.getLast_Max_Offer()#">
						#Item.getLast_Max_Offer()#
					</td>

					<cfif rc.hasUpgradeComponent>
						<td rowspan="2" class="price" data-amount="#Item.getUpgradeComponent_Price_Difference()#">
							#Item.getUpgradeComponent_Price_Difference()#
						</td>
					</cfif>
					<td>
						<img src="#Item.getImageSrc()#" width="30" height="30" style="ver" />
					</td>
					<cfif prc.isLoggedIn>
						<td class="nopad">
							<cfif getModel('WatchlistService').isUserWatching(Item,prc._user.id) eq true>
								<span class="glyphicon glyphicon-star unwatch" data-item_id="#Item.getID()#" title="Remove from watchlist"></span>
							<cfelse>
								<span class="glyphicon glyphicon-star-empty watch" data-item_id="#Item.getID()#" title="Add to watchlist"></span>
							</cfif>
						</td>
						<td class="nopad">
							<span class="glyphicon glyphicon-bell editalert" data-item_id="#Item.getID()#" title="Setup Alerts"></span>
						</td>
					</cfif>
				</tr>
				<cfif Item.hasUpgradeComponent()>
					<cfset SubItem = Item.getUpgradeComponent() />
					<tr
						class="sub item"
						data-id="#SubItem.getID()#"
						<!---data-marketupdated="#SubItem.getMarketUpdated()#"--->
						data-marketupdated="#DateFormat(Item.getMarketUpdated(),'mm/dd/yyyy') & ' ' & TimeFormat(Item.getMarketUpdated(),'hh:mm:ss TT')#"
					>
						<td colspan="4">
							&nbsp; &nbsp; <a href="#Event.buildLink(linkTo='items.view',queryString=SubItem.getID())#">#SubItem.getName()#</a>
						</td>
						<td>
							#SubItem.getSupply()#
						</td>
						<td>
							#SubItem.getDemand()#
						</td>
						<td class="price" data-amount="#SubItem.getLast_Min_Sale()#">
							#SubItem.getLast_Min_Sale()#
						</td>
						<td class="price" data-amount="#SubItem.getLast_Max_Offer()#">
							#SubItem.getLast_Max_Offer()#
						</td>
						<td>
							<img src="#SubItem.getImageSrc()#" width="30" height="30" style="ver" />
						</td>
						<cfif prc.isLoggedIn>
							<td class="nopad">
								<cfif getModel('WatchlistService').isUserWatching(SubItem,prc._user.id) eq true>
									<span class="glyphicon glyphicon-star unwatch" data-item_id="#SubItem.getID()#" title="Remove from watchlist"></span>
								<cfelse>
									<span class="glyphicon glyphicon-star-empty watch" data-item_id="#SubItem.getID()#" title="Add to watchlist"></span>
								</cfif>
							</td>
							<td class="nopad">
								<span class="glyphicon glyphicon-bell editalert" data-item_id="#SubItem.getID()#" title="Setup Alerts"></span>
							</td>
						</cfif>
					</tr>
				</cfif>
			</cfloop>
		</tbody>
	</table>

	<div align="center">
		<cfset plink = event.buildLink(linkTo='items.index/page/@page@') />
		#rc.Paging.renderit(rc.Items.count, plink )#
	</div>

</div>


</cfoutput>