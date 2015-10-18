requirejs([], function() {
	
	var url = location.href;
	var searchQuery = url.substring(url.search("q=") + 2);
	var searchResults = "Search results for \"" + searchQuery + "\"";
	$("title").text(searchResults);
	$("#search-results-text").text(searchResults);
	
	if(searchQuery === "laptops") {
		$("#laptop-results").removeClass("hide");
		$("#mobile-results").addClass("hide");
	}
});