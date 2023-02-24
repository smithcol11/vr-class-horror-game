extends Node3D

var interface : XRInterface

var next_level = preload("res://scenes/level_2.tscn").instantiate()
var num_of_levels = 2
var current_level
var previous_level

func _ready():
	interface = XRServer.find_interface("OpenXR")
	interface.initialize()
	
	Engine.physics_ticks_per_second = 90
	Engine.max_fps = 90
	
	if interface and interface.is_initialized():
		print("OpenXR initialised successfully")

		get_viewport().use_xr = true
	else:
		print("OpenXR not initialised, please check if your headset is connected")
	
	current_level = $Level1
	next_level.position.x -= (18.17)
	add_child(next_level)
	next_level.connect("scene_change", _on_level_scene_change)


func _on_level_scene_change():
	num_of_levels += 1
	var level = "res://scenes/level_" + str(num_of_levels) + ".tscn"
	previous_level = current_level
	current_level = next_level
	next_level = load(str(level)).instantiate()
	next_level.position.x -= (18.17 * (num_of_levels - 1))
	add_child(next_level)
	next_level.connect("scene_change", _on_level_scene_change)
	previous_level.queue_free()
	current_level.set_hidden_door(true)
