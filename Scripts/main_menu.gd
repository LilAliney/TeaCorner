extends Control

@onready var settings_panel := $SettingsPanel
@onready var credits_panel := $CreditsPanel

func _ready():
	settings_panel.hide()
	credits_panel.hide()

# PLAY
func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

# SETTINGS
func _on_settings_button_pressed():
	settings_panel.show()

# CREDITS
func _on_credits_button_pressed():
	credits_panel.show()

func _on_close_button_pressed() -> void:
	settings_panel.hide()
	credits_panel.hide()
