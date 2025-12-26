class_name Utils

static func get_map_instance() -> Node:
	return Gameplay.current_map_instance

static func get_children_by_class_recursive(parent: Node, type: String) -> Array[Node]:
	var results: Array[Node] = []

	for child in parent.get_children():
		if child.is_class(type):
			results.append(child)
		var child_results = get_children_by_class_recursive(child, type)
		results.append_array(child_results)

	return results
