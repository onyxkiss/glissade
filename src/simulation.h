#pragma once

#include <godot_cpp/classes/node.hpp>
#include "sim_var_definition.h"
#include "craft_state.h"
#include "craft_data.h"

using namespace godot;

class Simulation : public Node {
	GDCLASS(Simulation, Node);

public:	
	void set_world_sim_var(const StringName &name, const Variant &value);
	Variant get_world_sim_var(const StringName &name);
	
	Ref<CraftState> make_craft(const Ref<CraftData> &data);
	void kill_craft(const Ref<CraftState>);

protected:
	static void _bind_methods();

private:
	Vector<Ref<CraftState>> craft_states;	
    AHashMap<StringName, Ref<SimVar>> world_sim_vars;
};