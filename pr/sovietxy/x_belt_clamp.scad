include <bconf.scad>
include <x_carriage.scad>

translate([-6, 38.08, -9.95]) rotate([90, 0, 90]) color("yellow") x_belt_clamp();
translate([0, OrigCARLen/2+5, -25]) rotate([90, 0, 0]) rotate([0, 270, 0]) color("red") optical_endstop();