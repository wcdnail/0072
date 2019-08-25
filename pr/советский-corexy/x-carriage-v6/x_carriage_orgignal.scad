include <../z-temp/z-config.scad>
use <../z-temp/z.scad>

module XCar_LM8UU() {
  sz=XENDFullCZ;
  bhy=CARCY/2.8;
  bhz=LM8UUOutterDiam-3.5;
  bslicez=14.6;
  wsz=5;
  wz=6.7;
  // Linear bearing
  color("Blue") {
    translate([CARCX/2-LM8UULen, XRODSDiff/2, sz/2]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam, h=LM8UULen);
    translate([CARCX/2-LM8UULen*1.5, XRODSDiff/2, sz/2]) rotate([0, 90, 0]) cylinder(d=RODXYDiam*1.3, h=LM8UULen*2);
  }
}

module CoreXY_X_Carriage_v6_PLM() {
  difference() {
    //translate([-CARCX/2, -CARCY/2, 0]) import("../vulcanus-v1/1xCoreXY_X-Carriage-v6.stl");
    //translate([-CARCX/2, -CARCY/2, 0]) import("x_carriage_orgignal_no-lm8uu.stl");
    translate([-CARCX/2, -CARCY/2, 0]) import("x_carriage_orgignal_no-lm8uu.stl");
    translate([0, 0, 0]) XCar_LM8UU();
  }
}

module X_Car_Assembly_Original_v2() {
  // Направляющие
  if (!noRordsCheck) {
    %x_end_rods_check();
    mirror([1, 0, 0]) translate([95, 0, 0]) X_EndStop_Stand();
    %translate([115, -XENDCY/2, 10]) r_x_end();
    translate([90, 0, 0]) X_EndStop_Stand();
  }
}

CoreXY_X_Carriage_v6_PLM();
