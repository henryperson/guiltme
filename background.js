chrome.tabs.onActivated.addListener(function(activeInfo){
	var seconds = new Date().getTime() / 1000;
	var id = activeInfo.tabId;
	console.log(id);
});