function PageControllerClass(){
	this.PageBusy = false;
	var objSelf = this;
};


PageControllerClass.prototype.GetBusy = function(){
	return(this.PageBusy);
};

PageControllerClass.prototype.SetBusy = function(blnBusy){
	this.PageBusy = blnBusy;
};

PageControllerClass.prototype.formatCurrency = function(amount){
	if (amount == 0) {
		return '0';
	};
	var negative = amount < 0;
	var amount = Math.abs(amount);
	
	var gold = Math.floor(amount / 10000);
	var silver = Math.floor(amount / 100) % 100;
	var copper = Math.floor(amount % 100);
	
	var output = [];
	
	if (negative) {
		output.push('<span style="color:red">-</span>');
	};
	if (gold) {
		output.push('<i class="gold-img"></i><span class="gold">' + gold + '</span>');
	};
	if (silver) {
		output.push('<i class="silver-img"></i><span class="silver">' + silver + '</span>');
	};
	if (copper) {
		output.push('<i class="copper-img"></i><span class="copper">' + copper + '</span>');
	};
	return output.join(' ');
};


$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        };
    });
    return o;
};