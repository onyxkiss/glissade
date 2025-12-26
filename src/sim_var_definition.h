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

	StringName get_name() const;
	void set_name(const StringName &p_name);

	Type get_type() const;
	void set_type(Type p_type);

	Unit get_unit() const;
	void set_unit(Unit p_unit);

	Variant get_default_value() const;
	void set_default_value(const Variant &p_value);

	Variant get_max_value() const;
	void set_max_value(const Variant &p_value);

	Variant get_min_value() const;
	void set_min_value(const Variant &p_value);

protected:
	static void _bind_methods();

private:
	StringName name;
	Type type;
	Unit unit = NONE;

	Variant default_value;
	Variant max_value;
	Variant min_value;
};