extends Level

var sound_played: bool = false
var background_music: AudioStreamPlayer 

func _ready():
	super()
	background_music = singleton.background_music
	squeaky_light()

func _physics_process(delta):
	pass

func _on_door_bang_area_body_entered(body):
	if !sound_played:
		sound_played = true
		
		background_music.stop()
		background_music.stream = load("res://sounds/suspense-creepy-ominous-ambience-14569.mp3")
		background_music.play()
		
		$DoorBang.play()

func _on_tv_off_area_body_entered(body):
	$TV/TVAudio.stop()
	$Lights/TVScreen.light_energy = 0
	$SubViewport/VideoStreamPlayer.stop()

