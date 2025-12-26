extends Menu

@export var darken: Control

func _ready() -> void:
	super()
	EventBus.system_state_changed.connect(_on_system_state_changed)

func _on_system_state_changed(state: System.States) -> void:
	_update_darken(state)

func _update_darken(state: System.States) -> void:
	match state:
		System.States.GAME: pass
		System.States.MENU: darken.show()
		System.States.DISCONNECTED: darken.hide()
