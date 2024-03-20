extends Node

@onready var cambio_piso = $Areas/CambioPiso
@onready var light_terraza_2 = $Lights/LightTerraza2
@onready var light_terraza_1 = $Lights/LightTerraza1

@onready var light_bath = $Lights/LightBath
@onready var light_launchary = $Lights/LightLaunchary
@onready var light_wc = $Lights/LightWC


@onready var light_remota = $Lights/LightRemota


func _ready():
	Info.timer_end.connect(timer_end_cicle)
	Info.cambio_intensidad.connect(cambio_intensidad)
	Info.incendio.connect(incendio_sprite)
	Info.emergencia_end.connect(end_emergencia)
	pausa_alarma.timeout.connect(animacion_alarma)
	cambio_intensidad()
	timer_end_cicle()
	

@onready var fuegotest = $fuego
@onready var bath_zone = $fuego/Bath
@onready var laun_zone = $fuego/Laun
@onready var wc_zone = $fuego/WC
@onready var dinning_zone = $fuego/Dinning
@onready var living_zone = $fuego/Living

@onready var pausa_alarma = $fuego/pausa

func incendio_sprite():
	pausa_alarma.start()
	animacion_alarma()
	var zona = int(randf_range(0,5))
	print(zona)
	if zona == 0:
		bath_zone.visible = true
	elif zona == 1:
		laun_zone.visible = true
	elif zona == 2:
		wc_zone.visible = true	
	elif zona == 3:
		dinning_zone.visible = true
	elif zona == 4:
		living_zone.visible = true	

func end_emergencia():
	pausa_alarma.stop()
	bath_zone.visible = false
	laun_zone.visible = false
	wc_zone.visible = false	
	dinning_zone.visible = false	
	living_zone.visible = false	

@onready var apagar_encender = $fuego/ApagarEncender
	
func animacion_alarma():
	apagar_encender.play("encender")
	apagar_encender.play("apagar")
	
	
func cambio_intensidad(): # Cmabiar la intensidad con la variable de el srcipt principal
	light_bath.energy = Info.intensidad_valor
	light_launchary.energy = Info.intensidad_valor
	light_wc.energy = Info.intensidad_valor
	light_terraza_1.energy = Info.intensidad_valor
	light_terraza_2.energy = Info.intensidad_valor
	light_remota.energy = Info.intensidad_valor
	

func timer_end_cicle(): # >_<
	if Info.horas > 18 or Info.horas < 7:
		light_terraza_1.visible = true
		light_terraza_2.visible = true
	else:
		light_terraza_1.visible = false
		light_terraza_2.visible = false




func _on_button_pressed():
	get_tree().change_scene_to_file("res://scene/piso_2.tscn")
	

func _on_area_2d_body_entered(body):
	get_tree().change_scene_to_file("res://scene/piso_2.tscn")


func _on_activacion_body_entered(body):
	cambio_piso.monitoring = true
	
@onready var inidcador_sala_actual = $InidcadorSalaActual

func _on_bath_body_entered(body):
	if body == Info.persona:
		light_bath.visible = true
		inidcador_sala_actual.text = "Bath"

func _on_launchary_body_entered(body):
	if body == Info.persona:
		light_launchary.visible = true
		inidcador_sala_actual.text = "Laun"
		

func _on_wc_body_entered(body):
	if body == Info.persona:
		light_wc.visible = true
		inidcador_sala_actual.text = "WC"
		

func _on_bath_body_exited(body):
	if body == Info.persona:
		light_bath.visible = false
		inidcador_sala_actual.text = "Hall"

func _on_launchary_body_exited(body):
	if body == Info.persona:
		light_launchary.visible = false
		inidcador_sala_actual.text = "Hall"

func _on_wc_body_exited(body):
	if body == Info.persona:
		light_wc.visible = false
		inidcador_sala_actual.text = "Hall"









func _on_check_button_light_toggled(toggled_on):
	light_remota.enabled = toggled_on


func _on_slider_light_value_changed(value):
	light_remota.energy = value /100
	
	
	
	
	



func _on_living_body_entered(body):
	inidcador_sala_actual.text = "Living"



func _on_dinning_body_entered(body):
	inidcador_sala_actual.text = "Dinning"


func _on_dinning_body_exited(body):
	inidcador_sala_actual.text = "Hall"
