extends CanvasLayer

@export var toolbar: Control

func _ready() -> void:
	toolbar.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("SIM.TOOLBAR"):
		if toolbar.visible:
			toolbar.hide()
		else:
			toolbar.show()

func _on_main_menu_pressed() -> void:
	EventBus.system_state_changed.emit(System.States.MENU)
