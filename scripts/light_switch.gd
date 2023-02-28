extends Node3D

@onready var singleton = get_node("/root/Singleton")
@onready var outline_mesh: MeshInstance3D = $Outline
@export var functional: bool = true

signal switch_pressed

var in_range: bool = false

func _ready():
	singleton.left_hand.connect("button_pressed", on_button_pressed)
	singleton.right_hand.connect("button_pressed", on_button_pressed)
	outline_mesh.visible = false

func _physics_process(delta):
	pass

func _on_area_3d_body_entered(body):
	if body is CharacterBody3D: 
		in_range = true
		outline_mesh.visible = true

func _on_area_3d_body_exited(body):
	if body is CharacterBody3D: 
		in_range = false
		outline_mesh.visible = false

func on_button_pressed(button):
	if button == "trigger_click" and in_range: 
		$ClickSound.play()
		if functional: switch_pressed.emit()
