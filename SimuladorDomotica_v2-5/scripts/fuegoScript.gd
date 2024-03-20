extends Node2D

@onready var animacion = $Animacion


func _ready():
	animacion.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
