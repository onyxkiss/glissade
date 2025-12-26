#pragma once

#include <godot_cpp/classes/node3d.hpp>
#include "craft_state.h"

using namespace godot;

class SpatialCraft : public Node3D {
	GDCLASS(SpatialCraft, Node3D)

protected:
	static void _bind_methods();

private:
    Ref<CraftState> craft_state;
};