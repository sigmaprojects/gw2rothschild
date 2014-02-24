<cfset Event.addAssets('
	/includes/javascript/alerts/alerts.js
') />
<script type="text/javascript">
$(document).ready(function() {
	new Alerts();
});
</script>

<cfoutput>

<div class="row">
	<div class="col-md-7">
		<h2>My Alerts</h2>
	</div>
	<div class="col-md-5">
		<form role="form" action="#Event.buildLink('alerts.updateEmail')#" method="post" id="updateEmail" style="margin:20px 0 0 0; ">
			<div class="input-group">
				<span class="input-group-addon">@</span>
				<input type="text" name="email" class="form-control" placeholder="Email" value="#prc.user.getEmail()#" data-toggle="tooltip" title="Email me alerts to...">
				<span class="input-group-btn">
					<button class="btn btn-default" type="submit">Save</button>
      			</span>
			</div>
		</form>
	</div>
</div>



<br />

<cfif !IsNull(prc.user.getEMail()) && Len(prc.user.getEMail()) && IsValid('email',prc.user.getEMail())>

	<cfif !ArrayLen(rc.Alerts.Entries)>
		<h4>
			None found, <a href="/items/">search & add items</a> to configure alerts. 
		</h4>
	</cfif>
	
<div class="panel panel-default">
	<form method="get" action="#Event.buildLink('alertrs.index')#" class="form-inline" role="form" id="searchalertsform">
		<input type="hidden" name="page" value="#rc.page#" />
		<input type="hidden" name="sortorder" value="#rc.sortorder#" />
	</form>
	<table class="table vmiddle" id="alerttable">
		<thead>
			<tr>
				<th class="sort text-primary" data-param="sortorder" data-value="i.name #(rc.sortorder eq 'i.name asc' ? 'desc' : 'asc')#">Name</th>
				<th class="sort text-primary" data-param="sortorder" data-value="prop #(rc.sortorder eq 'prop asc' ? 'desc' : 'asc')#">Data Point</th>
				<th class="sort text-primary" data-param="sortorder" data-value="operator #(rc.sortorder eq 'prop asc' ? 'desc' : 'asc')#">Operator</th>
				<th class="sort text-primary" data-param="sortorder" data-value="val #(rc.sortorder eq 'val asc' ? 'desc' : 'asc')#">Value</th>
				<th class="sort text-primary" data-param="sortorder" data-value="sendinterval #(rc.sortorder eq 'sendinterval asc' ? 'desc' : 'asc')#">Interval</th>
				<th class="sort text-primary" data-param="sortorder" data-value="sentcount #(rc.sortorder eq 'supply asc' ? 'desc' : 'asc')#">Sent Count</th>
				<th class="sort text-primary" data-param="sortorder" data-value="lastsent #(rc.sortorder eq 'lastsent asc' ? 'desc' : 'asc')#">Last Sent</th>
				<cfif prc.isLoggedIn>
					<th></th>
				</cfif>
			</tr>
		</thead>
		<tbody>
			<cfloop array="#rc.Alerts.Entries#" index="Alert">
				#renderView('alerts/refreshalert_tr')#
			</cfloop>
		</tbody>
	</table>
</div>
<cfelse>
	<h4>
		An Email address is required to use the alerting feature.
		<br /><br />
		Otherwise, please feel free to use a Watchlist.
	</h4>
</cfif>


</cfoutput>