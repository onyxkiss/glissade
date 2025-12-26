#pragma once

#include <godot_cpp/classes/ref_counted.hpp>
#include "sim_var_definition.h"

using namespace godot;

class SimVar : public RefCounted {
    GDCLASS(SimVar, RefCounted);

public:
	void set_value(const Variant &p_value);
	Variant get_value() const;
    
	static bool validate_type(const Variant &v);
    static bool validate_range(const Variant &v);

protected:
    static void _bind_methods();

private:
	Ref<SimVarDefinition> def;
	Variant value;
};