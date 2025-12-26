#pragma once

#include <godot_cpp/classes/resource.hpp>
#include "fdm_exec.h"
#include "craft_system.h"

using namespace godot;

class FDMSystem : public CraftSystem {
	GDCLASS(FDMSystem, CraftSystem);

public:
    // ...

protected:
	static void _bind_methods();

private:
    FDMExec fdm_exec;
};