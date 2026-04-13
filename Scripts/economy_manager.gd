extends Node
class_name EconomyManager

var coins := 0

signal coins_changed(new_amount)

func add_coins(amount: int):
	coins += amount
	emit_signal("coins_changed", coins)
