// var instanceVars = {
// 	last_time: new Date().getTime() / 1000,
// 	last_url: "example.com",
// 	url_to_time: {
// 		"current_url": 0
// 	},

// 	update_table: function(){
// 		var now = new Date().getTime() / 1000;
// 		var difference = now - instanceVars.last_time;
// 		if(instanceVars.url_to_time.url==undefined){
// 			instanceVars.url_to_time.url = difference;
// 		} else {
// 			instanceVars.url_to_time.url = instanceVars.url_to_time.url + difference;
// 		}
// 	},

// 	update_to_current_url: function(String current_url){
// 		instanceVars.last_url = current_url;
// 		instanceVars.last_time = new Date().getTime() / 1000;
// 	},

// }

chrome.tabs.onActivated.addListener(function(activeInfo){
	// instanceVars.update_table();
	// instanceVars.update_to_current_url(tab.url);
	// console.log(instanceVars.url_to_time);
	var tabId = activeInfo.tabId;
	chrome.tabs.get(tabId, function(tab){
		console.log("tab activate");
		console.log(tab.url);
	});
});

chrome.tabs.onUpdated.addListener(function(tabId, changeInfo, tab){
	chrome.tabs.get(tabId, function(tab){
		if(tab.active && changeInfo=="complete"){
			console.log("tab activate");
			console.log(tab.url);	
		}	
	});
});

chrome.windows.onFocusChanged.addListener(function(windowId){
	chrome.windows.get(windowId, {"populate": true},function(window){
		for(i=0; i< window.tabs.length; i++){
			var tab =window.tabs[i];
			if(tab.active){
				console.log("window focus");
				console.log(tab.url);
			}
		}
	});
});