extends Level

var played_sound: bool = false
var door_open: bool = false

signal end_game

@onready var bathroom_door = $BathroomDoor
@onready var bathroom_lights: OmniLight3D = $Lights/Bathroom

func _ready():
	super()
#	squeaky_light()

func _physics_process(delta):
	pass

func _on_door_open_area_body_entered(body):
	if body is CharacterBody3D and !door_open:
		door_open = true
		bathroom_door.creak_open()

func _on_door_close_area_body_entered(body):
	if body is CharacterBody3D and door_open:
		door_open = false
		bathroom_door.creak_closed()
		await get_tree().create_timer(5).connect("timeout", on_timeout)

func on_timeout():
	turn_off_lights()
	bathroom_door.play_locked_sound()
	await get_tree().create_timer(5).connect("timeout", on_another_timeout)

func turn_off_lights():
	$VoiceAudio.play()
	$Lights/Hall1.light_energy = 0
	$Lights/Hall2.light_energy = 0
	$Lights/TVScreen.light_energy = 0
	$Lights/ComputerScreen.light_energy = 0

func on_another_timeout():
	bathroom_lights.light_energy = 0.5
	bathroom_lights.light_color = Color(0.4, 0, 0)
	$AudioStreamPlayer.play()
	$figure.visible = true
	await get_tree().create_timer(0.1).connect("timeout", fade_light)

func fade_light():
	if bathroom_lights.light_energy <= .005: 
		bathroom_lights.light_energy = 0
		end_game.emit()
		return
	await get_tree().create_timer(0.1).connect("timeout", fade_light)
	bathroom_lights.light_energy -= .005
