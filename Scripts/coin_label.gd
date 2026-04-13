extends Label

func _ready():
	text = "🪙 0"
	Economy.coins_changed.connect(update_label)

func update_label(amount):
	text = "🪙 " + str(amount)
