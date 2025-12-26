#pragma once

#include <godot_cpp/classes/ref_counted.hpp>
#include "craft_data.h"
#include "sim_var_instance.h"

using namespace godot;

class CraftState : public RefCounted {
	GDCLASS(CraftState, RefCounted);

public:
	void initialize(const Ref<CraftData> &data, const Array &default_defs);
	Ref<SimVarInstance> get_sim_var_instance(const StringName &name);

protected:
	static void _bind_methods();

private:
	Ref<CraftData> craft_data;
	AHashMap<StringName, Ref<SimVarInstance>> sim_vars;
};