extends Level

func _ready():
	super()
	squeaky_light()

func _physics_process(delta):
	pass

func _on_house_switch_pressed():
	patio_light.light_energy = 5
	$TransportDoor.locked = false
	$TransportDoor.play_locked_sound()
