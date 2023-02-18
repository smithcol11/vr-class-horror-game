extends Node3D

var in_range = false

func _physics_process(_delta):
	if Input.is_action_pressed("interact") and in_range: $SoundLockedDoor.play()

func _on_area_3d_body_entered(body):
	if body is CharacterBody3D: in_range = true

func _on_area_3d_body_exited(body):
	if body is CharacterBody3D: in_range = false
