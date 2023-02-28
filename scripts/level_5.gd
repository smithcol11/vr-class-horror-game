extends Level

var on_ceiling: bool = false

func _ready():
	$Prefabs/chair3.visible = false
	super()
	squeaky_light()

func _physics_process(delta):
	pass

func _on_chair_ceiling_area_body_entered(body):
	if !on_ceiling:
		$TransportDoor.locked = false
		on_ceiling = true
		$Prefabs/chair2.visible = false
		$Prefabs/chair3.visible = true
		
		$Prefabs/chair3/AudioStreamPlayer3D.play()


func _on_audio_stream_player_3d_finished():
	$TransportDoor.play_locked_sound()
