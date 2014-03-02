function Watchlist( strControllerURL, jContext  ){
	this.ControllerURL = ( strControllerURL ? strControllerURL : '/index.cfm');
	this.Context = ( jContext ? jContext : $(document));
	$.extend(this, window.objControllerClass);
	this.Init();
};

Watchlist.prototype.objPostProperties = function( objPostProperties ){
	this.PostProperties = objPostProperties;
};

Watchlist.prototype.Init = function(){
	var objSelf = this;
	//$.ajaxSetup({ cache: false });
	this.SetBusy( true );

	objSelf.Context.on('click', '.watch',
		function( objEvent ) {
			var $this = $(this);
			objSelf.Togglewatch( $this.data('item_id'), true, $this );
			objEvent.preventDefault();
			return( false );
		}
	);
	
	objSelf.Context.on('click', '.unwatch',
		function( objEvent ) {
			var $this = $(this);
			objSelf.Togglewatch( $this.data('item_id'), false, $this );
			objEvent.preventDefault();
			return( false );
		}
	);

	//html( objSelf.formatCurrency( $(this).data('amount') ) )
	
	this.SetBusy( false );
};

Watchlist.prototype.Togglewatch = function(item_id, watch, jElm) {
	var objSelf = this;
	var event = ( watch ? 'watchlist.add' : 'watchlist.remove' );
	var objPostProperties = {
		event: event,
		item_id: item_id
	};
	objSelf.SetBusy(true);

	$.ajax({
		url: this.ControllerURL,
		data: objPostProperties,
		dataType: 'json',
		beforeSend: function( xhr ) {
			jElm.removeClass('glyphicon');
			jElm.removeClass('glyphicon-star-empty');
			jElm.removeClass('glyphicon-star');
			jElm.html( $('<img src="/includes/images/loading-sm.gif" width="14" height="14" />') );
		}
	}).done(function(jqXHR) {
		jElm.empty();
		jElm.addClass('glyphicon');
		
		if( watch ) {
			jElm.removeClass('watch');
			jElm.addClass('unwatch');
			
			jElm.removeClass('glyphicon-star-empty');
			jElm.addClass('glyphicon-star');
			
			jElm.attr('title','Remove from watchlist');

		} else {
			jElm.removeClass('unwatch');
			jElm.addClass('watch');
			
			jElm.addClass('glyphicon-star-empty');
			jElm.removeClass('glyphicon-star');
			
			jElm.attr('title','Add to watchlist');
		};
	});


	return;
} 

