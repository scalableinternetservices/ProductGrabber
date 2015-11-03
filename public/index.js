requirejs([], function() {
    $("#txt-search-product").keydown(function (event) {
    	if(event.keyCode == 13)
    		goToSearch(event);
    });
    
    $("#btn-search-product").click(goToSearch);
    
    $("#lnk-search-products").click(function (event) {
    	$("#search-form-container").fadeIn(500);
    	event.prevenDefault();
    });
    
    function goToSearch (event) {
    	if($("#txt-search-product").val().trim() != "")
    		location.href = "/products?search=" + $("#txt-search-product").val().trim();
    }
});