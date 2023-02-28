extends Node3D

signal switch_pressed

func _ready():
	pass

func _on_light_switch_switch_pressed():
	switch_pressed.emit()
