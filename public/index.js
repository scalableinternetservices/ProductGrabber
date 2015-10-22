requirejs([], function() {
    $("#txt-search-product").keydown(function (event) {
    	if(event.keyCode == 13)
    		goToSearch(event);
    });
    
    $("#btn-search-product").click(goToSearch);
    
    function goToSearch (event) {
    	location.href = "/products?search=" + $("#txt-search-product").val();
    }
});