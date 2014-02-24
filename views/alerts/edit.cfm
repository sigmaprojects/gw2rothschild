<cfoutput>
	<div class="modal-dialog">
		<div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">
                 	<cfset Item = rc.Alert.getItem()>
            		<img src="#Item.getImageSrc()#" width="30" height="30" style="ver" /> #Item.getName()#
            		<span style="float:right">Alert Options &nbsp; &nbsp; </span>
                 </h4>
            </div>
            <div class="modal-body"><div class="te" align="center">
            	<form id="editalert">
            		
            		<input type="hidden" name="alert_id" value="#rc.Alert.getID()#" />
					<input type="hidden" name="item_id" value="#Event.getNumericValue('item_id',0)#" />
					
					<div class="input-group input-group-sm">
						<span class="input-group-addon">When &nbsp;</span>
						<select name="prop" class="form-control">
							<option value="upgradecomponent_price_difference" <cfif rc.Alert.getProp() eq 'upgradecomponent_price_difference'>selected</cfif>>C-Diff Price</option>
							<option value="last_min_sale" <cfif rc.Alert.getProp() eq 'last_min_sale'>selected</cfif>>Sale Price</option>
							<option value="last_max_offer" <cfif rc.Alert.getProp() eq 'last_max_offer'>selected</cfif>>Buy Price</option>
							<option value="supply" <cfif rc.Alert.getProp() eq 'supply'>selected</cfif>>Supply</option>
							<option value="demand" <cfif rc.Alert.getProp() eq 'demand'>selected</cfif>>Demand</option>
						</select>
					</div>
					
					<div class="input-group input-group-sm">
						<span class="input-group-addon">Is &nbsp;</span>
						<select name="operator" class="form-control">
							<option value="gt" <cfif rc.Alert.getOperator() eq 'gt'>selected</cfif>>Greater Than</option>
							<option value="lt" <cfif rc.Alert.getOperator() eq 'lt'>selected</cfif>>Less Than</option>
							<option value="gte" <cfif rc.Alert.getOperator() eq 'gte'>selected</cfif>>Greater Than or Equals</option>
							<option value="lte" <cfif rc.Alert.getOperator() eq 'lte'>selected</cfif>>Less Than or Equals</option>
							<option value="eq" <cfif rc.Alert.getOperator() eq 'eq'>selected</cfif>>Equals</option>
						</select>
					</div>
					
					<div class="input-group input-group-sm">
						<span class="input-group-addon">This number &nbsp;</span>
						<input type="number" class="form-control" name="val" value="#rc.Alert.getVal()#" data-toggle="tooltip" title="Number" required />
					</div>
					
					<div class="input-group input-group-sm">
						<span class="input-group-addon">Alert me &nbsp;</span>
						<select name="sendinterval" class="form-control">
							<option value="86400" <cfif rc.Alert.getSendInterval() eq 86400>selected</cfif>>Once daily</option>
							<option value="302400" <cfif rc.Alert.getSendInterval() eq 302400>selected</cfif>>Twice a week</option>
							<option value="604800" <cfif rc.Alert.getSendInterval() eq 604800>selected</cfif>>Once a week</option>
						</select>
					</div>
					
					<cfif IsNull( prc.user.getEmail() ) || !Len(prc.user.getEmail()) || !IsValid('email',prc.user.getEmail())>
						<div class="input-group input-group-sm">
							<span class="input-group-addon">At email &nbsp;</span>
							<input type="text" class="form-control" name="email" value="" data-toggle="tooltip" title="Email Address" required />
						</div>
					</cfif>
            	</form>
            </div></div>
            <div class="modal-footer">
            	<cfif !IsNull(rc.Alert.getID()) && isNumeric(rc.Alert.getID()) && rc.Alert.getID() gt 0>
            		<button type="button" class="btn btn-danger deletealert pull-left" data-alert_id="#rc.Alert.getID()#">Delete</button>
				</cfif>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary savealert">Save</button>
            </div>
		</div>
	</div>
</cfoutput>