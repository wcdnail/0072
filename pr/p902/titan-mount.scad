use <../parts/fans.scad>
use <../parts/chamfers.scad>
use <../parts/open-cable-chain/new-chain.scad>
include <titan-common.scad>

// Smoothy
$fn=24;

// Titan mount width
MCX=62.5; 
// Titan mount length
MCY=40.0;
// Titan adapter width
TCX=64.0;
// Titan adapter length
TCY=MCY+2.0;
// Titan adapter height
TCZ=5;
// Titan adapter X offset
TXOffset=-3.4;
// Titan adapter Y offset
TYOffset=0.0;
// Titan adapter Z offset
TZOffset=-1.9;
// Titan Z angle
TZRot=0;
// E3D hotend Z angle
E3DRot=0;

rotate([0, 0, TZRot]) {
  //--- Titan mounter
  TMP0=[TXOffset+8, TYOffset-5, TZOffset+36+TCZ+0.1];
  %color("SlateGrey", 0.7) translate(TMP0) rotate([-90]) import("../parts/titan/BRACKET_PRINTED.stl");
  translate([TXOffset-3.1, TYOffset-2, TZOffset+0.53+TCZ+0.1]) rotate([0, 0, 180]) {
    %translate([-11.1, -11, 35.6]) E3D_Titan_Base(cla=.4);
    %translate([0, -11, 9.12]) rotate([0, 0, E3DRot]) E3D_v6_175(cla=.4);
  }
  //--- Titan mount adapter
  translate([TXOffset-3.1, TYOffset-1.8, TZOffset+TCZ/2+13]) {
    difference() {
      //-- Mount base
      color("Yellow", 0.7) {
        BS=[TCX, TCY, TCZ];
        translate([11.1, -TCY/2-1, 0]) chamfer_cube(BS, d=4, center=true);
      }
      color("Red") {
        //--- Bolt & nut holes
        BD=4.5;                       // Bolt hole diameter
        MHNS=[1.02, 1.02, 1.3];       // Nut scale
        MHNR=[0, 0, 90];              // Nut rotation
        MHNP=[0, 0, TCZ/2+2];         // Nut offset
        MHHP=[-15.9, -6, -TCZ/2-1];
        translate(MHHP+[0, 0, 0]) { cylinder(d=BD, h=TCZ+2); translate(MHNP) rotate(MHNR) scale(MHNS) nut("M4"); }
        translate(MHHP+[0, -15, 0]) { cylinder(d=BD, h=TCZ+2); translate(MHNP) rotate(MHNR) scale(MHNS) nut("M4"); }
        translate(MHHP+[0, -30, 0]) { cylinder(d=BD, h=TCZ+2); translate(MHNP) rotate(MHNR) scale(MHNS) nut("M4"); }
        translate(MHHP+[54, 0, 0]) { cylinder(d=BD, h=TCZ+2); translate(MHNP) rotate(MHNR) scale(MHNS) nut("M4"); }
        translate(MHHP+[54, -15, 0]) { cylinder(d=BD, h=TCZ+2); translate(MHNP) rotate(MHNR) scale(MHNS) nut("M4"); }
        translate(MHHP+[54, -30, 0]) { cylinder(d=BD, h=TCZ+2); translate(MHNP) rotate(MHNR) scale(MHNS) nut("M4"); }
        //---
      }
    }
  }
}

// X carriage & mount holes
%color("SlateGrey", 0.7) 
  translate([0, 0, 0]) rotate([0, 0, 180]) import("parts1/x-carriage-1.STL");

color("Red") {
}
