extends Node
# Zit al in groep "story_dialog" via Inspector? Zo niet, voeg toe!

@onready var panel := $DialogPanel
@onready var label := $DialogPanel/Label  # voeg een Label toe als kind van DialogPanel

func _ready():
	panel.hide()

func show_text(text: String):
	label.text = text
	panel.show()
	await get_tree().create_timer(4.0).timeout
	panel.hide()
