<cfif structKeyExists(rc,'Alert')>
	<cfset Alert = rc.Alert>
</cfif>
<cfset Item = Alert.getItem() />
<cfoutput>
				<tr class="alert #Alert.getID()#">
					<td>
						<a href="#Event.buildLink(linkTo='items.view',queryString=Item.getID())#">
							#Item.getName()#
						</a>
					</td>
					<td>
						#Alert.getPropertyLabel()#
					</td>
					<td>
						#Alert.getOperatorLabel()#
					</td>
					<td>
						#Alert.getVal()#
					</td>
					<td>
						#Alert.getSendIntervalatorLabel()#
					</td>
					<td>
						#Alert.getSentCount()#
					</td>
					<td>
						<cfif !IsNull(Alert.getLastSent()) && IsDate(Alert.getLastSent())>
							#relativeDate( Alert.getLastSent() )#
						</cfif>
					</td>
					<td class="nopad">
						<span class="glyphicon glyphicon-bell editalert" data-item_id="#Item.getID()#" title="Edit Alert"></span>
					</td>
				</tr>
</cfoutput>