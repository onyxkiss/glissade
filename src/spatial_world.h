#pragma once

#include <godot_cpp/classes/node3d.hpp>

using namespace godot;

class SpatialWorld : public Node3D {
	GDCLASS(SpatialWorld, Node3D)

public:
	// ...

protected:
	static void _bind_methods();

private:
	// ...
};