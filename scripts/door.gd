extends Node3D

@onready var door_body = $RigidBody3D
@onready var hinge = $HingeJoint3D

var closed = true
var grabbed = false
@export var locked = false
var in_range = false

func _ready():
	door_body.freeze = true

func _physics_process(delta):
	if in_range and grabbed: door_body.freeze = false
	elif door_body.rotation.y <= 0.01: 
		door_body.rotation.y = 0
		door_body.freeze = true
	
	door_state()

func door_state():
	if closed and door_body.rotation.y != 0: 
		closed = false
		$DoorOpen.play()
	elif !closed and door_body.rotation.y == 0: 
		closed = true
		$DoorClosed.play()

func _on_area_3d_body_entered(body):
	if body is CharacterBody3D: in_range = true


func _on_area_3d_body_exited(body):
	if body is CharacterBody3D: in_range = false


func _on_xr_player_grabbed():
	grabbed = true


func _on_xr_player_released():
	grabbed = false
