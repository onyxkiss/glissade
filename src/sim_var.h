#pragma once

#include <godot_cpp/classes/object.hpp>

using namespace godot;

class SimVar : public Object {
    GDCLASS(SimVar, Object);

public:
	static bool validate_type(const Variant &v);
    static bool validate_range(const Variant &v);

protected:
    static void _bind_methods();
};