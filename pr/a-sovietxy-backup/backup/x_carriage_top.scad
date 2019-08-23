include <z-config.scad>
use <x_carriage.scad>

//color("blue") translate([carCX+carXEdge-0.7, origCARWidth/2+2.5, 19.5]) rotate([180, 0, 0]) e3d_v6_175();
//%x_carriage_v5();
//%translate([-3.425, 0, 0]) x_carriage_direct_drive();

translate([-(carCX-carXEdge), (origCARWidth)/2, 0]) rotate([180, 0, 0]) x_carriage_1s_stl();
mirror([1, 0, 0]) translate([-(carCX-carXEdge), (origCARWidth)/2, 0]) rotate([180, 0, 0]) x_carriage_1s_stl();

//translate([0, 0, -0.2]) x_carriage_top();
translate([-(carCX-carXEdge), carCY/1.4, 0]) rotate([180, 0, 0]) x_carriage_top();

//translate([-6, 38.08, -10.16]) rotate([90, 0, 90]) color("Red") x_belt_clamp();
