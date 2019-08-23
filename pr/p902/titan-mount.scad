use <../parts/fans.scad>
use <../parts/chamfers.scad>
use <../parts/open-cable-chain/new-chain.scad>
include <titan-common.scad>

$fn=64;
ShowAll=true;
PreRender=false;
ShowMounter=false;
ShowSinkFan40=false;
ShowSinkFan30=false;
ShowFanDuct=false;

TXOffset=-3;
TYOffset=0;
TZOffset=2;
TZRot=0;

module Full_Assembly(smallFan=false) {
  if (false) {
    %X_Car_Draft(cla=.7);
  }
  %color("SlateGrey", 0.7) translate([0, 0, 0]) rotate([0, 0, 180]) import("parts1/x-carriage-1.STL");
  rotate([0, 0, TZRot]) translate([TXOffset+8, TYOffset-5, TZOffset+36]) rotate([-90]) import("../parts/titan/BRACKET_PRINTED.stl");
  rotate([0, 0, TZRot]) translate([TXOffset-3.1, TYOffset-2, TZOffset+0.53]) rotate([0, 0, 180]) {
    %translate([-11.1, -11, 35.6]) E3D_Titan_Base(cla=.4);
    %translate([0, -11, 9.12]) rotate([0, 0, 90]) E3D_v6_175(cla=.4);
  }
  if (WithChainMount) { // Chain 
    color("Pink") translate([ChainMounterXOffs-44, 47.5, ChainMounterHeight+40])
      rotate([-90, 0, 0]) 
      rotate([0, 0, -90]) {
        render() { 
          nobar_end1();
          translate([0, -17, 2]) rotate([-5, 0, 0]) {
            nobar_chain();
            translate([0, -17, 2]) rotate([-5, 0, 0]) {
              nobar_chain();
              translate([0, -17, 2]) rotate([-5, 0, 0]) {
                nobar_chain();
              }
            }
          }
        }
      }
  }
}

if (ShowAll) {
  Full_Assembly();
}
if (false) {
  translate([0, -70, 0]) Full_Assembly();
  translate([0,  70, 0]) Full_Assembly(true);
}
if (ShowMounter) {
  rotate([-90]) Tevo_Titan_Adapter_1();
}
if (ShowSinkFan40) {
  rotate([0, -90]) Tevo_Titan_SinkFan();
}
if (ShowSinkFan30) {
  rotate([0, -90]) Tevo_Titan_SinkFan(smallFan=true);
}
if (ShowFanDuct) {
  translate([0, 0, 0]) Tevo_Titan_FanDuct("Yellow");
}

/*
TXWallWidth=2.4;
TYWallWidth=3.2;
TZWallWidth=3;
N17CX=42.5+0.4;
TX=N17CX+TXWallWidth*2;
TY=35.6+TYWallWidth*2;
TZ=45+TZWallWidth*2;

translate([TXOffset+6.95, -TY/2-3, TZ/2+11.15]) {
  difference() {
    cube([TX, TY, TZ], center=true);
    color("Cyan", .8) {
      translate([0, -TYWallWidth/2-1, TZWallWidth]) cube([N17CX, TY, TZ], center=true);
      translate([0, -25, 25]) rotate([-45]) cube([N17CX*2, 60, 150], center=true);
    }
    color("Red", .8) {
    }
  }
}
*/


