extends StaticBody2D

func _ready():
	input_pickable = true

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var customer = get_tree().get_first_node_in_group("customer")
		if customer == null:
			return
		
		# Find the popup panel and show it
		var popup = get_node("/root/Main/Panel")
		if popup:
			popup.show_order(customer.order)
			popup.visible = true
