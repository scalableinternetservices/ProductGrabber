require([], function() {
	
	var url = location.href;
	var searchRegex = /search=[^&]*/gi;
	var searchString = url.match(searchRegex);
	var searchQuery, searchResults;
	if(searchString != null) {
		searchQuery = searchString[0].substring(7);
		searchResults = "Search results for: '" + searchQuery + "'";
	}
	else {
		searchQuery = "";
		searchResults = "All Products";
	}
	
	$("title").text(searchResults);
	$("#search-results-text").val(searchQuery);
	
	var $li = $("ul.pagination li");
	
	if($li.length == 1) {
		$li.addClass("disabled");
	}
});