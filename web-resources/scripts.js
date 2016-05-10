function getMaxOfArray(numArray) {
  return Math.max.apply(null, numArray);
}

$(document).ready(function(){
	var myFirebaseRef = new Firebase("https://radiant-torch-3216.firebaseio.com/songs");

	myFirebaseRef.on("value", function(snapshot) {
		var songs = snapshot.val();

		songs.sort(function(a, b) {
		    return parseFloat(a.votes) - parseFloat(b.votes);
		}).reverse();

		$('#playlist').empty();
		$.each(songs, function(index, song) {
			var listEl = '<li class="cf"><div class="playlist-votes">'+song.votes+'</div><img class="playlist-cover" src="'+song.imgurl+'" alt="'+song.name+'"><div class="playlist-name">'+song.name+'</div><div class="playlist-artist">'+song.artist+'</div></li>';
			$('#playlist').append(listEl);
		});
		var currSong = songs[0];

		$('#cover_current').attr('src', currSong.imgurl);
		$('#song-album').text(currSong.album);
		$('#song-artist').text(currSong.artist);
		$('#song-name').text(currSong.name);
		$('#current-song-votes').text(currSong.votes + ' votes');
		
	});
});