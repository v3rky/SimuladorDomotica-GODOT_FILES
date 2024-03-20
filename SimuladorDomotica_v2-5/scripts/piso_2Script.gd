extends Node2D

@onready var cambio_piso = $CambioPiso
@onready var light_test_3 = $LightTest3
@onready var light_test_4 = $LightTest4
@onready var light_test_5 = $LightTest5
@onready var light_test_6 = $LightTest6
@onready var light_test = $LightTest
@onready var light_test_2 = $LightTest2
@onready var light_test_8 = $LightTest8
@onready var light_test_7 = $LightTest7

func _ready():
	cambio_intensidad()
	Info.timer_end.connect(timer_end_cicle)

func cambio_intensidad(): # Cmabiar la intensidad con la variable de el srcipt principal
	light_test_3.energy = Info.intensidad_valor
	light_test_4.energy = Info.intensidad_valor
	light_test_5.energy = Info.intensidad_valor
	light_test_6.energy = Info.intensidad_valor
	light_test.energy = Info.intensidad_valor
	light_test_2.energy = Info.intensidad_valor
	light_test_8.energy = Info.intensidad_valor
	light_test_7.energy = Info.intensidad_valor


func timer_end_cicle():
	if Info.horas > 18 or Info.horas < 7:
		light_test_7.visible = true
	else:
		light_test_7.visible = false

func _on_area_2d_body_entered(body):
	get_tree().change_scene_to_file("res://scene/piso_1.tscn")


func _on_activacion_body_entered(body):
	cambio_piso.monitoring = true


func _on_light_4_area_body_entered(body):
	if body == Info.persona:
		light_test_4.enabled = true


func _on_light_4_area_body_exited(body):
	if body == Info.persona:
		light_test_4.enabled = false


func _on_light_3_area_body_entered(body):
	if body == Info.persona:
		light_test_3.enabled = true


func _on_light_3_area_body_exited(body):
	if body == Info.persona:
		light_test_3.enabled = false


func _on_light_5_area_body_entered(body):
	if body == Info.persona:
		light_test_5.enabled = true


func _on_light_5_area_body_exited(body):
	if body == Info.persona:
		light_test_5.enabled = false

func _on_light_6_area_body_entered(body):
	if body == Info.persona:
		light_test_6.enabled = true


func _on_light_6_area_body_exited(body):
	if body == Info.persona:
		light_test_6.enabled = false



func _on_h_1_body_entered(body):
	if body == Info.persona:
		light_test_2.enabled = true


func _on_h_1_body_exited(body):
	if body == Info.persona:
		light_test_2.enabled = false



func _on_h_2_body_entered(body):
	if body == Info.persona:
		light_test_8.enabled = true


func _on_h_2_body_exited(body):
	if body == Info.persona:
		light_test_8.enabled = false


func _on_check_button_light_toggled(toggled_on):
		light_test.enabled = toggled_on



func _on_slider_light_value_changed(value):
	light_test.energy = value /100
