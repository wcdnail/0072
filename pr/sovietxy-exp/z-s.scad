include <../sovietxy/z-config.scad>
use <../../openscad/nema17.scad>

module X_Idler() {
    translate([0, BARYLen+BARCY, 54]) rotate([0, 0, -90]) import("pp/XY_Idler_Bracket_0.01.STL");
}

module X_MotorMount() {
    translate([0, 55-BARCY, 54]) rotate([0, 0, -90]) import("pp/XY_Stepper_Mount_0.01.STL");
}

h_frame_2020(skipDims=true, transparentBars=true);
translate([0, 0, 20]) h_frame_2020(skipDims=true, transparentBars=true);
//X_MotorMount();
//X_Idler();

// Y rod
color("White") translate([-10, RODYLen, 94]) rotate([90]) cylinder(d=9, h=RODYLen, $fn=64);