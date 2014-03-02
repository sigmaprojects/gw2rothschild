function Alerts( strControllerURL, jContext  ){
	this.ControllerURL = ( strControllerURL ? strControllerURL : '/index.cfm');
	this.Context = ( jContext ? jContext : $(document));
	$.extend(this, window.objControllerClass);
	this.Init();
};

Alerts.prototype.objPostProperties = function( objPostProperties ){
	this.PostProperties = objPostProperties;
};

Alerts.prototype.Init = function(){
	var objSelf = this;
	//$.ajaxSetup({ cache: false });
	this.SetBusy( true );

	objSelf.SearchForm = objSelf.Context.find('form#searchalertsform');
	
	objSelf.Context.on('click', 'ul.pagination li a',
		function( objEvent ) {
			var $this = $(this);
			objSelf.SearchForm.find('input[name="page"]').val( $this.data('value') )
			objSelf.SearchForm.trigger('submit');
			objEvent.preventDefault();
			return( false );
		}
	);

	objSelf.Context.on('click', '#alerttable tr th.sort',
		function( objEvent ) {
			var $this = $(this);
			objSelf.SearchForm.find('input[name="sortorder"]').val( $this.data('value') )
			objSelf.SearchForm.trigger('submit');
			objEvent.preventDefault();
			return( false );
		}
	);

	objSelf.Context.on('click', '.editalert',
		function( objEvent ) {
			var $this = $(this);
			objSelf.ShowAlertEdit( $this );
			objEvent.preventDefault();
			return( false );
		}
	);
	

	objSelf.Context.on('click', '.savealert',
		function( objEvent ) {
			var $this = $(this);
			objSelf.SaveAlert( $('#alertmodal') );
			objEvent.preventDefault();
			return( false );
		}
	);

	objSelf.Context.on('click', '.deletealert',
		function( objEvent ) {
			var $this = $(this);
			objSelf.DeleteAlert( $('#alertmodal'), $this );
			objEvent.preventDefault();
			return( false );
		}
	);

	objSelf.Context.on('submit', 'form#editalert',
		function( objEvent ) {
			objSelf.SaveAlert( $('#alertmodal') );
			objEvent.preventDefault();
			return( false );
		}
	);

	this.SetBusy( false );
};

Alerts.prototype.ShowAlertEdit = function( jElm ){
	var objSelf = this;

	var AlertModal = $('<div class="modal fade" id="alertmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"></div>');
	AlertModal.modal({
		keyboard: true,
		show: true,
		remote: '/index.cfm?event=alerts.edit&item_id=' + jElm.data('item_id')
	});
	AlertModal.on('hidden.bs.modal', function (jModal) {
		$('#'+jModal.target.id).remove();
	})
	return;
};

Alerts.prototype.SaveAlert = function( jModal ){
	var objSelf = this;
	var form = jModal.find('form#editalert');
	
	var objPostProperties = form.serializeObject();
	objPostProperties['event'] = 'alerts.save';
	
	$.ajax({
		url: this.ControllerURL,
		data: objPostProperties,
		method: 'POST',
		dataType: 'json',
		beforeSend: function( xhr ) {
			//jElm.html( $('<img src="/includes/images/loading-sm.gif" width="14" height="14" />') );
		}
	}).done(function(jqXHR) {
		
		var alert_id = form.find('input[name="alert_id"]').val();
		if( alert_id && $('tr.alert.' + alert_id).length  ) {

			$.ajax({
				url: '/index.cfm',
				data: {event:'alerts.refreshalert_tr',alert_id:alert_id},
				method: 'GET',
				dataType: 'html',
				beforeSend: function( xhr ) {
					//jElm.html( $('<img src="/includes/images/loading-sm.gif" width="14" height="14" />') );
				}
			}).done(function(data) {
				$('tr.alert.' + alert_id).replaceWith( data );
			});
			
		};
		
		jModal.modal('hide');
		
	});

	return;
};

Alerts.prototype.DeleteAlert = function( jModal ) {
	var objSelf = this;
	
	var objPostProperties = {
		event:		'alerts.delete',
		alert_id:	jModal.find('input[name="alert_id"]').val()
	};
	
	$.ajax({
		url: this.ControllerURL,
		data: objPostProperties,
		method: 'POST',
		dataType: 'json',
		beforeSend: function( xhr ) {
			//jElm.html( $('<img src="/includes/images/loading-sm.gif" width="14" height="14" />') );
		}
	}).done(function(jqXHR) {
		$('tr.alert.' + jModal.find('input[name="alert_id"]').val()).remove();
		jModal.modal('hide');
	});
	
	return;
};
