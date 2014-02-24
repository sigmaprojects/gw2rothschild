function ItemSearch( strControllerURL, jContext  ){
	if (strControllerURL) {
		this.ControllerURL = strControllerURL;
	} else {
		this.ControllerURL = '/index.cfm';
	}
	if( jContext ) {
		this.Context = jContext;
	} else {
		this.Context = $(document);
	};
	$.extend(this, window.objControllerClass);
	this.Init();
};

ItemSearch.prototype.objPostProperties = function( objPostProperties ){
	this.PostProperties = objPostProperties;
};

ItemSearch.prototype.Init = function(){
	var objSelf = this;
	//$.ajaxSetup({ cache: false });
	this.SetBusy( true );

	$(".chosen-select").chosen();



	if ( objSelf.Context.find('#itemtable').length > 0) {

		/*
		var footer = $('footer');
			footer.css('position','fixed');
			footer.css('bottom','-15px');
			footer.css('width','100%');
			footer.css('margin','auto');
			footer.css('background-color','#fff');
			footer.css('border-width', '0 25 0 25');
		*/
		
		objSelf.container = objSelf.Context.find("#itemtable");
		objSelf.list = objSelf.container.find('tbody');
		
		
		
		$(window).bind('scroll resize', function(objEvent){
			objSelf.checkListItemContents(objSelf.container, objSelf.list);
		});
		
		// Now that the page is loaded, trigger the "Get"
		// method to populate the list with data.
		objSelf.checkListItemContents(objSelf.container, objSelf.list);
	};



	this.SetBusy( false );
};


ItemSearch.prototype.resetResults = function() {
	var objSelf = this;
	objSelf.stopStream = false;
	objSelf.list.removeData('nextOffset');
	objSelf.list.removeData('xhr');
	objSelf.list.html('');
	objSelf.checkListItemContents(objSelf.container, objSelf.list);
	return;
};


ItemSearch.prototype.getMoreListItems = function( list, onComplete ) {
	var objSelf = this;
	var nextOffset = (list.data( "nextOffset" ) || 0);
	if (list.data( "xhr" )){
		// search for xhr for paging (resize, scroll, etc) abort if found.
		return;
	};

	if (list.data( "executing" )){
		// search for executing for the actual ajax event, abort if returns true. 
		return;
	};

	list.data('executing',true);
	objSelf.SetSearchBusy(true);
	list.data(
		"xhr",
		$.ajax({
			type: "post",
			url: this.ControllerURL,
			cache: true,
			data: {
				offset: nextOffset,
				max: 12,
				event: 'items.search',
				params: {},
				sortOrder: objSelf.Context.find('#sortorder').val()
				/*Keyword: ( $("input#keyword").length > 0 ? $("input#keyword").val() : '')*/
			},
			dataType: "html",
			success: function( response ){
				objSelf.appendListItems( list, response );
				list.data(
					"nextOffset",
					(nextOffset + 12)
				);
			},
			complete: function(){
				list.removeData( "xhr" );
				list.data('executing',false);
				objSelf.SetSearchBusy(false);
				onComplete();
			}
		})
	);	
};

ItemSearch.prototype.appendListItems = function(list, items ) {
	var objSelf = this;
	if(!items.length) {
		objSelf.stopStream = true;
	};
	list.append( items );

};

ItemSearch.prototype.isMoreListItemsNeeded = function( container, list ) {
	var objSelf = this;
	//return( false );
	if(objSelf.stopStream) {
		return(false);
	};
	var viewTop = $( window ).scrollTop();
	var viewBottom = (viewTop + $( window ).height());
	var containerBottom = Math.floor(
		container.offset().top +
		container.height()
	);
	var scrollBuffer = 150;
	if ((containerBottom - scrollBuffer) <= viewBottom){
		return( true );
	} else {
		return( false );
	};
};

ItemSearch.prototype.checkListItemContents = function( container, list ) {
	var objSelf = this;
	var doMore = objSelf.isMoreListItemsNeeded( container, list );
	if (doMore){
		objSelf.getMoreListItems(
			list,
			function(){
				objSelf.checkListItemContents( container, list );
			}
		);
	}
};

ItemSearch.prototype.SetSearchBusy = function(blnBusy){
	var objSelf = this;
	return;
};