include <../z-temp/z-config.scad>
use <../z-fan-duct-v5-30mm/z-fan-duct.scad>
use <../2x-fan-duct-e3d-v5/ya-v5-fan-duct.scad>
use <../z-temp/z.scad>
use <../e3d-v5/e3d_v5_liftdown_adapter.scad>
use <x_carriage_directdrive_enhanced.scad>
use <x_endstop_term.scad>
use <x_carriage_lda_v1.3.scad>

OnlyXYA=false;
ShowLeftSide=true;
ShowRightSide=true;
ShowPulleys=false;

module CoreXY_X_Carriage_Middle(noSensor=true) {
    difference() {
        union() {
            translate([0, 0, CARTopZBeg]) linear_extrude(height=CARTopBaseCZ/2)
                polygon(points=[[-16, 0],[ 16, 0],[ 16, 20],[ 30, 20],[ 30, -23.355],[ 16, -38],[-26.4, -38],[-38, -15],[-38, 15],[-16, 15]]);
            if (noSensor) {
                translate([0, 0, CARTopZBeg]) linear_extrude(height=CARTopBaseCZ/2)
                    polygon(points=[[ 16, 20],[ 16, 18.5],[-13, 18.5],[-16, 15],[-38, 15],[-38, 32],[-16, 32],[16, 32],[30, 32],[30, 20]]);
            }
        }
        // E3D hole
        translate([0, 0, E3Dv5ZOffset+64]) cylinder(h=200, d=CARTopE3DHoleDia);
        // M4 vert holes
        translate([ 25, 0, -75]) cylinder(h=200, d=4.2);
        translate([-25, 0, -75]) cylinder(h=200, d=4.2);
        // M3 vert holes
        translate([-8, -25, -75]) cylinder(h=200, d=3.2);
        translate([ 8, -25, -75]) cylinder(h=200, d=3.2);
        if (noSensor) {
            translate([-8, 25, -75]) cylinder(h=200, d=3.2);
            translate([ 8, 25, -75]) cylinder(h=200, d=3.2);
        }
    }
}

module CoreXY_Assemled_Carriage(noRordsCheck=false, withMotor=false) {
  CarZOffs=-0.8;
  LDA=true;
  if (!OnlyXYA) {
    // Каретка с хот-ендом
    if (LDA) {
      translate([0, 0, 21.5+CarZOffs]) rotate([180]) CoreXY_X_Carriage_v3_wLDA(true, "MediumSeaGreen", false);
      translate([0, 0, -5.3]) E3D_v5_temp(fitting=true);
    }
    else {
      CoreXY_X_Carriage_v2(true, "MediumSeaGreen", false);
      translate([0, 0, CARTopZOffs+16.6]) E3D_v5_temp();
    }
    // Fan duct
    if (true) {
      rotate([0, 0, -90]) YA_FanDuct_Full(62);
    }
    translate([0, 0, CarZOffs]) {
      translate([0, 0, 0.1]) CoreXY_Direct_Drive_v2("Yellow", rendStop=true, lendStop=true, renderBase=true, noChainMount=false);
      color("SteelBlue") translate([CARCX/2-2, 2, CARTopZBeg]) x_belt_clamp();
      if (withMotor) {
        translate([-5.5, -50.2, CARTopZBeg+CARTopBaseCZ+N17Height/2+4.5]) rotate([0, -90, 0]) rotate([-90]) Nema17(N17Height, N17Width, N17ShaftDiameter, N17ShaftLength, N17FixingHolesInteraxis);
      }
      mirror([1, 0, 0]) translate([95, 0, CarZOffs]) X_EndStop_Stand();
      translate([90, 0, CarZOffs]) X_EndStop_Stand();
    }
  }
  // Направляющие
  if (!noRordsCheck) {
    if (ShowLeftSide) {
      %x_end_rods_check(175, showPulleys=ShowPulleys);
      %translate([-123.5, -XENDCY/2+120, -5]) { l_idler("Green", 0.8, showPulleys=ShowPulleys); L_Idler_Pulley_Nut(); }
      %translate([-120, -XENDCY/2, 10]) L_Pulley_Nut();
      %translate([-118.5, -XENDCY/2-70, -5]) l_motor("Green", 0.8);
    }
    if (ShowRightSide){
      %translate([115, -XENDCY/2, 10]) r_x_end(showPulleys=ShowPulleys);
      %translate([118.5, -XENDCY/2+120, -5]) { r_idler("Green", 0.8, showPulleys=ShowPulleys); R_Idler_Pulley_Nut(); }
      %translate([115, -XENDCY/2, 10]) R_Pulley_Nut();
      %translate([118.5, -XENDCY/2-70, -5]) r_motor("Green", 0.8);
    }
  }
}

//translate([0, 0, 21.5]) rotate([180]) CoreXY_X_Carriage_v2(true, "MediumSeaGreen", false);
CoreXY_Assemled_Carriage();
