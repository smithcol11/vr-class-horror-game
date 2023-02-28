extends Node3D

@onready var camera: XRCamera3D = $XROrigin3D/XRCamera3D
@onready var origin: XROrigin3D = $XROrigin3D
@onready var left_controller: XRController3D = $XROrigin3D/LeftHand
@onready var right_controller: XRController3D = $XROrigin3D/RightHand
@onready var footsteps: AudioStreamPlayer3D = $XROrigin3D/PlayerBody/SoundFootsteps

@onready var singleton = get_node("/root/Singleton")

func _ready():
	singleton.left_hand = left_controller
	singleton.right_hand = right_controller
	
	left_controller.connect("input_vector2_changed", on_input_vector2_changed)

func on_input_vector2_changed(vector_name, vector_value):
	if vector_name == "primary" and vector_value == Vector2.ZERO: 
		footsteps.stop()
	elif vector_name == "primary" and vector_value != Vector2.ZERO and !footsteps.playing: 
		footsteps.play()
