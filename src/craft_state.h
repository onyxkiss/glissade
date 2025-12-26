#pragma once

#include <godot_cpp/classes/ref_counted.hpp>
#include "sim_var.h"
#include "craft_system.h"
#include "craft_data.h"

using namespace godot;

class CraftState : public RefCounted {
	GDCLASS(CraftState, RefCounted);

public:
	void set_sim_var(const StringName &name);
	Variant get_sim_var(const StringName &name) const;

protected:
	static void _bind_methods();

private:
	AHashMap<StringName, Ref<SimVar>> sim_vars;
	Vector<CraftSystem> craft_systems;
	Ref<CraftData> craft_data;
};