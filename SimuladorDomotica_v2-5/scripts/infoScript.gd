extends CanvasLayer

@onready var hora = $generalInfo/hora

@onready var persona = $generalInfo/Persona


@onready var timer = $generalInfo/Timer
@onready var general_info = $generalInfo
@onready var humedad = $generalInfo/humedad
@onready var temperatura = $generalInfo/temperatura


var minutos = 0 # Variable para los minutos
var horas = 0 # Variable para las horas del reloj
var grados = 5 # Variable para los minutos del reloj 
var humedad_count = 55
const list_temp = [5,5,7,9,12,16,18,18,15,13,7,6] # Lista de temperaaturas para recorrer
var media_humedad = []
var media_temperatura = []
var dia = 0
var count = 0
var temperatura_valor_random
var temperatura_mayor_menor
var count_seismo  = 0 
var count_incendio = 0
var count_fugas  = 0



# Variables para cargar al cambiar de piso
var persona_last_posotion = Vector2(149,174)

signal timer_end()

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	seismo_delay.timeout.connect(apagar_seismo)
	randomizador_temperatura()
	general_info.visible = false

func _on_timer_timeout(): # Función que se ejcuta por cada ciclo
	timer_end.emit() # Emite señal que se recibe en la escena del piso 1 (principalmenre luces)
	act_reloj() # Actualiza el label de la hora 
	act_temperatura() # Actualiza el valor de la temperatura
	act_humedad() # Actualiza el valor de la humedad 
	act_clima() # Actualiza el sprite del clima 

var rng = RandomNumberGenerator.new()
@onready var sprite_clima = $generalInfo/SpriteClima

func act_clima():
	if horas == 12 or horas == 19 or horas == 1 or horas == 8:
		if minutos == 30:
			var random_int =  int(randf_range(0,2))
			if random_int == 1:
				var random_int2 = int(randf_range(0,7))
				sprite_clima.set_frame(random_int2)
				print("CLIMA ACTUALIZADO FRAME:" + str(random_int2))

	if horas < 7 or horas > 19:
		if sprite_clima.frame == 5:
			sprite_clima.set_frame(3)
		if sprite_clima.frame == 6:
			sprite_clima.set_frame(2)
	else:
		if sprite_clima.frame == 3:
			sprite_clima.set_frame(5)
		if sprite_clima.frame == 2:
			sprite_clima.set_frame(6)

func act_humedad():
	if horas == 12 and minutos == 30:
		humedad_count = 52 - temperatura_valor_random
		append_media()
	elif horas == 15 and minutos == 30:
		humedad_count = 45 - temperatura_valor_random
		append_media()
	elif horas == 19 and minutos == 30:
		humedad_count = 50 - temperatura_valor_random
		append_media()
	elif horas == 23 and minutos == 30:
		humedad_count = 55 - temperatura_valor_random
		append_media()
	

	humedad.text = "Humedad\n" + str(humedad_count) + "%"

func append_media():
	media_humedad.append(humedad_count)
	
	
func act_temperatura():
	if minutos == 30:
		if horas % 2 == 0:
			grados = list_temp[count] + temperatura_valor_random

			temperatura.text = "Temperatura\n" + str(grados)+ "ºC"
			count += 1
			media_temperatura.append(grados) # media en el pop up
	if count == 12:
		count = 0

func randomizador_temperatura():
	temperatura_valor_random = int(randf_range(-3,5))

signal actualizar_informe()

func act_reloj():
	var horas_str 
	var minutos_str 
	if horas != 23 or minutos != 45:
		minutos += 15
		if minutos == 60:
			horas += 1
			minutos = 0
	else:
		horas = 0
		minutos = 0
		
	if horas < 10:
		horas_str = "0" + str(horas)
	else:
		horas_str = str(horas)
	if minutos == 0:
		minutos_str = "00"
	else:
		minutos_str= str(minutos)
	
	hora.text = horas_str + ": "+minutos_str
	
	if horas == 23 and minutos == 45:
		actualizar_informe.emit()
		media_temperatura = []
		media_humedad = []
	
	if horas == 0 and minutos == 0:
		dia += 1
		print("\nDIA: "+ str(dia))
		randomizador_temperatura()

@onready var alerta_seismo = $generalInfo/AlertaSeismo
@onready var alerta_incendio = $generalInfo/AlertaIncendio
@onready var alerta_gas = $generalInfo/AlertaGas
@onready var seismo_delay = $generalInfo/SeismoDelay
@onready var check_box_seismo = $generalInfo/CheckBoxSeismo


signal seismo()
func _on_check_box_seismo_toggled(toggled_on):
	if toggled_on:
		seismo_delay.start()
		seismo.emit()
		count_seismo += 1
		alerta_seismo.visible = true
	else:
		emergencia_end.emit()
		alerta_seismo.visible = false
		

func apagar_seismo():
	check_box_seismo.button_pressed = false
	alerta_seismo.visible = false
	emergencia_end.emit()
	
	
signal puerta_emergencia()
signal emergencia_end()
signal incendio()

func _on_check_box_incendio_toggled(toggled_on):
	if toggled_on:
		incendio.emit()
		puerta_emergencia.emit()
		alerta_incendio.visible = true
		count_incendio += 1 
		$generalInfo/AudioStreamPlayer2D.play()
	else:
		emergencia_end.emit()
		$generalInfo/AudioStreamPlayer2D.stop()
		alerta_incendio.visible = false


func _on_check_box_gas_toggled(toggled_on):
	if toggled_on:
		alerta_gas.visible = true
		puerta_emergencia.emit()
		count_fugas += 1
	else:
		emergencia_end.emit()
		alerta_gas.visible = false

func _on_check_button_pause_time_toggled(toggled_on):
	if toggled_on:
		timer.stop()
	else:
		timer.start() 


func _on_slider_time_value_changed(value):
	timer.wait_time = value/100 


@onready var persona_2 = $generalInfo/Persona2
func _on_check_button_añadir_persona_toggled(toggled_on):
	if toggled_on:
		persona_2.visible = true
	else:
		persona_2.visible = false

signal mostrar_informe()
func _on_button_pressed():
	mostrar_informe.emit()
	
	
signal cambio_intensidad()

var intensidad_valor = 1
func _on_slider_intensidad_value_changed(value):
	cambio_intensidad.emit()
	intensidad_valor = value/100
