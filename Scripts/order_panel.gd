extends Panel

const popUp_scene = preload("res://Scenes/popUp.tscn")


func _on_station_click():
	var showPopUp = popUp_scene.instantiate()
	add_child(showPopUp)
