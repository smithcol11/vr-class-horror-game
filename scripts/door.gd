extends StaticBody3D

var open = false
var in_range = false

func interact():
	if $AnimationPlayer.is_playing(): return
	
	if not open:
		$AnimationPlayer.play("open_door")
		$SoundDoor.play(.25)
		open = true
	elif open:
		$AnimationPlayer.play_backwards("open_door")
		$SoundDoor.play(3.5)
		open = false

func _physics_process(_delta):
	if in_range and Input.is_action_pressed("interact"):
		interact()
	if $SoundDoor.get_playback_position() >= 1.5 and open:
		$SoundDoor.stop()

func _on_area_3d_body_entered(body):
	if body is CharacterBody3D: in_range = true

func _on_area_3d_body_exited(body):
	if body is CharacterBody3D: in_range = false
