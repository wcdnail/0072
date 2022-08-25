include <LM8UU-Custom.scad>
include <Rods-Custom.scad>

// Параметры каретки X
CARCX=80;
CARCY=80;
CARCZ=20;
// Расстояние от края каретки до подшипника 
CARDrvEndge=3;

#cube([CARCX, CARCY, CARCZ], center=true);

module LM8UU_Custom_Pair(isLeft) {
  xPos = (isLeft ? -CARCX/2+LM8UULen/2+CARDrvEndge : CARCX/2-LM8UULen/2-CARDrvEndge);
  translate([xPos, 0, 0]) {
    translate([0,  XRODSDiff/2, 0]) LM8UU_Custom();
    translate([0, -XRODSDiff/2, 0]) LM8UU_Custom();
  }
}


LM8UU_Custom_Pair(isLeft = true);
LM8UU_Custom_Pair(isLeft = false);