extends CanvasLayer
# Voeg toe aan groep "end_screen" in de Inspector!
# Zet process_mode op "Always" zodat het werkt als game gepauzeerd is

func _ready():
	hide()

func reveal():
	$Panel/VBoxContainer/CoinsLabel.text = "Je verdiende 🪙 %d munten!" % Economy.coins
	get_tree().paused = true
	visible = true

func _on_play_again_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
