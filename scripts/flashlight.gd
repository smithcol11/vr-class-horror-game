extends Node3D

@onready var singleton = get_node("/root/Singleton")
@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var light: SpotLight3D = $SpotLight3D

## Current pickable object state
enum PickableState {
	IDLE,				## Object not held
	GRABBING_RANGED,	## Object being grabbed at range
	HELD,				## Object held
}

func _ready():
	light.light_energy = 0
	
func connect_to_hands():
	var left_hand: XRController3D = singleton.left_hand
	var right_hand: XRController3D = singleton.right_hand
	
	left_hand.connect("button_pressed", on_button_pressed)
	right_hand.connect("button_pressed", on_button_pressed)

func on_button_pressed(button):
	if button == "trigger_click" and get_parent()._state == PickableState.HELD:
		audio.play()
		if light.light_energy == 1: light.light_energy = 0
		else: light.light_energy = 1
