extends CanvasLayer

signal scene_loaded(packed_scene: PackedScene)

@export var _progress_bar: ProgressBar
@export var _poll_timer: Timer
@export var _hide_timer: Timer

var _is_loading: bool = false
var _scene_path: String
var _progress: Array = []

func _ready() -> void:
	_hide()
	_poll_timer.timeout.connect(_poll_loading)
	_hide_timer.timeout.connect(_hide)

func load_scene(path: String) -> void:
	if _is_loading:
		Cmd.error("Already loading a scene.")
		return

	_scene_path = path
	_progress.resize(1)
	_progress[0] = 0.0
	_is_loading = true

	self.visible = true
	_progress_bar.value = 0
	
	ResourceLoader.load_threaded_request(_scene_path)
	_poll_timer.start()

func _poll_loading() -> void:
	if not _is_loading:
		_poll_timer.stop()
		return

	var status = ResourceLoader.load_threaded_get_status(_scene_path, _progress)
	_progress_bar.value = _progress[0]

	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			pass
		ResourceLoader.THREAD_LOAD_LOADED:
			_finish_loading()
			_poll_timer.stop()
		ResourceLoader.THREAD_LOAD_FAILED:
			Cmd.error("Loading failed.")
			_is_loading = false
			_poll_timer.stop()
			self.visible = false

func _finish_loading() -> void:
	var packed_scene: PackedScene = ResourceLoader.load_threaded_get(_scene_path)
	scene_loaded.emit(packed_scene)
	
	_hide_timer.start()
	_is_loading = false
	_progress[0] = 0.0

func _hide() -> void:
	self.visible = false
