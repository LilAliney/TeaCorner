extends CanvasLayer

@onready var panel := $Panel
@onready var title_label := $Panel/VBoxContainer/TitleLabel
@onready var coins_label := $Panel/VBoxContainer/CoinsLabel
@onready var play_again_button := $Panel/VBoxContainer/PlayAgainButton

func _ready():
	panel.hide()
	print("play_again_button: ", play_again_button)
	if play_again_button:
		play_again_button.pressed.connect(_on_play_again_pressed)
		print("Button connected!")
	else:
		print("ERROR: play_again_button is NULL!")

func reveal():
	print("Revealing end screen!")
	title_label.text = "🎉 Coco's droom is werkelijkheid!"
	coins_label.text = "Je verdiende 🪙 %d munten!" % Economy.coins
	panel.show()
	print("End screen shown!")

func _on_play_again_pressed():
	print("Play Again button pressed!")
	get_tree().paused = false
	print("Game unpaused")
	get_tree().reload_current_scene()
	print("Scene reloading...")
