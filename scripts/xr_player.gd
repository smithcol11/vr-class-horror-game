extends Node3D

@onready var camera: XRCamera3D = $XROrigin3D/XRCamera3D
@onready var origin: XROrigin3D = $XROrigin3D
@onready var left_controller: XRController3D = $XROrigin3D/LeftHand
@onready var right_controller: XRController3D = $XROrigin3D/RightHand
@onready var footsteps: AudioStreamPlayer3D = $XROrigin3D/PlayerBody/SoundFootsteps

@onready var singleton = get_node("/root/Singleton")

signal grabbed
signal released

func _ready():
	singleton.left_hand = left_controller
	singleton.right_hand = right_controller
	pass

func _physics_process(delta):
	if left_controller.is_button_pressed("primary") and !footsteps.playing:
		footsteps.play()
	elif !left_controller.is_button_pressed("primary") and footsteps.playing:
		footsteps.stop()
