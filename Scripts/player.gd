extends CharacterBody2D
# Script voor de speelbare character Coco
# zorgt voor beweging en interactie met de klanten

@export var speed := 120.0
# Beweging snelheid van Coco in pixels per seconde

func _ready():
	# Voeg speler toe aan groep zodat andere scripts hem kunnen vinden
	add_to_group("player")
	print("Player collision layer: ", collision_layer)
	print("Player collision mask: ", collision_mask)


func _physics_process(_delta):
	# Verwerkt beweging elke frame
	var direction := Vector2.ZERO
	
	# Lees invoer van de speler
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
		
	# Normaliseer richting zodat diagonale beweging niet sneller is
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

func _unhandled_input(event):
	if not (event is InputEventMouseButton and event.pressed):
		return
	# Kijk of de speler op een klant klikt om te serveren
	var customer = get_tree().get_first_node_in_group("customer")
	if customer == null:
		return
	# Check afstand tot klant
	if global_position.distance_to(customer.global_position) > 80:
		return
	# Check of de drank compleet is
	if not CurrentDrink.is_complete():
		print("Drank nog niet klaar!")
		return
	# Controleer of de drank correct is
	var correct = (
		CurrentDrink.tea == customer.order.tea_type and
		CurrentDrink.boba == customer.order.boba and
		CurrentDrink.topping == customer.order.topping
	)
	if correct:
		Economy.add_coins(5)
		StoryManager.customer_served()
		customer.queue_free()
		CurrentDrink.reset()
		get_tree().get_first_node_in_group("drink_hud").update_hud()
	else:
		# Verkeerde drank — reset en probeer opnieuw
		print("Verkeerde drank!")
		CurrentDrink.reset()
		get_tree().get_first_node_in_group("drink_hud").update_hud()
