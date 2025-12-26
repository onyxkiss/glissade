extends RefCounted
## BuiltinCommands


const Util := preload("res://addons/limbo_console/util.gd")


static func register_commands() -> void:
#	Cmd.register_command(cmd_alias, "alias", "add command alias")
#	Cmd.register_command(cmd_aliases, "aliases", "list all aliases")
	Cmd.register_command(Cmd.clear_console, "clear", "clear console screen")
	Cmd.register_command(cmd_commands, "list", "list all commands")
	Cmd.register_command(Cmd.info, "echo", "display a line of text")
#	Cmd.register_command(cmd_eval, "eval", "evaluate an expression")
	Cmd.register_command(cmd_exec, "exec", "execute commands from file")
	Cmd.register_command(cmd_fps_max, "fps_max", "limit framerate")
#	Cmd.register_command(cmd_fullscreen, "fullscreen", "toggle fullscreen mode")
	Cmd.register_command(cmd_help, "help", "show command info")
	Cmd.register_command(cmd_log, "log", "show recent log entries")
	Cmd.register_command(cmd_quit, "quit", "exit the application")
	Cmd.register_command(cmd_unalias, "unalias", "remove command alias")
	Cmd.register_command(cmd_vsync, "vsync", "adjust V-Sync")
	Cmd.register_command(Cmd.erase_history, "erase_history", "erases current history and persisted history")
	Cmd.add_argument_autocomplete_source("help", 1, Cmd.get_command_names.bind(true))


static func cmd_alias(p_alias: String, p_command: String) -> void:
	Cmd.info("Adding %s => %s" % [Cmd.format_name(p_alias), p_command])
	Cmd.add_alias(p_alias, p_command)


static func cmd_aliases() -> void:
	var aliases: Array = Cmd.get_aliases()
	aliases.sort()
	for alias in aliases:
		var alias_argv: PackedStringArray = Cmd.get_alias_argv(alias)
		var cmd_name: String = alias_argv[0]
		var desc: String = Cmd.get_command_description(cmd_name)
		alias_argv[0] = Cmd.format_name(cmd_name)
		if desc.is_empty():
			Cmd.info(Cmd.format_name(alias))
		else:
			Cmd.info("%s is alias of: %s %s" % [
				Cmd.format_name(alias),
				' '.join(alias_argv),
				Cmd.format_tip(" // " + desc)
			])


static func cmd_commands() -> void:
	Cmd.info("Available commands:")
	for name in Cmd.get_command_names(false):
		var desc: String = Cmd.get_command_description(name)
		name = Cmd.format_name(name)
		Cmd.info(name if desc.is_empty() else "%s -- %s" % [name, desc])


static func cmd_eval(p_expression: String) -> Error:
	var exp := Expression.new()
	var err: int = exp.parse(p_expression, Cmd.get_eval_input_names())
	if err != OK:
		Cmd.error(exp.get_error_text())
		return err
	var result = exp.execute(Cmd.get_eval_inputs(),
		Cmd.get_eval_base_instance())
	if not exp.has_execute_failed():
		if result != null:
			Cmd.info(str(result))
		return OK
	else:
		Cmd.error(exp.get_error_text())
		return ERR_SCRIPT_FAILED


static func cmd_exec(p_file: String, p_silent: bool = true) -> void:
	if not p_file.ends_with(".lcs"):
		# Prevent users from reading other game assets.
		p_file += ".lcs"
	if not FileAccess.file_exists(p_file):
		p_file = "user://" + p_file
	Cmd.execute_script(p_file, p_silent)


static func cmd_fps_max(p_limit: int = -1) -> void:
	if p_limit < 0:
		if Engine.max_fps == 0:
			Cmd.info("Framerate is unlimited.")
		else:
			Cmd.info("Framerate is limited to %d FPS." % [Engine.max_fps])
		return

	Engine.max_fps = p_limit
	if p_limit > 0:
		Cmd.info("Limiting framerate to %d FPS." % [p_limit])
	elif p_limit == 0:
		Cmd.info("Removing framerate limits.")


static func cmd_fullscreen() -> void:
	if Cmd.get_viewport().mode == Window.MODE_WINDOWED:
		# get_viewport().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
		Cmd.get_viewport().mode = Window.MODE_FULLSCREEN
		Cmd.info("Window switched to fullscreen mode.")
	else:
		Cmd.get_viewport().mode = Window.MODE_WINDOWED
		Cmd.info("Window switched to windowed mode.")


static func cmd_help(p_command_name: String = "") -> Error:
	if p_command_name.is_empty():
		Cmd.print_line(Cmd.format_tip("Type %s to list all available commands." %
				[Cmd.format_name("list")]))
		Cmd.print_line(Cmd.format_tip("Type %s to get more info about the command." %
				[Cmd.format_name("help command")]))
		return OK
	else:
		return Cmd.usage(p_command_name)


static func cmd_log(p_num_lines: int = 10) -> Error:
	var fn: String = ProjectSettings.get_setting("debug/file_logging/log_path")
	var file = FileAccess.open(fn, FileAccess.READ)
	if not file:
		Cmd.error("Can't open file: " + fn)
		return ERR_CANT_OPEN
	var contents := file.get_as_text()
	var lines := contents.split('\n')
	if lines.size() and lines[lines.size() - 1].strip_edges() == "":
		lines.remove_at(lines.size() - 1)
	lines = lines.slice(maxi(lines.size() - p_num_lines, 0))
	for line in lines:
		Cmd.print_line(Util.bbcode_escape(line), false)
	return OK


static func cmd_quit() -> void:
	Cmd.get_tree().quit()


static func cmd_unalias(p_alias: String) -> void:
	if Cmd.has_alias(p_alias):
		Cmd.remove_alias(p_alias)
		Cmd.info("Alias removed.")
	else:
		Cmd.warn("Alias not found.")


static func cmd_vsync(p_mode: int = -1) -> void:
	if p_mode < 0:
		var current: int = DisplayServer.window_get_vsync_mode()
		if current == 0:
			Cmd.info("V-Sync: disabled.")
		elif current == 1:
			Cmd.info('V-Sync: enabled.')
		elif current == 2:
			Cmd.info('Current V-Sync mode: adaptive.')
		Cmd.info("Adjust V-Sync mode with an argument: 0 - disabled, 1 - enabled, 2 - adaptive.")
	elif p_mode == DisplayServer.VSYNC_DISABLED:
		Cmd.info("Changing to disabled.")
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	elif p_mode == DisplayServer.VSYNC_ENABLED:
		Cmd.info("Changing to default V-Sync.")
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	elif p_mode == DisplayServer.VSYNC_ADAPTIVE:
		Cmd.info("Changing to adaptive V-Sync.")
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
	else:
		Cmd.error("Invalid mode.")
		Cmd.info("Acceptable modes: 0 - disabled, 1 - enabled, 2 - adaptive.")
