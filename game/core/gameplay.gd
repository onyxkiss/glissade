extends Node

var current_map_instance: Node = null
var current_map_name: String = ""

func _ready() -> void:
	Cmd.register_command(request_map_change, "map", "change map")

func pause() -> void:
	for child in get_children():
		child.process_mode = Node.PROCESS_MODE_DISABLED

func unpause() -> void:
	for child in get_children():
		child.process_mode = Node.PROCESS_MODE_INHERIT

func request_map_change(map_name: String) -> void:
	if map_name == current_map_name:
		Cmd.error("Already on map %s." % map_name)
		return

	var res_full_path: String = System.map_folder_path + map_name + ".tscn"
	var full_path: String
	
	if FileAccess.file_exists(res_full_path):
		full_path = res_full_path
	else:
		Cmd.error("Map not found: %s." % map_name)
		return

	current_map_name = map_name
	_change_map(full_path)

	if map_name != "title":
		EventBus.system_state_changed.emit(System.States.GAME)
	else:
		EventBus.system_state_changed.emit(System.States.DISCONNECTED)

func _change_map(full_path: String) -> void:
	if Load.is_connected("scene_loaded", _on_map_scene_loaded):
		Load.disconnect("scene_loaded", _on_map_scene_loaded)
	Load.connect("scene_loaded", _on_map_scene_loaded)
	Load.load_scene(full_path)

func _on_map_scene_loaded(packed_scene: PackedScene) -> void:
	var old_map_instance: Node = current_map_instance
	current_map_instance = packed_scene.instantiate()
	if old_map_instance:
		old_map_instance.queue_free()
	Gameplay.add_child(current_map_instance)

	EventBus.map_changed.emit(current_map_name)
	Cmd.debug("Went to map: %s." % current_map_name)
