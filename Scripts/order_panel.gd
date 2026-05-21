extends Panel
# Script voor het bestelvenster waar de speler ingredienten kiest

var target_order: Order = null
# De bestelling van de huidige klant

@onready var order_label := $VBoxContainer/OrderLabel
@onready var tea_option := $VBoxContainer/TeaOption
@onready var boba_option := $VBoxContainer/BobaOption
@onready var topping_option := $VBoxContainer/ToppingOption
@onready var close_button := $CloseButton

func _ready():
	# Voeg alle mogelijke thee-opties toe
	tea_option.add_item("Milk Tea")
	tea_option.add_item("Green Tea")
	tea_option.add_item("Chocolate")
	
	# Voeg alle mogelijke boba-opties toe
	boba_option.add_item("Classic")
	boba_option.add_item("Strawberry")
	boba_option.add_item("Stars")
	
	
	# Voeg alle mogelijke topping-opties toe
	topping_option.add_item("None")
	topping_option.add_item("Mochi")
	topping_option.add_item("Cookies")

	# Maak dropdown tekst groter
	tea_option.add_theme_font_size_override("font_size", 45)
	boba_option.add_theme_font_size_override("font_size", 45)
	topping_option.add_theme_font_size_override("font_size", 45)

	# Maak popup menu tekst groter
	tea_option.get_popup().add_theme_font_size_override("font_size", 35)
	boba_option.get_popup().add_theme_font_size_override("font_size", 35)
	topping_option.get_popup().add_theme_font_size_override("font_size", 35)
	
	# Verberg het panel tot dat een klant aankomt
	hide()
	
	close_button.pressed.connect(_on_close_button_pressed)
	
	
func _on_close_button_pressed():
	# Sluit het bestelvenster zonder te serveren
	visible = false

func show_order(order: Order):
	# Toon de bestelling van de klant in het venster
	target_order = order
	order_label.text = "Bestelling:\n%s\n%s\n%s" % [
		order.tea_type,
		order.boba,
		order.topping
	]
	visible = true

func _on_station_click():
	# Deze functie wordt aangeroepen als de Serve-knop wordt ingedrukt
	if target_order == null:
		return
	
	# Controleer of de speler de juiste ingredienten heeft gekozen
	var correct = (
		tea_option.get_item_text(tea_option.selected) == target_order.tea_type and
		boba_option.get_item_text(boba_option.selected) == target_order.boba and
		topping_option.get_item_text(topping_option.selected) == target_order.topping
	)
	
	if correct:
		# Drank is correct! Geef munten en verwijder klant
		Economy.add_coins(25)
		get_tree().get_first_node_in_group("customer").queue_free()
		StoryManager.customer_served()
	else:
		# Drank is fout, toon foutmelding
		order_label.text = "❌ Verkeerde bestelling!\nProbeer opnieuw."
		await get_tree().create_timer(1.5).timeout
		show_order(target_order)
		return
	
	# Sluit het bestelvenster
	visible = false


func _on_serve_button_pressed() -> void:
	pass # Replace with function body.
