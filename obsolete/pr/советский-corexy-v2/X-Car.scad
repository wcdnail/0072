include <LM8UU-Custom.scad>
include <Rods-Custom.scad>

// Для сверки с оригинальными размерами 
module orig_XCar_Base() {
  color("Green") translate([0, 0, 11.1]) rotate([180, 0, 0]) import("x_carriage-16x25lm8uu-v1.2.stl");
}
module orig_XCar_DD_Top() {
  color("Yellow") translate([0, 0, 11.1]) import("x_carriage_directdrive_enhanced_no_chain_mount.stl");
}

// Параметры каретки X
CARCX=80;
CARCY=70;
CARCZ=12;
// Расстояние от края каретки до подшипника 
CARDrvEndge=2.4;
// Расстояние м/у половинами
CARHalfsOffset=20;

module LM8UU_Custom_Pair() {
  translate([0,  XRODSDiff/2, 0]) LM8UU_Custom();
  translate([0, -XRODSDiff/2, 0]) LM8UU_Custom();
}

module LM8UU_Custom_Cyls(diam, cx) {
  translate([0,  XRODSDiff/2, 0]) rotate([0, 90, 0]) cylinder(d=diam, h=cx);
  translate([0, -XRODSDiff/2, 0]) rotate([0, 90, 0]) cylinder(d=diam, h=cx);
}

module Belt_Holes_Raw(bhCX) {
  color("Brown") {
    translate([0, 0.3, 10.1]) cube([bhCX, 2.3, 6.2]);
    translate([0, 7.34, 10.1]) cube([bhCX, 2.3, 6.2]);
    translate([0, 0.3-3, 3.1]) cube([bhCX, 2.3, 6.2]);
    translate([0, 7.32-3, 3.1]) cube([bhCX, 2.3, 6.2]);
  }
}

module Belt_Holes(xOffs=0, bhCX=300) {
  translate([xOffs-bhCX/2, 0.065, 10.9]) {
    Belt_Holes_Raw(bhCX=bhCX);
  }
}

module XCar_Half(isLeft) {
  zTopPos=11.1;
  xPos = (isLeft ? -CARCX/2 : 0);
  xLM8UUPos = (isLeft ? LM8UULen/2+CARDrvEndge : CARCX/2-LM8UULen/2-CARDrvEndge);
  //#translate([xPos, -CARCY/2, -CARCZ/2]) cube([CARCX/2, CARCY, CARCZ]);
  translate([xPos+xLM8UUPos, 0, 0]) LM8UU_Custom_Pair();

  beltMntCX=7;
  beltMntCY=45;

  #difference() {
    hull() {
      translate([xPos, -19.5, zTopPos]) cube([beltMntCX, beltMntCY, 19.7]);
      translate([xPos, 0, 0]) LM8UU_Custom_Cyls(LM8UUOutterDiam+2, beltMntCX+14);
    }
    if (isLeft) {
      // Left has belt mount
      Belt_Holes(xOffs=-CARCX/2+7, bhCX=50);
    }
    translate([xPos+beltMntCX, -19.5/1.5, zTopPos+2.1]) cube([50, beltMntCY/1.5, 50]);
  }
  
  #hull() {
    translate([xPos+beltMntCX+14-0.1, 0, 0]) LM8UU_Custom_Cyls(LM8UUOutterDiam+2, beltMntCX+12.1);
  }
}

translate([-CARHalfsOffset, 0, 0]) XCar_Half(isLeft=true);
translate([ CARHalfsOffset, 0, 0]) XCar_Half(isLeft=false);

*#%orig_XCar_Base();
*#%orig_XCar_DD_Top();

