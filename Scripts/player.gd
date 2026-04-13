extends CharacterBody2D
# Dit script bestuurt de speler:
# - Bewegen met de pijltjestoetsen / WASD
# - Interageren met klanten om een bestelling te openen


# INSTELBARE WAARDES

@export var speed := 120.0
# Snelheid van de speler


# BEWEGING

func _physics_process(_delta):
	# Richting waarin de speler beweegt
	var direction := Vector2.ZERO

	# Horizontale beweging
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1

	# Verticale beweging
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1

	# Normaliseer zodat diagonale beweging niet sneller is
	direction = direction.normalized()

	# Pas snelheid toe
	velocity = direction * speed

	# Beweeg de speler
	move_and_slide()


# INTERACTIE MET KLANTEN

func _unhandled_input(event):
	# Als de speler op de interactieknop drukt
	if event.is_action_pressed("interact"):
		# Zoek een klant in de groep "customer"
		var customer = get_tree().get_first_node_in_group("customer")
		if customer == null:
			return

		# Open het OrderPanel en toon de bestelling
		var panel = get_node("/root/Main/CanvasLayer/OrderPanel")
		panel.show_order(customer.order)
		panel.visible = true
