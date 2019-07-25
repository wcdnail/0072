$fn=64;

LM8UU_OD=16.2;
LM8UU_HGHT=25;

module linearBearing(od=LM8UU_OD, hght=LM8UU_HGHT) {
    rotate([-90, 0, 0]) cylinder(d=od, h=hght);
}

module l_x_end_top() {
    difference() {
        translate([0, 70, 11]) rotate([180, 0, 0]) import("printedparts/2xCoreXY_X-End_Bolt.stl");
        translate([17.5, 3, 0.5]) linearBearing();
        translate([17.5, 42, 0.5]) linearBearing();
    }
}

module l_x_end_bottom() {
    difference() {
        translate([0, 0, -10.2]) rotate([0, 0, 0]) import("printedparts/2xCoreXY_X-End_Nut.stl");
        translate([17.5, 3, 0.5]) linearBearing();
        translate([17.5, 42, 0.5]) linearBearing();
    }
}

l_x_end_bottom();