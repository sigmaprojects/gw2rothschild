<cfoutput>
<div class="row">
	<div class="span9">

		<section id="eventHandlers">
		<div class="page-header">
			<h2>
				cfConcurrent Tasks
			</h2>
			<div class="btn-group pull-right">
				<a class="btn dropdown-toggle btn-small" href="##" data-toggle="dropdown">
					<i class="icon-info-sign"></i>Related Docs
					<span class="caret"></span>
				</a>
				<ul class="dropdown-menu">
					<li><a href="https://github.com/marcesher/cfconcurrent"><i class="icon-bookmark"></i>cfConcurrent Docs</a></li>
				</ul>
			</div>
		</div>
		<p>
			Active tasks assigned to the cfConcurrent Task Management Service
		</p>
		<table class="table table-striped">
			<thead>
				<th>Task</th>
				<th>Un-Pause</th>
				<th>Pause</th>
				<th>Start</th>
			</thead>
			<tbody>
				<cfloop collection="#application.executorService.getStoredTasks()#" item="TaskName">
					<cfset Task = application.executorService.getStoredTasks()[TaskName] />
					<tr>
						<td>
							<em>#TaskName#</em><br/>
							<em>#Task.Task.getRunStatus()#</em>
						</td>
						<!---
						<td>
							<cfset result = Task.Task.getResults() />
							Run Count: <em>#result.runCount#</em> <br />
							Last Tick: <em>#result.lastTick#</em> <br />
							Last TS: <em>#result.lastTS#</em> <br />
						</td>
						--->
						<td>
							<cfif Task.Task.getRunStatus() eq 'paused'>
								<a class="btn btn-success" href="#Event.buildLink(linkTo='tools.manageTask',queryString='taskName=#TaskName#&taskaction=unpause')#">Un-Pause</a>
							</cfif>
						</td>
						<td>
							<cfif Task.Task.getRunStatus() eq 'running'>
								<a class="btn btn-warning" href="#Event.buildLink(linkTo='tools.manageTask',queryString='taskName=#TaskName#&taskaction=pause')#">Pause</a>
							</cfif>
						</td>
						<td>
							<cfif Task.Task.getRunStatus() neq 'running' && Task.Task.getRunStatus() neq 'paused'>
								<a class="btn btn-primary" href="#Event.buildLink(linkTo='tools.manageTask',queryString='taskName=#TaskName#&taskaction=run')#">Run</a>
							</cfif>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
		</section>

	</div>

</div>
</cfoutput>

<!---
<li><a href="https://github.com/marcesher/cfconcurrent"><i class="icon-bookmark"></i>cfConcurrent Docs</a></li>
--->