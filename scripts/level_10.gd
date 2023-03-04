extends Level

var played_sound:bool = false
var door_open:bool = false

@onready var bathroom_door = $BathroomDoor

func _ready():
	super()
#	squeaky_light()

func _physics_process(delta):
	pass

func _on_door_open_area_body_entered(body):
	if body is CharacterBody3D and !door_open:
		door_open = true
		bathroom_door.creak_open()
