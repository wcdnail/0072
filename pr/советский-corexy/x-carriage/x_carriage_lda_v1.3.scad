include <../z-temp/z-config.scad>
use <../z-temp/z.scad>
use <../z-fan-duct-v5-30mm/z-fan-duct.scad>
use <../e3d-v5/e3d_v5_liftdown_adapter.scad>
use <x_endstop_term.scad>
use <x_carriage_directdrive_enhanced.scad>

module E3D_v5_LDA_wxcar(withNut=true, clr="Yellow", halfSlice=false) {
  masterDiam=CARCentralHoleDiam-0.8;
  zBottom=53.5;
  vbx=CARCentralHoleDiam+8;
  vby=CARCentralHoleDiam/3;
  vbz=12;
  xfd=2.1;
  ybd=-CARCentralHoleDiam/3.7;
  ynd=8;
  zbd=59.5;
  translate([0, 0, -CARTopBaseCZ/2]) difference() {
    color(clr) union() {
      translate([0, 0, E3Dv5ZOffset+zBottom]) cylinder(h=zE3Dv5HolderOffset+6.5, d1=vbx, d2=vbx*1.25);
    }
    color("Red") {
      // Central hole
      translate([0, 0, E3Dv5ZOffset+64]) cylinder(h=zE3Dv5HolderOffset, d=16);
      // Side slice
      if (halfSlice) {
        translate([-CARCentralHoleDiam, 0, E3Dv5ZOffset+43.9]) cube([CARCentralHoleDiam*2, CARCentralHoleDiam, 300]);
      }
      else {
        translate([-CARCentralHoleDiam, 0, E3Dv5ZOffset+43.9]) cube([CARCentralHoleDiam*2, CARCentralHoleDiam, zE3Dv5HolderOffset+1.2]);
      }
      // Bolt holes
      translate([ CARCentralHoleDiam/xfd, CARCentralHoleDiam, E3Dv5ZOffset+zbd]) rotate([90]) cylinder(d=3.05, h=CARCentralHoleDiam*2);
      translate([-CARCentralHoleDiam/xfd, CARCentralHoleDiam, E3Dv5ZOffset+zbd]) rotate([90]) cylinder(d=3.05, h=CARCentralHoleDiam*2);
      if (withNut) {
        translate([ CARCentralHoleDiam/xfd, ybd-ynd-2, E3Dv5ZOffset+zbd]) rotate([90]) scale([1, 1, 3]) nut("M3");
        translate([-CARCentralHoleDiam/xfd, ybd-ynd-2, E3Dv5ZOffset+zbd]) rotate([90]) scale([1, 1, 3]) nut("M3");
      }
      else {
        translate([ CARCentralHoleDiam/xfd, ybd-3, E3Dv5ZOffset+zbd]) rotate([90]) cylinder(d=6.1, h=7);
        translate([-CARCentralHoleDiam/xfd, ybd-3, E3Dv5ZOffset+zbd]) rotate([90]) cylinder(d=6.1, h=7);
      }
    }
    color("Cyan") {
        translate([ 0,  CARCY/2-20, XENDFullCZ-9.65]) cylinder(h=20, d1=9, d2=8);
    }
    color("Blue") translate([0, 0, E3Dv5ZOffset-CARTopZOffs]) 
      E3D_v5_cylinders(0.2, 0.4);
  }
}

module E3D_v5_LDA_wxcar_Clamp(clr="MediumSeaGreen") {
  translate([0, 0.4, 0]) color(clr) render() difference() {
    rotate([0, 0, 180]) E3D_v5_LDA_wxcar(false, clr);
    translate([-CARCentralHoleDiam, -CARCentralHoleDiam, E3Dv5ZOffset-CARTopBaseCZ/2+67]) 
      cube([CARCentralHoleDiam*2, CARCentralHoleDiam*2, zE3Dv5HolderOffset*2]);
  }
}

module CoreXY_X_Carriage_v3(skipDims=false, carClr="Green", e3d=true) {
  difference() {
    union() {
      XCar_Base(carClr, e3d);
      car_lmu88_holders_all(carClr);
    }
    color("Magenta") XCar_Base_holes(centralHoles=true);
  }
  if(!skipDims) {
    color("black") {
      translate([0, 0, XENDFullCZ]) x_dim(CAR2CX, 0, 0, 100);
      translate([0, 0, XENDFullCZ]) y_dim(0, CARCY, 0, 100);
      translate([0, 0, XENDFullCZ-XENDFullCZ/2]) y_dim(0, XRODSDiff, 0, 80);
    }
  }
}

module CoreXY_X_Carriage_v3_wLDA(skipDims=true, carClr="Green", e3d=false) {
  union() {
    translate([0, 0, 21.5]) rotate([180]) 
      CoreXY_X_Carriage_v3(skipDims, carClr, e3d);
    translate([0, 0, 26.85]) rotate([180]) {
      E3D_v5_LDA_wxcar(true, carClr);
      //E3D_v5_LDA_wxcar_Clamp();
    }
  }
}

module CoreXY_X_Carriage_v3_Adh_Helper() {
    translate([-CAR2CX/2, -CARCY/2, 0]) cylinder(h=0.6, r=10);
    translate([-CAR2CX/2, CARCY/2, 0]) cylinder(h=0.6, r=10);
    translate([CAR2CX/2, -CARCY/2, 0]) cylinder(h=0.6, r=10);
    translate([CAR2CX/2, CARCY/2, 0]) cylinder(h=0.6, r=10);
}

//translate([0, 0, 26.85]) rotate([180]) #E3D_v5_LDA_wxcar_Clamp();
CoreXY_X_Carriage_v3_wLDA();
//CoreXY_X_Carriage_v3_Adh_Helper();
