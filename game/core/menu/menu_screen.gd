class_name MenuScreen
extends Control

signal screen_change_requested(screen_name: String)

func request_screen_change(screen_name: String) -> void:
	screen_change_requested.emit(screen_name)
