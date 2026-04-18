extends Panel

#Wat de klant wilt
var target_order: Order = null

#Wat de speler tot nu toe heeft gekozen
var selected_tea := ""
var selected_boba := ""
var selected_topping := ""

@onready var cup_label := $HBoxContainer/CupPanel/CupLabel
@onready var order_label := $HBoxContainer/CupPanel/OrderLabel

func _ready():
	hide()
	
#Toon het panel met de bestelling van de klant
func show_order(order: Order):
	target_order = order
	selected_tea = ""
	selected_boba = ""
	selected_topping = ""
	update_cup()
	order_label.text = "🧋 Bestelling:\n%s\n%s\n%s" % [
		order.tea_type,
		order.boba,
		order.topping
	]
	show()
	
#Update wat er in de beker zit
func  update_cup():
	var tea_line = "🍵 " + selected_tea if selected_tea != "" else "🍵 ..."
	var boba_line = "⚫ " + selected_boba if selected_boba != "" else "⚫ ..."
	var topping_line = "✨ " + selected_topping if selected_topping != "" else "✨ ..."
	cup_label.text = "Jouw beker:\n%s\n%s\n%s" % [tea_line, boba_line, topping_line]

func _on_milk_tea_pressed():
	selected_tea = "Milk Tea"
	update_cup()

func _on_green_tea_pressed():
	selected_tea = "Green Tea"
	update_cup()

func _on_classic_pressed():
	selected_boba = "Classic"
	update_cup()
	
func _on_strawberry_pressed():
	selected_boba = "Strawberry"
	update_cup()
	
func _on_none_pressed():
	selected_boba = "None"
	update_cup()
	
func _on_mochi_pressed():
	selected_topping = "Mochi"
	update_cup()
	
#Serve
func _on_serve_button_pressed():
	if target_order == null:
		return
	
	#Controleer of alles is gekozen
	if selected_tea == "" or selected_boba == "" or selected_topping == "":
		cup_label.text = "❌ Kies eerst alle\ningrediënten!"
		return
		
	var correct = (
		selected_tea == target_order.tea_type and
		selected_boba == target_order.boba and
		selected_topping == target_order.topping
	)
	
	if correct:
		Economy.add_coins(5)
		get_tree().get_first_node_in_group("customer").queue_free()
		StoryManager.customer_served()
	else:
		#Laat zien wat er fout was
		cup_label.text = "❌ Verkeerde bestelling!\nProbeer opnieuw."
		selected_tea = ""
		selected_boba = ""
		selected_topping = ""
		await get_tree().create_timer(1.5).timeout
		update_cup()
		return
	hide()
	
#Sluit panel zonder te serveren
func _on_close_button_pressed():
	hide()
		
func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		var customer = get_tree().get_first_node_in_group("customer")
		if customer == null:
			return
		show_order(customer.order)
		
		


func _on_tea_button_pressed() -> void:
	pass # Replace with function body.


func _on_classic_boba_button_pressed() -> void:
	pass # Replace with function body.


func _on_starwberry_pressed() -> void:
	pass # Replace with function body.
