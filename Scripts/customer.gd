extends CharacterBody2D
# Dit script bestuurt één klant van een groep klanten:
# - Bewegen naar de toonbank
# - Willekeurige bestelling maken
# - Geduld aftellen
# - Vertrekken als het te lang duurt


# INSTELBARE WAARDES (Inspector)

# Bewegingssnelheid van de klant
@export var speed := 80.0                 
# Waar de klant naartoe wandelt
@export var target_position := Vector2.ZERO  
# Hoe lang de klant wacht (seconden voor nu)
@export var patience_time := 8.0          

# Mogelijke keuzes voor de bestelling
@export var possible_teas := ["Milk Tea"]
@export var possible_boba := ["Classic", "Strawberry"]
@export var possible_toppings := ["None", "Mochi"]


# INTERNE VARIABELEN

# Is de klant aangekomen?
var has_arrived := false     
# Staat de klant te wachten?
var waiting := false         
# Resterend geduld
var patience_left := 0.0      
# De bestelling van deze klant
var order: Order              

# FUNCTIES

func _ready():
	# Zet de klant in een lijst/ groep
	# Zo kan de player makkelijk klanten vinden
	add_to_group("customer")

	# Maak de bestelling meteen aan
	# Zo bestaat order ALTIJD
	create_order()

func _physics_process(delta):
	# Als de klant al aangekomen is, telt het geduld af
	if has_arrived:
		handle_waiting(delta)
		return

	# Beweeg richting de doelpositie
	var direction = target_position - global_position

	# Als de klant bijna op de juiste plek is
	if direction.length() < 6:
		velocity = Vector2.ZERO
		has_arrived = true
		waiting = true
		patience_left = patience_time
		show_order()
		return

	# Normale beweging
	velocity = direction.normalized() * speed
	move_and_slide()


# GEDULD & WACHTEN

func handle_waiting(delta):
	# Geduld laten aftellen
	patience_left -= delta

	# Toon bestelling + resterend geduld
	$OrderLabel.text = "🧋 %ds\n%s\n%s\n%s" % [
		int(patience_left),
		order.tea_type,
		order.boba,
		order.topping
	]

	# Als het geduld op is → klant vertrekt boos
	if patience_left <= 0:
		leave_angry()


# BESTELLING

func create_order():
	# Maak een nieuwe bestelling
	order = Order.new()
	order.tea_type = possible_teas.pick_random()
	order.boba = possible_boba.pick_random()
	order.topping = possible_toppings.pick_random()

func show_order():
	# Toon de bestelling boven het hoofd van de klant
	$OrderLabel.visible = true
	$OrderLabel.text = "🧋\n%s\n%s\n%s" % [
		order.tea_type,
		order.boba,
		order.topping
	]


# VERTREKKEN

func leave_angry():
	# Verwijder de klant uit de scene
	queue_free()


# UPGRADES

func apply_speed_upgrade():
	# Upgrade waardoor klanten meer geduld hebben
	patience_time += 3
