extends Label
# Toont het aantal munten in de hoek van het scherm
# Werkt samen met economy_manager.gd

func _ready():
	# Toon initieel 0 munten
	text = "🪙 0"
	# Luister naar veranderingen in het aantal munten
	Economy.coins_changed.connect(update_label)

func update_label(amount):
	# Zet het label bij met het nieuwe aantal munten
	text = "🪙 " + str(amount)
