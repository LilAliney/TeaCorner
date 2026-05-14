extends CanvasLayer

func _ready():
	hide()

func reveal():
	$Panel/VBoxContainer/CoinsLabel.text = "Je hebt 🪙 %d munten verdiend!\nJe café is een succes!" % Economy.coins
	get_tree().paused = true
	visible = true

func _on_play_again_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
