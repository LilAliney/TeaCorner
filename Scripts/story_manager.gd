extends Node

var total_coins := 0
var goal_coins := 10  # Win when you reach 100 coins

func _ready():
	Economy.coins_changed.connect(_on_coins_changed)

func _on_coins_changed(amount: int):
	total_coins = amount
	if total_coins >= goal_coins:
		show_ending()

func show_ending():
	get_tree().paused = true
	var end_screen = get_tree().get_first_node_in_group("end_screen")
	if end_screen:
		end_screen.reveal()
