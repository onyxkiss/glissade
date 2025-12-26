#pragma once

#include <godot_cpp/classes/ref_counted.hpp>

using namespace godot;

class Vector2_64 : public RefCounted {
    GDCLASS(Vector2_64, RefCounted);

    double x = 0.0;
    double y = 0.0;

public:
    void set_x(double p_x);
    double get_x() const;
    void set_y(double p_y);
    double get_y() const;

protected:
    static void _bind_methods();
};
