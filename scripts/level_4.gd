extends Level

var attempt_locked_door: bool = false

func _ready():
	super()
	squeaky_light()

func _physics_process(delta):
	pass

func _on_frantic_door_area_entered(body):
	attempt_locked_door = true
	$DoorBangs.play()

func _on_unlock_door_area_body_entered(body):
	if attempt_locked_door and $TransportDoor.locked: 
		$TransportDoor.locked = false
		$TransportDoor.play_locked_sound()
