requirejs([], function() {
    $("#btn-search-product").click(function (event) {
		location.href = "/html/search.html?q=" + $("#txt-search-product").val();
	});
});