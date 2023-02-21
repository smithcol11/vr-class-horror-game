extends CharacterBody3D

@onready var camera: XRCamera3D = $XROrigin3D/XRCamera3D
@onready var origin: XROrigin3D = $XROrigin3D
@onready var left_hand: XRController3D = $XROrigin3D/LeftHand
@onready var right_hand: XRController3D = $XROrigin3D/RightHand

func _ready():
	pass

func _physics_process(delta):
	var move = $XROrigin3D/LeftHand.get_input("primary")
	
	if move:
		var forward: Vector3 = camera.transform.basis * Vector3(move.y, 0, move.x)
		velocity = Vector3(forward.x, 0, forward.z).normalized()
	else: velocity = Vector3.ZERO
	
	$CollisionShape3D.position = Vector3($XROrigin3D/XRCamera3D.position.x, .5, $XROrigin3D/XRCamera3D.position.z)
	
	move_and_slide()
	
