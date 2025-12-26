#pragma once

#include <godot_cpp/classes/resource.hpp>
#include "craft_state.h"

using namespace godot;

class Mission : public Resource {
	GDCLASS(Mission, Resource);

public:
	Vector<CraftState> get_craft_states() const;

protected:
	static void _bind_methods();

 private:
	Vector<CraftState> craft_states;
}