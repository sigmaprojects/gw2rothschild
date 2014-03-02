<cflock type="exclusive" timeout="60" scope="Application">

		
<cfset objLogin = CreateObject("component", "cfc.login")>

<!--- INITIALISE LOGIN BY TYPE --->
<cfif IsDefined("url.loginType")>
	<cfswitch expression="#url.loginType#">
		<cfcase value="facebook">
			<cfset application.current_login_method = 'facebook'>
			<cfset facebookLogin = objLogin.initiate_login(
				loginUrlBase = "https://www.facebook.com/dialog/oauth",
				loginClientID = application.facebook_appid,
				loginRedirectURI = application.facebook_redirecturl,
				loginScope = "friends_hometown"
			)>
		</cfcase>
		<cfcase value="google">
			<cfset application.current_login_method = 'google'>
			<cfset googleLogin = objLogin.initiate_login(
				loginUrlBase = "https://accounts.google.com/o/oauth2/auth",
				loginClientID = application.google_client_id,
				loginRedirectURI = application.google_redirecturl,
				loginScope = "https://www.googleapis.com/auth/userinfo.profile"
			)>
		</cfcase>
	</cfswitch>
</cfif>

<!--- FACEBOOK CALLBACK --->
<cfif application.current_login_method is 'facebook'>
	<cfif isDefined("url.code") and url.state is application.login_state>
		<cfset application.facebook_code = url.code>
		<!--- Get the ACCESS TOKEN --->
		<cfset facebookAuthorise = objLogin.authorise_login(
			authUrlBase = "https://graph.facebook.com/oauth/access_token",
			authRedirectURI = application.redirect_uri,
			authMethod = "post",
			authCode = application.facebook_code,
			authClientId = application.facebook_appid,
			authClientSecret = application.facebook_secret,
			authGrantType = "authorization_code"
		)>
		<cfif findNoCase("access_token=", facebookAuthorise.filecontent)>
	        <!--- Set the ACCESS TOKEN --->
			<cfset part1 = listGetAt(facebookAuthorise.filecontent, 1, "&")>
			<cfset application.facebook_access_token = listGetAt(part1, 2, "=")>
			
 		<cfelse>
		 	<cfinclude template="error.cfm">
		</cfif>
		
		<cfinclude template="displayInfo.cfm">
 	</cfif>
</cfif>

<!--- GOOGLE CALLBACK --->
<cfif application.current_login_method is 'google'>
	<cfif isDefined("url.code") and url.state is application.login_state>
		<cfset application.google_code = url.code>
		<!--- Get the ACCESS TOKEN --->
		<cfset googleAuthorise = objLogin.authorise_login(
			authUrlBase = "https://accounts.google.com/o/oauth2/token",
			authRedirectURI = application.redirect_uri,
			authMethod = "post",
			authCode = application.google_code,
			authClientId = application.google_client_id,
			authClientSecret = application.google_secretkey,
			authGrantType = "authorization_code"
		)>
        <cfif isJSON(googleAuthorise.filecontent)>
	        <!--- Set the ACCESS TOKEN --->
            <cfset result = deserializeJSON(googleAuthorise.filecontent)>
			<cfset application.google_access_token = result.access_token>
 		<cfelse>
		 	<cfinclude template="error.cfm">
		</cfif>
		<cfinclude template="displayInfo.cfm">
	</cfif>
</cfif>


</cflock>