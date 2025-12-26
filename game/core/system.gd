extends Node
class_name System

@export var menu: CanvasLayer

const title_map: String = "title"
const map_folder_path: String = "res://maps/"

enum States {GAME, MENU, DISCONNECTED} # GAME: Gameplay is unpaused; MENU: The gameplay is paused and the main menu is shown; DISCONNECTED: Title screen.
static var system_state: States

func _ready() -> void:
	EventBus.system_state_changed.connect(_on_state_changed)
	EventBus.system_state_changed.emit(States.DISCONNECTED)

static func get_state() -> States:
	return system_state

func _on_state_changed(state: States) -> void:
	system_state = state

	match state:
		States.GAME: 
			menu.hide()
			Gameplay.unpause()
		States.MENU: 
			menu.show()
			Gameplay.pause()
		States.DISCONNECTED: 
			menu.show()
			Gameplay.request_map_change(title_map)

func _show_main_menu() -> void:
	menu.show()
	Gameplay.pause()

func _hide_main_menu() -> void:
	menu.hide()
	Gameplay.unpause()
