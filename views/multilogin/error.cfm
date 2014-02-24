<cfif prc.IsLoggedIn>
	<cflocation url="/multiLogin/success" addtoken="false" />
<cfelse>
	<div align="center">
		Error logging in.
	</div>
</cfif>