class_name Level extends Node3D
signal scene_change

@onready var singleton = get_node("/root/Singleton")
@onready var hidden_door = $HiddenDoor
@onready var house = $House
@onready var main_light = $House/main_light
@onready var patio_light: SpotLight3D = $Lights/Patio

var patio_light_on: bool = false

func _ready():
	$Area3D.connect("body_entered", _on_area_3d_body_entered)
	patio_light.light_energy = 0
	house.connect("switch_pressed", _on_house_switch_pressed)
	if hidden_door: set_hidden_door(false)

func _on_area_3d_body_entered(body):
	if body is CharacterBody3D:
		$TransportDoor.locked = true
		$Area3D/CollisionShape3D.set_deferred("disabled", true)
		scene_change.emit()

func set_hidden_door(show_door):
	if !show_door: remove_child(hidden_door)
	else: 
		add_child(hidden_door)
		hidden_door.locked = true
		hidden_door.play_closed_sound()

func squeaky_light():
	main_light.start()

func _on_house_switch_pressed():
	if patio_light_on: patio_light.light_energy = 0
	else: patio_light.light_energy = 1
	patio_light_on = !patio_light_on
