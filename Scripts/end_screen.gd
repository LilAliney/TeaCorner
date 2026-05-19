extends CanvasLayer

@onready var panel := $Panel
@onready var title_label := $Panel/VBoxContainer/TitleLabel
@onready var coins_label := $Panel/VBoxContainer/CoinsLabel

func _ready():
	panel.hide()

func reveal():
	title_label.text = "🎉 Coco's droom is werkelijkheid!"
	coins_label.text = "Je verdiende 🪙 %d munten!" % Economy.coins
	panel.show()
	print("End screen shown!")

func _input(event):
	# Check if ANY key is pressed when end screen is visible
	if panel.visible and event is InputEventKey and event.pressed:
		print("Key pressed!")
		get_tree().paused = false
		get_tree().reload_current_scene()
