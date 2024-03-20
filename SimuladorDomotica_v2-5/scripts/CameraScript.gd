extends Camera2D

@export var randomStrength: float = 20.0
@export var shakeFade: float = 1.0

var rng = RandomNumberGenerator.new()

var shake_strenght: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	Info.seismo.connect(apply_shake)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shake_strenght > 0:
		shake_strenght = lerpf(shake_strenght,0,shakeFade* delta)
		
		offset = randomOffset()

func apply_shake():
	shake_strenght = randomStrength


func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strenght,shake_strenght),rng.randf_range(-shake_strenght,shake_strenght))
