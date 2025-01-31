extends AudioStreamPlayer

# Array to hold the audio streams
var background_songs = []
var current_song_index = 0
var song_change_time = 10.0  # Time in seconds to wait before changing the song
var timer = 0.0

func _ready():
	# Load your audio files into the array
	background_songs.append(load("res://Common/Assets/Sound/Music/HoliznaCC0 - 1 (jazz).mp3"))
	background_songs.append(load("res://Common/Assets/Sound/Music/HoliznaCC0 - 2 (jazz).mp3"))
	background_songs.append(load("res://Common/Assets/Sound/Music/HoliznaCC0 - 3 (jazz).mp3"))
	background_songs.append(load("res://Common/Assets/Sound/Music/HoliznaCC0 - 4 (jazz).mp3"))
	
	# Start playing the first song
	play_next_song()

func _process(delta):
	# Update the timer
	timer += delta
	if timer >= song_change_time:
		timer = 0.0  # Reset the timer
		play_next_song()  # Play the next song

func play_next_song():
	# Stop the current song
	stop()
	
	# Update the index to the next song
	current_song_index = (current_song_index + 1) % background_songs.size()
	
	# Set the new stream and play it
	stream = background_songs[current_song_index]
	play()
