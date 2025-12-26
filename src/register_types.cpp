#include "register_types.h"

#include <gdextension_interface.h>
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/core/defs.hpp>
#include <godot_cpp/godot.hpp>

#include "simulation.h"
#include "sim_var.h"
#include "sim_var_definition.h"
#include "spatial_world.h"
#include "spatial_craft.h"
#include "spatial_gauge.h"
#include "craft_state.h"
#include "craft_data.h"
#include "craft_system.h"
#include "fdm_exec.h"
#include "fdm_system.h"
#include "jsb_system.h"
#include "jsb_exec.h"
#include "mission.h"
#include "vector2_64.h"
#include "vector3_64.h"


using namespace godot;

void initialize_gdextension_types(ModuleInitializationLevel p_level)
{
	if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
		return;
	}
	GDREGISTER_RUNTIME_CLASS(Simulation)
	GDREGISTER_RUNTIME_CLASS(SimVar)
	GDREGISTER_RUNTIME_CLASS(SimVarDefinition)
	GDREGISTER_RUNTIME_CLASS(SpatialWorld)
	GDREGISTER_RUNTIME_CLASS(SpatialCraft)
	GDREGISTER_RUNTIME_CLASS(SpatialGauge)
	GDREGISTER_RUNTIME_CLASS(CraftState)
	GDREGISTER_RUNTIME_CLASS(CraftData)
	GDREGISTER_RUNTIME_CLASS(CraftSystem)

	GDREGISTER_ABSTRACT_CLASS(FDMSystem)
	GDREGISTER_INTERNAL_CLASS(FDMExec)
	GDREGISTER_RUNTIME_CLASS(JSBSystem)
	GDREGISTER_INTERNAL_CLASS(JSBExec)

	GDREGISTER_RUNTIME_CLASS(Mission)

	GDREGISTER_RUNTIME_CLASS(Vector2_64)
	GDREGISTER_RUNTIME_CLASS(Vector3_64)
}

void uninitialize_gdextension_types(ModuleInitializationLevel p_level) {
	if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
		return;
	}
}

extern "C"
{
	// Initialization
	GDExtensionBool GDE_EXPORT cpp_init(GDExtensionInterfaceGetProcAddress p_get_proc_address, GDExtensionClassLibraryPtr p_library, GDExtensionInitialization *r_initialization)
	{
		GDExtensionBinding::InitObject init_obj(p_get_proc_address, p_library, r_initialization);
		init_obj.register_initializer(initialize_gdextension_types);
		init_obj.register_terminator(uninitialize_gdextension_types);
		init_obj.set_minimum_library_initialization_level(MODULE_INITIALIZATION_LEVEL_SCENE);

		return init_obj.init();
	}
}