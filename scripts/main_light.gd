extends Node3D

func _ready():
	pass

func _physics_process(delta):
	pass

func start():
	$AnimationPlayer.play("swing")
	$SqueakSound.play()
