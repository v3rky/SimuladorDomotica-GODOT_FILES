extends CharacterBody2D

var aceleracion = 4


func _physics_process(delta):
	var input_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = lerp(velocity,input_vector * 150, delta * aceleracion)
	move_and_slide()

