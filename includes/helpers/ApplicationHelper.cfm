<!--- All methods in this helper will be available in all handlers,plugins,views & layouts --->

<cffunction name="ago" access="public" output="false" returntype="string">
	<cfargument name="dateThen" type="string" default="#Now()#" />
	<cfscript>
	var result = "";
	var i = "";
	var rightNow = Now();
	Do {
		i = dateDiff('yyyy',dateThen,rightNow);
		if(i GTE 2){
			result = "#i# years ago";
			break;
		}
		else if (i EQ 1){
			result = "#i# year ago";
			break;
		}
		i = dateDiff('m',dateThen,rightNow);
		if(i GTE 2){
			result = "#i# months ago";
			break;
		}
		else if (i EQ 1){
			result = "#i# month ago";
			break;
		}
		i = dateDiff('d',dateThen,rightNow);
		if(i GTE 2){
			result = "#i# days ago";
			break;
		}
		else if (i EQ 1){
			result = "#i# day ago";
			break;
		}
		i = dateDiff('h',dateThen,rightNow);
		if(i GTE 2){
			result = "#i# hours ago";
			break;
		}
		else if (i EQ 1){
			result = "#i# hour ago";
			break;
		}
		i = dateDiff('n',dateThen,rightNow);
		if(i GTE 2){
			result = "#i# minutes ago";
			break;
		}
		else if (i EQ 1){
			result = "#i# minute ago";
			break;
		}
		i = dateDiff('s',dateThen,rightNow);
		if(i GTE 2){
			result = "#i# seconds ago";
			break;
		}
		else if (i EQ 1){
			result = "#i# second ago";
			break;
		}
		else {
			result = "less than 1 second ago";
			break;
		}
	}
	While (0 eq 0);
	return result;
	</cfscript>
</cffunction>

<cffunction name="relativeDate" access="public" output="no" returnType="string" hint="I will return a string containing the relative date difference from now.">
   <cfargument name="originalDate" required="true" type="date" hint="I am the date that my function will be comparing to now" />
   <cfargument name="cutoff" type="string" default="" />

   <cfset var relativeDiff = "" />   
   <!--- Calculate the difference in minutes --->
   <cfset var minDiff = dateDiff("n", arguments.originalDate, now()) />
   
   <!--- 1. Capture future dates --->
   <cfif minDiff lt 0>
      <cfset relativeDiff = "Sometime in the future." />
   <!--- 2. Less than a minute ago --->   
   <cfelseif minDiff lt 1>
      <cfset relativeDiff = "Less than a minute ago." />
   <!---3. 1 minute ago --->
   <cfelseif minDiff is 1>
      <cfset relativeDiff = "1 minute ago." />
   <!--- 4. N minutes ago --->   
   <cfelseif minDiff lt 60>
      <cfset relativeDiff = minDiff & " minutes ago." />
   <!--- 5. 1 hour ago. --->
   <cfelseif minDiff is 60>
      <cfset relativeDiff = "1 hour ago." />   
   <!--- 6. N hours ago. (if N is not an integer, display "about") --->
   <cfelseif minDiff lt 1440>
      <!--- Since we're rounding, it's possible the relative difference could be "about 1 hour", so we need to figure out if we'll be using hour or hours as our unit --->
      <cfif int(minDiff/60) is 1>
         <cfset hourUnit = "hour" />
      <cfelse>
         <cfset hourUnit = "hours" />   
      </cfif>
      
      <cfif int(minDiff/60) is (minDiff/60)>
         <cfset relativeDiff = minDiff/60 & " " & hourUnit & " ago." />   
      <cfelse>
         <cfset relativeDiff = "About " & int(minDiff/60) & " " & hourUnit & " ago." />   
      </cfif>
   <!--- 7. 1 day ago --->   
   <cfelseif minDiff is 1440>
      <cfset relativeDiff = "1 day ago." />   
   <!--- 8. N days ago. (if N is not an integer, display "about") --->
   <cfelseif minDiff gt 1440>
      <!--- Since we're rounding, it's possible the relative difference could be "about 1 day", so we need to figure out if we'll be using day or days as our unit --->
      <cfif int(minDiff/1440) is 1>
         <cfset dayUnit = "day" />
      <cfelse>
         <cfset dayUnit = "days" />   
      </cfif>
      
      <cfif int(minDiff/1440) is (minDiff/1440)>
         <cfset relativeDiff = minDiff/1440 & " " & dayUnit & " ago." />   
      <cfelse>
         <cfset relativeDiff = "About " & int(minDiff/1440) & " " & dayUnit & " ago." />   
      </cfif>
      
   
      <cfif len(arguments.cutoff) && dayUnit contains "days" && int(minDiff/1440) gte Left(arguments.cutoff,1)>
	  	  <cfreturn arguments.originalDate />
      </cfif>
      
   </cfif>

   
   <!--- Return the string --->
   <cfreturn relativeDiff />
</cffunction>
