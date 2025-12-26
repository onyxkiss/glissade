#pragma once

#include <godot_cpp/classes/ref_counted.hpp>

using namespace godot;

class FDMExec : public RefCounted {
	GDCLASS(FDMExec, RefCounted);

public:
    // ...

protected:
	static void _bind_methods();

private:
    // ...
};