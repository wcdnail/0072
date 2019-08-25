include <../z-temp/z-config.scad>
use <../x-carriage/x_carriage_lda_v1.3.scad>

// X Carriage top frame
XCarTopCZ=3.4;
// Titan mount width
MCX=62.5; 
// Titan mount length
MCY=40.0;
// Titan Z angle
TZRot=180;
// E3D hotend Z angle
E3DRot=0;

module E3D_Titan_Base(clr="DeepSkyBlue", cla=undef) {
  color(clr, cla) {
    translate([39, 50, 64]) rotate([0, 0, 180]) rotate([0, 90, 0]) import("../../parts/titan-mihatomi/e3d_Titan_extruder_-_e3d_extruder-1.STL");
  }
}

module E3D_v6_175(clr="DarkSlateGray", cla=undef) {
  color(clr, cla) translate([5.2, -2.5, 0]) rotate([0, 0, 0]) import("../../parts/E3D_v6_1.75mm_Universal.stl");
}

module CoreXY_Carriage_Titan(noRordsCheck=false, withMotor=false) {
  color("Khaki", 0.7) translate([0, 0, 21.5]) rotate([0]) render() CoreXY_X_Carriage_v3(true, e3d=false);
  
  rotate([0, 0, TZRot]) translate([-.05, 11, 30+XCarTopCZ+0.4]) {
    %translate([-11.1, -11, 35.6]) E3D_Titan_Base(cla=.4);
    %translate([0, -11, 9.12]) rotate([0, 0, E3DRot]) E3D_v6_175(cla=.4);
    %color("SlateGrey", 0.7) translate([-11.2, 2.79, 35.4]) rotate([0, 0, 180]) rotate([-90]) import("../../parts/titan/BRACKET_PRINTED.stl");
  }
}

CoreXY_Carriage_Titan();
