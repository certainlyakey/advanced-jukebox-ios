$(document).ready(function(){
	var myFirebaseRef = new Firebase("https://radiant-torch-3216.firebaseio.com/");
	$('.albumart').on('click',function() {
		myFirebaseRef.set({
			"song": {
				"name": "Hulley Gulley set from JS",
				"artist": "Beatles",
				"album": "Twisterday"
			}
		});
	});

	myFirebaseRef.child("song/name").on("value", function(snapshot) {
		$('#songname').text(snapshot.val());
	});
});
