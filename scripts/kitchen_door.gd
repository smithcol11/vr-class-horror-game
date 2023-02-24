extends Node3D

@onready var sound = $LockedSound
@onready var singleton = get_node("/root/Singleton")
var in_range = false

func _ready():
	$Area3D.connect("body_entered", _on_area_3d_body_entered)
	$Area3D.connect("body_exited", _on_area_3d_body_exited)
	
func _physics_process(delta):
	var grip = false
	
	if singleton.right_hand.is_button_pressed("grip_click") or singleton.left_hand.is_button_pressed("grip_click"): grip = true
	else: grip = false
	
	if in_range and grip: $LockedSound.play()

func _on_area_3d_body_entered(body):
	if body is CharacterBody3D: in_range = true

func _on_area_3d_body_exited(body):
	if body is CharacterBody3D: in_range = false
