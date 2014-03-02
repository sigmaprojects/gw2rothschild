function ItemSearch( strControllerURL, jContext  ){
	this.ControllerURL = ( strControllerURL ? strControllerURL : '/index.cfm');
	this.Context = ( jContext ? jContext : $(document));
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

	$('select[name="per_page"]').chosen({disable_search_threshold: 10000});
	$('.chosen-select').chosen();

	objSelf.SearchForm = objSelf.Context.find('form#searchitemsform');
	
	objSelf.Context.on('click', 'ul.pagination li a',
		function( objEvent ) {
			var $this = $(this);
			objSelf.SearchForm.find('input[name="page"]').val( $this.data('value') )
			objSelf.SearchForm.trigger('submit');
			objEvent.preventDefault();
			return( false );
		}
	);

	objSelf.Context.on('click', '#itemtable tr th.sort',
		function( objEvent ) {
			var $this = $(this);
			objSelf.SearchForm.find('input[name="sortorder"]').val( $this.data('value') )
			objSelf.SearchForm.trigger('submit');
			objEvent.preventDefault();
			return( false );
		}
	);
	
	objSelf.Context.find('select[name="sortorder_"]').chosen().change(
		function( objEvent ) {
			var $this = $(this);
			objSelf.ManageMultiSort( $this, objSelf.Context.find('input[name="sortorder"]') );
		}
	);

	objSelf.Context.on('click', 'input[name="level_range"]',
		function( objEvent ) {
			var $this = $(this);
			$this.select();
		}
	);

	objSelf.Context.on('mouseover', 'tr.item td.price',
		function( objEvent ) {
			var $this = $(this);
			try {
				if ($this.data('tippedcache')) {
					var collection = Tipped.get($this.closest('tr.item'));
					collection.show();
				} else {
					var updated = jQuery.timeago($this.closest('tr.item').data('marketupdated'));
					updated = updated.replace('about', '');
					var amount = $this.data('amount');
					var updatedhtml = $('<div>Changed: ' + updated + '<br /></div>').html();
					var amounthtml = $('<ul>' + objSelf.formatCurrency(amount) + '</ul>').html();
					
					Tipped.create($this.closest('tr.item'), updatedhtml + amounthtml, {
						hook: 'rightmiddle',
						cache: false,
						skin: 'light',
						border: {
							size: 1
						}
					});
					$this.closest('tr.item').data('tippedcache',true);
				};
			} catch(e) {};
			return( true );
		}
	);

	objSelf.loadSuggest( objSelf.SearchForm.find('input[name="keyword"]') );

	this.SetBusy( false );
};

ItemSearch.prototype.loadSuggest = function( jElm ) {
	var objSelf = this;
	jElm.typeahead({                              
		name: 'twitter-oss',                                                        
		remote: '/index.cfm?event=items.suggest&keyword=%QUERY',                                             
		template: [                                                                 
			'<p class="repo-language">{{label}}</p>'
		].join(''),                                                                 
		engine: Hogan,
		limit: 20
	});
	return;
};






ItemSearch.prototype.ManageMultiSort = function( jSelect, jInput ) {
	var objSelf = this;
	var arrayContains = function(arr,val) {
		return arr.indexOf(val) != -1;
	};

	var cleanArray = function(actual){
		var newArray = new Array();
		for(var i = 0; i<actual.length; i++){
			if (actual[i]){
				newArray.push(actual[i]);
			};
		};
		return newArray;
	};

	var n = jSelect.val();
	if( !n ) {
		var n = [];
	}
	var e = jInput.val().split(',');
	var c = [];
	
	for (var i=0; i <= n.length; i++) {
		var v = n[i];
		if( arrayContains(e, n) && !arrayContains(c, n)) {
			
			c.splice( e.indexOf(v) , 1);
			
		} else {
			
			//c.unshift( v );
			c.push( v );
		};
	};
	
	//console.log(  cleanArray(c)  );
	
	jInput.val( c.join(',') );
	
	return;
};

