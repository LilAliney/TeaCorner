extends Node2D
# Dit script is verantwoordelijk voor:
# - Het spawnen van klanten
# - Klanten laten binnenkomen via de ingang
# - Klanten laten wandelen naar de bestelplek


# VERANDERLIJKE WAARDES (Inspector)

# De scene van de klant die gespawned wordt
@export var customer_scene: PackedScene

# Node die de ingang van het café aanduidt
@export var entrance_point: NodePath

# Node waar de klant gaat staan om te bestellen
@export var order_spot: NodePath

# Tijd (in seconden) tussen twee klanten
@export var spawn_delay := 4.0



# INTERNE VARIABELEN

# Wordt later gebruikt om spawnen te pauzeren (bij upgrades, pauze, enz.)
var can_spawn := true



# FUNCTIES

func _ready():
	# Start automatisch de spawn-loop zodra de scene klaar is
	spawn_loop()


# SPAWN LOGICA

func spawn_loop():
	# Oneindige loop die om de spawn_delay seconden
	# probeert een nieuwe klant te spawnen
	while true:
		await get_tree().create_timer(spawn_delay).timeout
		spawn_customer()

func spawn_customer():
	# Zorg dat er maar één klant tegelijk is
	# (kan later uitgebreid worden naar een wachtrij)
	if get_child_count() > 1:
		return

	# Maak een nieuwe klant aan vanuit de scene
	var customer = customer_scene.instantiate()
	add_child(customer)

	# Haal de ingang en bestelplek op
	var entrance = get_node(entrance_point)
	var spot = get_node(order_spot)

	# Zet de klant aan de ingang
	customer.global_position = entrance.global_position

	# Geef de klant zijn doelpositie (toonbank)
	customer.target_position = spot.global_position
