module x_carriage_v5() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("printedparts3/CoreXY_X-Carriage_E3D-V5.stl");
}

union() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("printedparts3/CoreXY_X-Carriage_E3D-V5.stl");
    translate([67, 36.5, 0]) cube([8.98, 13.5, 7]);
}