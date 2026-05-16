extends Panel

var target_order: Order = null

@onready var order_label := $VBoxContainer/OrderLabel
@onready var tea_option := $VBoxContainer/TeaOption
@onready var boba_option := $VBoxContainer/BobaOption
@onready var topping_option := $VBoxContainer/ToppingOption
@onready var close_button := $CloseButton

func _ready():
	tea_option.add_item("Milk Tea")
	tea_option.add_item("Green Tea")
	boba_option.add_item("Classic")
	boba_option.add_item("Strawberry")
	topping_option.add_item("None")
	topping_option.add_item("Mochi")
	
	hide()
	close_button.pressed.connect(_on_close_button_pressed)

func _on_close_button_pressed():
	visible = false

func show_order(order: Order):
	target_order = order
	order_label.text = "🧋 Bestelling:\n%s\n%s\n%s" % [
		order.tea_type,
		order.boba,
		order.topping
	]
	visible = true

func _on_station_click():
	if target_order == null:
		return
	
	var correct = (
		tea_option.get_item_text(tea_option.selected) == target_order.tea_type and
		boba_option.get_item_text(boba_option.selected) == target_order.boba and
		topping_option.get_item_text(topping_option.selected) == target_order.topping
	)
	
	if correct:
		Economy.add_coins(5)
		get_tree().get_first_node_in_group("customer").queue_free()
		StoryManager.customer_served()
	else:
		order_label.text = "❌ Verkeerde bestelling!\nProbeer opnieuw."
		await get_tree().create_timer(1.5).timeout
		show_order(target_order)
		return
	
	visible = false


func _on_serve_button_pressed() -> void:
	pass # Replace with function body.
