extends Control

@onready var settings_panel := $SettingsPanel
@onready var credits_panel := $CreditsPanel

func _ready():
	$SettingsPanel/VBoxContainer/MusicSlider.value_changed.connect(_on_music_slider_changed)
	settings_panel.hide()
	credits_panel.hide()
	
func open_panel(panel):
	panel.show()
	panel.scale = Vector2(0.8, 0.8)

	var tween = create_tween()
	tween.tween_property(panel, "scale", Vector2(1, 1), 0.15)

# PLAY
func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

# SETTINGS
func _on_settings_button_pressed():
	open_panel(settings_panel)
	
func _on_music_slider_changed(value):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		linear_to_db(value)
	)

# CREDITS
func _on_credits_button_pressed():
	open_panel(credits_panel)

func _on_close_button_pressed() -> void:
	settings_panel.hide()
	credits_panel.hide()
