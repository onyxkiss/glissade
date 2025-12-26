#pragma once

#include <godot_cpp/classes/resource.hpp>

using namespace godot;

class SimVarDefinition : public Resource {
	GDCLASS(SimVarDefinition, Resource);

public:
	enum Type {
		FLOAT,
		INT,
		BOOL,
		STRING,
		VECTOR2,
		VECTOR3,
		VECTOR2_64,
		VECTOR3_64
	};

	enum Unit {
		NONE,
		METERS,
		FEET,
		KILOGRAMMES,
		LITERS,
		SECONDS,
		DEGREES,
		RADIANS,
		PASCALS,
		CELSIUS,
		G_FORCE,
		AMPS,
		HERTZ,
		JOULES,
		WATTS,
		VOLT,
		METERS_PER_SECOND,
		METERS_SQUARED,
		METERS_CUBIC,
		KILOGRAMMES_PER_SECOND,
		DEGREES_PER_SECOND,
		RADIANS_PER_SECOND,
		REVOLUTIONS_PER_MINUTE,
		RADIANS_PER_SECOND_SQUARED,
		DEGREES_PER_SECOND_SQUARED
	};

	StringName get_var_name() const;
	Type get_type() const;
	Unit get_unit() const;
	Variant get_default_value() const;
	Variant get_max_value() const;
	Variant get_min_value() const;

protected:
	static void _bind_methods();

private:
	StringName var_name;
	Type type;
	Unit unit = NONE;

	Variant default_value;
	Variant max_value;
	Variant min_value;
};