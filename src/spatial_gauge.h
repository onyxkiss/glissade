#pragma once

#include <godot_cpp/classes/node3d.hpp>
#include <godot_cpp/classes/tween.hpp>
#include <sim_var_definition.h>

using namespace godot;

class SpatialGauge : public Node3D {
	GDCLASS(SpatialGauge, Node3D)

protected:
	static void _bind_methods();

private:
	Ref<SimVarDefinition> sim_var_def;
	Dictionary states;
};