#pragma once

#include "fdm_system.h"

using namespace godot;

class JSBExec : public FDMExec {
	GDCLASS(JSBExec, FDMExec);

public:
	// ...

protected:
	static void _bind_methods();

private:
	// ...
};