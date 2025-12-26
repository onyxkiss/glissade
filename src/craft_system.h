#pragma once

#include <godot_cpp/classes/resource.hpp>
#include "sim_var_definition.h"

using namespace godot;

class CraftSystem : public Resource {
	GDCLASS(CraftSystem, Resource);

public:
	Vector<SimVarDefinition> get_sim_vars_defs() const;

protected:
	static void _bind_methods();

private:
	Vector<SimVarDefinition> sim_var_defs;
};