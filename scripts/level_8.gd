extends Level

@onready var figure = $figure

var background_music: AudioStreamPlayer
var played_sound:bool = false

func _ready():
	super()
	squeaky_light()
	background_music = singleton.background_music
	figure.animation_player.connect("animation_finished", on_animation_finished)

func _physics_process(delta):
	pass

func _on_walk_area_body_entered(body):
	if body is CharacterBody3D and !played_sound:
		played_sound = true
		figure.animation_player.play("walking")
		$AudioStreamPlayer.play()

func on_animation_finished(animation_name):
	remove_child(figure)
	background_music.stop()
	background_music.stream = load("res://sounds/nightmare-sequence-23188.mp3")
	background_music.play()
