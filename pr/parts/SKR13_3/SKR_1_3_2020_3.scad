//translate([0, 0, 0]) rotate([0, 0, 0]) import("SKR_bottom.stl");
//translate([0, 0, 70]) rotate([0, 0, 0]) import("SKR_MKSGen_LTop.stl");

difference() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("SKR_MKSGen_LTop.stl");
    color("Red") translate([65, 56, -12]) rotate([0, 0, 0]) scale([0.6, 0.6, 3]) import("../sm.stl");
}

//color("Red") translate([65, 56, -12]) rotate([0, 0, 0]) scale([0.6, 0.6, 0.5]) import("../sm.stl");


