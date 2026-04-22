extends CanvasLayer
# Voeg toe aan groep "drink_hud" in Inspector

@onready var tea_label := $Panel/VBoxContainer/TeaLabel
@onready var boba_label := $Panel/VBoxContainer/BobaLabel
@onready var topping_label := $Panel/VBoxContainer/ToppingLabel

func _ready():
	update_hud()

func update_hud():
	tea_label.text = "🍵 " + (CurrentDrink.tea if CurrentDrink.tea != "" else "...")
	boba_label.text = "⚫ " + (CurrentDrink.boba if CurrentDrink.boba != "" else "...")
	topping_label.text = "✨ " + (CurrentDrink.topping if CurrentDrink.topping != "" else "...")
