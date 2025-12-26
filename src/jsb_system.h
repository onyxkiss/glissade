#pragma once

#include "fdm_system.h"

using namespace godot;

class JSBSystem : public FDMSystem {
	GDCLASS(JSBSystem, FDMSystem);

public:
    // ...

protected:
	static void _bind_methods();

private:
    // ...
};