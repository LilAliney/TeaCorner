extends Panel
# Dit script bestuurt het OrderPanel:
# - Toont de bestelling van de klant
# - Laat de speler thee, boba en toppings kiezen
# - Controleert of de bestelling correct is
# - Geeft geld bij een correcte bestelling


# NODE REFERENTIES

# Label waarin de huidige bestelling wordt getoond
# find_child wordt gebruikt omdat de exacte plaats kan verschillen
@onready var current_order_label := find_child("CurrentOrderLabel", true, false)

# Dropdowns voor de keuzes van de speler
@onready var tea_option := $VBoxContainer/TeaOption
@onready var boba_option := $VBoxContainer/BobaOption
@onready var topping_option := $VBoxContainer/ToppingOption


# INITIALISATIE

func _ready():
	# Voeg standaard thee toe
	tea_option.add_item("Milk Tea")

	# Check of Green Tea is vrijgespeeld in de shop
	if get_node("/root/Main/CanvasLayer/ShopPanel").green_tea_unlocked:
		tea_option.add_item("Green Tea")

	# Mogelijke boba-keuzes
	boba_option.add_item("Classic")
	boba_option.add_item("Strawberry")

	# Mogelijke toppings
	topping_option.add_item("None")
	topping_option.add_item("Mochi")


# SERVE LOGICA

func _on_serve_button_pressed():
	# Zoek de huidige klant
	var current_customer = get_tree().get_first_node_in_group("customer")
	if current_customer == null:
		return

	# Ga ervan uit dat de bestelling correct is
	var correct := true

	# Vergelijk de gekozen thee
	if tea_option.get_item_text(tea_option.selected) != current_customer.order.tea_type:
		correct = false

	# Vergelijk de gekozen boba
	if boba_option.get_item_text(boba_option.selected) != current_customer.order.boba:
		correct = false

	# Vergelijk de gekozen topping
	if topping_option.get_item_text(topping_option.selected) != current_customer.order.topping:
		correct = false

	# In _on_serve_button_pressed(), replace the "if correct:" block with:
	if correct:
		Economy.add_coins(5)
		current_customer.queue_free()
			# Vertel de StoryManager dat een klant bediend is
		var story = get_node("/root/StoryManager")  # pas pad aan als nodig
		if story:	
			story.customer_served()
	visible = false


# INPUT (INTERACTIE)

func _unhandled_input(event):
	# Als de speler op de interactieknop drukt
	if event.is_action_pressed("interact"):
		# Zoek de huidige klant
		var customer = get_tree().get_first_node_in_group("customer")
		if customer == null:
			return

		# Open het OrderPanel
		var panel = get_node("/root/Main/CanvasLayer/OrderPanel")
		panel.show_order(customer.order)
		panel.visible = true


# BESTELLING TONEN

func show_order(order):
	# Veiligheidscheck: bestaat het label?
	if current_order_label == null:
		print("ERROR: CurrentOrderLabel not found")
		return

	# Toon de bestelling in het panel
	current_order_label.text = "Order:\n%s\n%s\n%s" % [
		order.tea_type,
		order.boba,
		order.topping
	]
