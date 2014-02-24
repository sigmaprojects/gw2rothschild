<cfif event.getValue('reset',false)>
	<cfset ApplicationStop() />
</cfif>
<cfset Event.addAssets('
	/includes/styles/auth-buttons.css
') />



    <div align="center">
        <p><a class="btn-auth btn-facebook" href="/multilogin/processLogin?loginType=facebook">Sign in with <b>Facebook</b></a></p>
        <p><a class="btn-auth btn-google" href="/multilogin/processLogin?loginType=google">Sign in with <b>Google</b></a></p>
    </div>
	
	