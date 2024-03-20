extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Info.mostrar_informe.connect(mostrar)
	Info.actualizar_informe.connect(act_datos)

func _on_button_pressed():
	visible = false

func mostrar():
	visible = true
	act_desaastres()

@onready var label_dia = $ColorRect/LabelDia
@onready var label_temperatura = $ColorRect/LabelTemperatura
@onready var label_humedad = $ColorRect/LabelHumedad
@onready var label_seismos = $ColorRect/LabelSeismos

func act_datos():
	var total_temp = 0
	for x in Info.media_temperatura:
		total_temp+= x
	var totoal_hum = 0
	for x in Info.media_humedad:
		totoal_hum += x
	label_dia.text = "DIA: " + str(Info.dia)
	
	label_temperatura.text = "Tempreatura media\n" + str(total_temp/12)
	label_humedad.text = "Humedad media\n" + str(totoal_hum/4)

func act_desaastres():
	label_seismos.text = "Seísmos: " + str(Info.count_seismo)
	$ColorRect/LableInncedios.text = "Incendios: : " + str(Info.count_incendio)
	$ColorRect/LabelFugas.text = "Fugas gas: " + str(Info.count_fugas)
