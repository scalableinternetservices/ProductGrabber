requirejs([], function() {
	
	var url = location.href;
	var searchQuery = url.substring(url.search("search=") + 7);
	var searchResults = "Search results for \"" + searchQuery + "\"";
	$("title").text(searchResults);
	$("#search-results-text").val(searchQuery);
});