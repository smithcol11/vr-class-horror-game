extends Node3D

@onready var camera: XRCamera3D = $XROrigin3D/XRCamera3D
@onready var origin: XROrigin3D = $XROrigin3D
@onready var left_hand: XRController3D = $XROrigin3D/LeftHand
@onready var right_hand: XRController3D = $XROrigin3D/RightHand
@onready var footsteps: AudioStreamPlayer3D = $XROrigin3D/PlayerBody/SoundFootsteps

signal grabbed
signal released

func _ready():
	pass

func _physics_process(delta):
	if left_hand.is_button_pressed("primary") and !footsteps.playing:
		footsteps.play()
	elif !left_hand.is_button_pressed("primary") and footsteps.playing:
		footsteps.stop()


func _on_left_hand_button_pressed(action_name):
	if action_name == "grip_click": grabbed.emit()


func _on_left_hand_button_released(action_name):
	if action_name == "grip_click": released.emit()


func _on_right_hand_button_pressed(action_name):
	if action_name == "grip_click": grabbed.emit()


func _on_right_hand_button_released(action_name):
	if action_name == "grip_click": released.emit()
