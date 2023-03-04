extends Level

var played_sound:bool = false

func _ready():
	super()
	squeaky_light()

func _physics_process(delta):
	pass

func _on_door_handle_area_body_entered(body):
	if body is CharacterBody3D and !played_sound:
		played_sound = true
		$DoorHandleSound.play()

func _on_door_handle_sound_finished():
	$AudioStreamPlayer.play()
	$Prefabs/chair/AnimationPlayer.play("chair_to_ceiling")
	$Prefabs/chair/AudioStreamPlayer3D.play()
	
func _on_animation_player_animation_finished(anim_name):
	$Prefabs/chair2/AnimationPlayer.play("chair_to_ground")
	$Prefabs/chair2/AudioStreamPlayer3D.play()
