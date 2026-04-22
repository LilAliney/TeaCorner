extends Area2D
# Gebruikt door alle 3 stations
# Stel in de Inspector in welk type dit station is

enum StationType { TEA, BOBA, TOPPING }

@export var station_type: StationType
@export var station_options: Array[String] = []

@onready var popup := $StationPopup

var player_nearby := false

func _ready():
	popup.hide()
	# Verbind klik
	input_pickable = true
	input_event.connect(_on_clicked)
	print("Station ready: ", name)
	print("Input pickable: ", input_pickable)

func _on_clicked(_viewport, event, _shape):
	# Filter: alleen echte muisklikken
	if not event is InputEventMouseButton:
		return
	if not event.button_index == MOUSE_BUTTON_LEFT:
		return
	if not event.pressed:
		return
	
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	
	var distance = global_position.distance_to(player.global_position)
	if distance > 80:
		print("Te ver weg! Afstand: ", distance)
		return
	
	open_popup()

func open_popup():
	# Vul de popup met de juiste opties
	var container = popup.get_node("VBoxContainer")
	# Verwijder oude knoppen
	for child in container.get_children():
		if child.name != "TitleLabel":
			child.queue_free()
	# Maak nieuwe knoppen
	for option in station_options:
		var btn = Button.new()
		btn.text = option
		btn.pressed.connect(func(): select_option(option))
		container.add_child(btn)
	popup.show()

func select_option(option: String):
	match station_type:
		StationType.TEA:
			CurrentDrink.tea = option
		StationType.BOBA:
			CurrentDrink.boba = option
		StationType.TOPPING:
			CurrentDrink.topping = option
	popup.hide()
	# Update de HUD
	get_tree().get_first_node_in_group("drink_hud").update_hud()
