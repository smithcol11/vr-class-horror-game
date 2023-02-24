extends Node3D

@onready var door_body = $DoorBody
@onready var hinge = $HingeJoint3D

@onready var singleton = get_node("/root/Singleton")

@export var locked = false
var closed = true
var grabbed = false
var in_range = false

func _ready():
	door_body.freeze = true

func _physics_process(delta):
	if singleton.right_hand.is_button_pressed("grip_click") or singleton.left_hand.is_button_pressed("grip_click"): grabbed = true
	else: grabbed = false
	
	if in_range and grabbed: 
		if locked: $DoorLocked.play()
		else: door_body.freeze = false
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
	
	if locked and door_body.rotation.y != 0: door_body.rotation.y = 0

func play_closed_sound():
	$DoorClosed.play()

func _on_area_3d_body_entered(body):
	if body is CharacterBody3D: in_range = true


func _on_area_3d_body_exited(body):
	if body is CharacterBody3D: in_range = false
