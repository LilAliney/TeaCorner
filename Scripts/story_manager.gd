extends Node

enum StoryStage {
	INTRO,
	MID,
	FINAL,
	END
}

var stage := StoryStage.INTRO
var customers_served := 0

func _ready():
	add_to_group("story_manager")

func customer_served():
	customers_served += 1
	print("Customers served: ", customers_served)
	
	if stage == StoryStage.INTRO and customers_served >= 3:
		stage = StoryStage.MID
		show_dialog("Je café wordt populairder!\nKlanten willen meer variëteit.")
	
	elif stage == StoryStage.MID and customers_served >= 2:
		stage = StoryStage.FINAL
		show_dialog("Een speciale klant komt eraan...\nDit is jouw grote test!")
	
	elif stage == StoryStage.FINAL and customers_served >= 2:
		stage = StoryStage.END
		show_ending()

func show_dialog(text: String):
	var dialog = get_tree().get_first_node_in_group("story_dialog")
	if dialog:
		dialog.show_text(text)

func show_ending():
	print("=== SHOW ENDING CALLED ===")
	get_tree().paused = true
	print("Game paused: ", get_tree().paused)
	
	var end_screen = get_tree().get_first_node_in_group("end_screen")
	print("Looking for node in group 'end_screen'...")
	print("End screen node: ", end_screen)
	
	if end_screen:
		print("Found end_screen! Type: ", end_screen.get_class())
		print("Calling reveal()...")
		end_screen.reveal()
		print("Reveal() finished!")
	else:
		print("ERROR: End screen is NULL - not in group!")
		# List all nodes to debug
		var all_nodes = get_tree().get_nodes_in_group("end_screen")
		print("All nodes in 'end_screen' group: ", all_nodes)
