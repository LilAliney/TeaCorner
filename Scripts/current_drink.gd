extends Node
# Houdt de huidige drank bij terwijl de speler door de stations gaat

var tea := ""
var boba := ""
var topping := ""

func reset():
	tea = ""
	boba = ""
	topping = ""

func is_complete() -> bool:
	return tea != "" and boba != "" and topping != ""
