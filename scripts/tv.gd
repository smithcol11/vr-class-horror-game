extends SubViewport

func _on_video_stream_player_finished():
	$VideoStreamPlayer.play()
