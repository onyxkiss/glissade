#pragma once

#include <godot_cpp/classes/resource.hpp>
#include <godot_cpp/classes/packed_scene.hpp>
#include "craft_system.h"

using namespace godot;

class CraftData : public Resource {
	GDCLASS(CraftData, Resource);

public:
	Ref<PackedScene> get_scene() const;
	Vector<CraftSystem> get_systems() const;

protected:
	static void _bind_methods();

private:
	Ref<PackedScene> scene;
	Vector<CraftSystem> systems;
};