class_name Menu
extends Control

var current_screen: String
var current_screen_instance: MenuScreen

@export var default_screen: String
@export var screens: Dictionary[String, PackedScene]

signal screen_changed

func _ready() -> void:
	screen_changed.connect(_on_screen_change)
	change_screen(default_screen)

func change_screen(screen_name: String) -> void:
	if not screens.has(screen_name):
		Cmd.error("Screen not found: " + screen_name)
		return

	if current_screen_instance:
		current_screen_instance.queue_free()

	current_screen = screen_name
	current_screen_instance = screens[screen_name].instantiate()
	add_child(current_screen_instance)

	current_screen_instance.screen_change_requested.connect(change_screen)
	screen_changed.emit()

func _on_screen_change() -> void:
	pass
