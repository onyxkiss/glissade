#pragma once

#include <godot_cpp/classes/ref_counted.hpp>
#include "sim_var_definition.h"

using namespace godot;

class SimVarInstance : public RefCounted {
	GDCLASS(SimVarInstance, RefCounted);

public:
	void initialize(const Ref<SimVarDefinition> &p_def);
	Variant get_value() const;
	void set_value(const Variant &p_value);

protected:
	static void _bind_methods();

private:
	Ref<SimVarDefinition> def;
	Variant value;
};