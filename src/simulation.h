#pragma once

#include <godot_cpp/classes/node.hpp>
#include "sim_var_definition.h"
#include "sim_var_instance.h"
#include "craft_state.h"
#include "craft_data.h"

using namespace godot;

class Simulation : public Node {
	GDCLASS(Simulation, Node);

public:
	Variant get_world_sim_var(const StringName &name);
	void set_world_sim_var(const StringName &name, const Variant &value);
	
	Ref<CraftState> make_craft_from_data(const Ref<CraftData> &data);

protected:
	static void _bind_methods();

private:
	Vector<Ref<CraftState>> craft_states;	
    AHashMap<StringName, Ref<SimVarInstance>> world_sim_vars;
};