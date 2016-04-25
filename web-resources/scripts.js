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
function modify_qty(val) {
    var qty = document.getElementById('qty').value;
    var new_qty = parseInt(qty,10) + val;
    
    if (new_qty < 0) {
        new_qty = 0;
    }
    
    document.getElementById('qty').value = new_qty;
    return new_qty;
}