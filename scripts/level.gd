extends Node3D

signal scene_change

@onready var singleton = get_node("/root/Singleton")
@onready var hidden_door = $HiddenDoor

func _ready():
	$Area3D.connect("body_entered", _on_area_3d_body_entered)
	if hidden_door: set_hidden_door(false)

func _on_area_3d_body_entered(body):
	if body is CharacterBody3D:
		$TransportDoor.locked = true
		remove_child($Area3D)
		scene_change.emit()

func set_hidden_door(set):
	if !set: remove_child(hidden_door)
	else: 
		add_child(hidden_door)
		hidden_door.locked = true
		hidden_door.play_closed_sound()

