include <x_carriage.scad>

//color("blue") translate([ncx+ecx-0.7, ocy/2+2.5, 19.5]) rotate([180, 0, 0]) e3d_v6_175();
//%x_carriage_v5();
//translate([-3.425, 0, 0]) %x_carriage_direct_drive();
//x_carriage_1s(12, -1, 3);
//x_carriage_1s_stl();
//translate([ncx*2-ecx*2, 0, 0]) mirror([1, 0, 0]) x_carriage_1s_stl();
//translate([0, 0, -0.2]) x_carriage_top();
translate([-(ncx-ecx), ncy/1.4, 0]) rotate([180, 0, 0]) x_carriage_top();
//translate([-6, 38.08, -10.16]) rotate([90, 0, 90]) color("Red") x_belt_clamp();