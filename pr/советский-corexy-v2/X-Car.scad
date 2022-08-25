include <LM8UU-Custom.scad>
include <Rods-Custom.scad>

// Для сверки с оригинальными размерами 
module orig_XCar_Base() {
  %translate([0, 0, 11.1]) rotate([180, 0, 0]) import("x_carriage-16x25lm8uu-v1.2.stl");
}
module orig_XCar_DD_Top() {
  translate([0, 0, 11.1]) rotate([0, 0, 0]) import("x_carriage_directdrive_enhanced_no_chain_mount.stl");
}

// Параметры каретки X
CARCX=80;
CARCY=70;
CARCZ=20;
// Расстояние от края каретки до подшипника 
CARDrvEndge=2.4;

module LM8UU_Custom_Pair(isLeft) {
  translate([0,  XRODSDiff/2, 0]) LM8UU_Custom();
  translate([0, -XRODSDiff/2, 0]) LM8UU_Custom();
}


module XCar_Half(isLeft) {
  xPos = (isLeft ? -CARCX/2 : 0);
  xLM8UUPos = (isLeft ? LM8UULen/2+CARDrvEndge : CARCX/2-LM8UULen/2-CARDrvEndge);
  translate([xPos, 0, 0]) {
    //#translate([0, -CARCY/2, -CARCZ/2]) cube([CARCX/2, CARCY, CARCZ]);
    translate([xLM8UUPos, 0, 0]) LM8UU_Custom_Pair(isLeft = isLeft);
  }
}

translate([-5, 0, 0]) XCar_Half(isLeft=true);
translate([5, 0, 0]) XCar_Half(isLeft=false);

//orig_XCar_Base();
orig_XCar_DD_Top();