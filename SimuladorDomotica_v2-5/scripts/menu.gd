extends Node2D


var scene = load("res://scene/piso_1.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_packed(scene)
	Info.general_info.visible = true
	Info.timer.start()
