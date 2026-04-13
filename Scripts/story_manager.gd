extends Node

enum StoryStage { INTRO, MID, FINAL, END }

var stage := StoryStage.INTRO
var customers_served := 0

func customer_served():
	customers_served += 1

	if stage == StoryStage.INTRO and customers_served >= 3:
		stage = StoryStage.MID
		show_dialog("Je café wordt populairder!\nKlanten willen meer variëteit.")

	elif stage == StoryStage.MID and customers_served >= 8:
		stage = StoryStage.FINAL
		show_dialog("Een speciale klant komt eraan...\nDit is jouw grote test!")

	elif stage == StoryStage.FINAL and customers_served >= 10:
		stage = StoryStage.END
		show_ending()

func show_dialog(text: String):
	var dialog = get_tree().get_first_node_in_group("story_dialog")
	if dialog:
		dialog.show_text(text)

func show_ending():
	# Pauzeer de game
	get_tree().paused = true
	# Toon het eindscherm
	var end_screen = get_tree().get_first_node_in_group("end_screen")
	if end_screen:
		end_screen.reveal()
