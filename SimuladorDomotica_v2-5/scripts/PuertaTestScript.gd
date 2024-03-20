extends StaticBody2D


@onready var abrir_cerrar = $AbrirCerrar

# Called when the node enters the scene tree for the first time.
func _ready():
	Info.puerta_emergencia.connect(puerta_desastre)
	Info.seismo.connect(puerta_desastre)

@onready var collision_shape_2d = $CollisionShape2D
@onready var inidcador_sala_actual = $"../InidcadorSalaActual"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rotation != 0:
		collision_shape_2d.disabled = true
	else:
		collision_shape_2d.disabled = false


func puerta_desastre():
	if rotation == 0:
		abrir_cerrar.play("abrir")
	
func _on_abrir_pressed():
	if rotation == 0:
		abrir_cerrar.play("abrir")


func _on_cerrar_pressed():
	if rotation != 0:
		abrir_cerrar.play("cerrar")

func _on_area_2d_body_entered(body):
	if body == Info.persona:
		if rotation == 0:
			abrir_cerrar.play("abrir")
			inidcador_sala_actual.text = "Entrance"
	else:
		print("Desconocido en la puerta")

func _on_area_2d_body_exited(body):
	if body == Info.persona:
		if rotation != 0:
			abrir_cerrar.play("cerrar")
	else:
		print("Desconocido en la puerta")
