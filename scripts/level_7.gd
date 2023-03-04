extends Level

@onready var kitchen_light: OmniLight3D = $Lights/Kitchen1

var played_sound:bool = false

func _ready():
	super()
	squeaky_light()
	$figure.animation_player.play("sitting")
	kitchen_light.visible = false

func _physics_process(delta):
	pass

func _on_figure_gone_area_body_entered(body):
	if body is CharacterBody3D and !played_sound:
		played_sound = true
		
		$KeyboardSound.stop()
		$figure.visible = false
		kitchen_light.visible = true
		
		$AudioStreamPlayer.play()
