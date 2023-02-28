extends OmniLight3D

@export var texture: NoiseTexture2D
@export var flickering: bool

var value: float = 0.0
const MAX_VAL = 10000000

func _ready():
	randomize()
	value = randi() % MAX_VAL
	
func _physics_process(delta):
	if flickering:
		value += 0.5
		if value > MAX_VAL:
			value = 0
		var sample = texture.noise.get_noise_1d(value)
		sample = abs(sample)
		
		light_energy = sample
