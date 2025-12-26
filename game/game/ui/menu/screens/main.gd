extends MenuScreen

@export var continue_button: Button

func _ready() -> void:
	_update_buttons()
	EventBus.system_state_changed.connect(_on_system_state_changed)

func _update_buttons() -> void:
	match System.get_state():
		System.States.GAME:
			continue_button.show()
		System.States.MENU:
			continue_button.show()
		System.States.DISCONNECTED:
			continue_button.hide()

func _on_system_state_changed(state: System.States) -> void:
	_update_buttons()

func _on_continue_pressed() -> void:
	EventBus.system_state_changed.emit(System.States.GAME)
