extends Node
# Autoload script voor het beheren van munten en geld
# Alle scripts kunnen Economy.coins en Economy.add_coins() gebruiken
class_name EconomyManager

var coins := 0
# Het huidige aantal munten

signal coins_changed(new_amount)
# Signaal dat wordt uitgezonden als munten veranderen

func add_coins(amount: int):
	# Voeg munten toe (of trek af als amount negatief is)
	coins += amount
	# Zeg tegen alle luisteraars dat munten zijn veranderd
	emit_signal("coins_changed", coins)
