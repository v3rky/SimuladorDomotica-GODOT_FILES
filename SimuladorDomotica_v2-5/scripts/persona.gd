extends CharacterBody2D
var aceleracion = 4


func _physics_process(delta):
	var input_vector = Input.get_vector("left","right","up","down")
	velocity = lerp(velocity,input_vector * 150, delta * aceleracion)
	move_and_slide()
