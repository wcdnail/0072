include <../z-temp/z-config.scad>
use <../x-carriage/x_carriage_lda_v1.3.scad>
use <../x-carriage/x_carriage_directdrive_enhanced.scad>
use <../z-fan-duct-v5-30mm/z-fan-duct.scad>

//$fn=16;

// E3D hotend Z angle
E3DRot=0;
// Titan mount sizes
TMMountCY=5;
// R-Side x offset
BeltMnt_X_Offs = 2.4;
//
DDBaseCZ = 2.8;
// 
DDTitan_BaseCZ = 6;
//
N17_X_Offs = 1.2;

module E3D_Titan_Base(clr="DeepSkyBlue", cla=undef) {
  color(clr, cla) {
    import("e3d-titan-base.stl");
  }
}

module E3D_v6_175_base(clr="SandyBrown", cla=undef) {
  color(clr, cla) translate([5.2, -2.5, 0]) import("../../parts/E3D_v6_1.75mm_Universal.stl");
}

module Nema17_usual(clr="Gainsboro", cla=undef) {
  color(clr, cla) translate([5.2, -2.5, 0]) import("../../parts/Motor_NEMA17.stl");
}

module Titan_E3D_v6_Asm() {
    zOffs=-10;
    %translate([8.5, -1.9, zOffs+5.4]) rotate([0, 0, 0]) E3D_Titan_Base(cla=1);
    %translate([0, 0, zOffs]) rotate([0, 0, E3DRot]) E3D_v6_175_base(cla=1); // Z-=43.25 for patched STL
    %translate([8.3, -30.4-TMMountCY, zOffs+31.3]) rotate([-90, 90, 0]) Nema17_usual();
}

module E3D_v6_175(clr="DarkSlateGray", cla=undef) {
  color(clr, cla) translate([5.2, -2.5, 0]) rotate([0, 0, 0]) import("../../parts/E3D_v6_1.75mm_Universal.stl");
}

module Belt_Holes() {
  translate([-120, 0.3, XENDFullCZ+3.1]) cube([300, 2.3, 6.2]);
  translate([-120, 7.4, XENDFullCZ+3.1]) cube([300, 2.3, 6.2]);
  translate([-120, 0.3-3, XENDFullCZ+10.1]) cube([300, 2.3, 6.2]);
  translate([-120, 7.4-3, XENDFullCZ+10.1]) cube([300, 2.3, 6.2]);
}

module CoreXY_DD_Plate(cz=2.8, lendStop=true) {
  lendStopDy=(lendStop ? 54.5 : 44.5);
  translate([0, 0, XENDFullCZ]) linear_extrude(height=cz) 
    polygon(points=[[18+14.4, -21], 
                    [18+14.4, -21+44.5], 
                    [20, -21+44.5+10],
                    [-28.1, -21+44.5+10],
                    [-(18+14.4+8.1)-BeltMnt_X_Offs, -21+lendStopDy],
                    [-(18+14.4+8.1)-BeltMnt_X_Offs, -21],
                    [-(18+14.4+8.1)+12.4-BeltMnt_X_Offs, -21-10],
                    [20, -21+-10],
    ]);
}

module CoreXY_DD_EdgeCutter(lendStop=true) {
  difference() {
    // almost real dims - translate([-4.2, 1.1, 7]) cube([75, 69, 165], center=true);
    translate([-4.2, 1.1, 7]) cube([300, 300, 165], center=true);
    translate([0, 0, -100]) CoreXY_DD_Plate(cz=170, lendStop=lendStop);
  }
}

module CoreXY_Direct_Drive_Belt_TensMnt() {
  difference() {
    union() {
      translate([18, -21, XENDFullCZ]) cube([14.4, 44.5, 16.7]);
      translate([72, 0, CARTopZBeg+CARTopBaseCZ]) rotate([0, 0, 90]) rotate([90]) {
        translate([0, 0, -54]) linear_extrude(height=14.4) 
          polygon(points=[[-31, -2.7], [-22, 10], [-20.8, 10], [-20.8, -6.7], [-31, -6.7]]);
      }
      mirror([0, 1, 0]) translate([72, -2.5, CARTopZBeg+CARTopBaseCZ]) rotate([0, 0, 90]) rotate([90]) {
        translate([0, 0, -54]) linear_extrude(height=14.4) 
        polygon(points=[[-31, -2.7+2], [-22, 10], [-20.8, 10], [-20.8, -6.7], [-31, -6.7]]);
      }
      // bottom plate 
      translate([-2, -100, XENDFullCZ]) cube([64, 220, DDBaseCZ]);
    }
    // M4 hole
    translate([ CARCX/2-13, 0, XENDFullCZ-200]) cylinder(h=400, d=4.5);
    translate([ CARCX/2-13, 0, XENDFullCZ+12.7]) cylinder(h=100, d=8.4);
    // Side holes
    translate([0, 15, 31.35]) rotate([0, 90, 0]) cylinder(h=100, d=3.3);
    translate([0, -11.9, 31.35]) rotate([0, 90, 0]) cylinder(h=100, d=3.3);
    // Nut holes
    translate([23, -15, XENDFullCZ+6.7]) cube([3.1, 6, 30]);
    translate([23, 11.9, XENDFullCZ+6.7]) cube([3.1, 6, 30]);
  }
  *color("SteelBlue") translate([CARCX/2+2, 2, CARTopZBeg+0.2]) x_belt_clamp();
}

module CoreXY_Direct_Drive_Belt_Mnt() {
  // Old cubes
  *translate([-26, 0, XENDFullCZ]) cube([10, 10, 10]);
  *translate([-38, -10, XENDFullCZ]) cube([7, 25, 19.7]);
  union() {
    translate([16-BeltMnt_X_Offs, 0, CARTopZBeg+CARTopBaseCZ]) rotate([0, 0, 90]) rotate([90]) {
      translate([0, 0, -54]) linear_extrude(height=7) 
      polygon(points=[[-31, -2.7], [-22, 13], [-20.8, 13], [-20.8, -6.7], [-31, -6.7]]);
    }
    translate([-52-BeltMnt_X_Offs, 66, CARTopZBeg+CARTopBaseCZ]) rotate([0, 0, 180]) rotate([90]) {
      translate([0, 0, -54]) linear_extrude(height=21.5) 
      polygon(points=[[-31, -3.5+DDBaseCZ], [-21, 13], [-14, 13], [-14, -6.7], [-31, -6.7]]);
    }
    // N17 mnt hardener
    translate([-40.4, -15.5, XENDFullCZ+29.1]) mirror([0, 1, 0]) rotate([0, 90, 0]) linear_extrude(height=7) 
      polygon(points=[[0, 0], [26.3+DDBaseCZ, 0], [26.3+DDBaseCZ, 32]]);
    // bottom plate 
    translate([-62-BeltMnt_X_Offs, -100, XENDFullCZ]) cube([64+BeltMnt_X_Offs+2, 220, DDBaseCZ]);
    difference() {
      translate([-38-BeltMnt_X_Offs, -21, XENDFullCZ]) cube([7, 44.5, 19.7]);
      translate([-60-BeltMnt_X_Offs, 7.05, -0.2]) mirror([0, 1, 0]) Belt_Holes();
    }
  }
}

module CoreXY_Direct_Drive_Compound_v1(clr="Khaki", lendStop=true, chainMounter=true) {
  *color(clr, 0.4) CoreXY_Direct_Drive(clr);
  
  esbx=CARCX/2;
  cx=XEndStopMountCX+2;
  union() {
    if (lendStop) {
      translate([-7.499-BeltMnt_X_Offs, 0, 0]) mirror([1, 0, 0]) X_EndStop_Mount(esbx, cx, clr);
    }
    if (chainMounter) {
      translate([56, -5, 0]) rotate([0, 0, -90]) Chain_Mount_Solid(clr=clr, cx=10);
    }
    difference() {
      color(clr) union() {
        CoreXY_Direct_Drive_Belt_TensMnt();
        translate([-2.5, 0, 0]) CoreXY_Direct_Drive_Belt_Mnt();
        translate([-23.51-BeltMnt_X_Offs, -31, XENDFullCZ]) cube([43.5+BeltMnt_X_Offs, 64.5, DDTitan_BaseCZ]);
        translate([-40.5-BeltMnt_X_Offs, -31, XENDFullCZ]) cube([20.5, 22, DDTitan_BaseCZ]);
        // Nema17 mount
        N17MntRad = 3;
        N17MntCY = 2;
        N17MntCYAdder = 0.4;
        hull() {
          #translate([-40.5-BeltMnt_X_Offs, -17.6+N17MntCY, XENDFullCZ]) cube([20.5, N17MntCY+N17MntCYAdder, 32]);
          translate([-32, -17.6+N17MntCY, XENDFullCZ+46+DDTitan_BaseCZ/N17MntRad]) rotate([-90, 0, 0]) cylinder(h=N17MntCY+N17MntCYAdder, d=N17MntRad*2);
          translate([13, -17.6+N17MntCY, XENDFullCZ+46+DDTitan_BaseCZ/N17MntRad]) rotate([-90, 0, 0]) cylinder(h=N17MntCY+N17MntCYAdder, d=N17MntRad*2);
          translate([21, -17.6+N17MntCY, XENDFullCZ]) cube([2, N17MntCY+N17MntCYAdder, 32]);
        }
        // make nema17 mnt harder
        translate([-40.5-BeltMnt_X_Offs, -14, XENDFullCZ+29.1]) rotate([0, 90, 0]) linear_extrude(height=7) 
          polygon(points=[[0, 0], [13, 0], [13, 38]]);
        // left
        translate([18, -14, XENDFullCZ+29.1]) rotate([0, 90, 0]) linear_extrude(height=5) 
          polygon(points=[[0, 0], [13, 0], [13, 38]]);
        *CoreXY_DD_Plate(2.8);
      }
      color("red") {
        // E3D hole
        translate([0, 0, XENDFullCZ-200]) cylinder(h=400, d=CARCentralHoleDiam);
        // Wires holes
        translate([ 0,  CARCY/2-23, XENDFullCZ-200]) cylinder(h=400, d=8);
        translate([ 0,  CARCY/2-28, XENDFullCZ-100]) cube([8, 10, 300], center=true);
        // M4 hole
        translate([ CARCX/2-13, 0, XENDFullCZ-200]) cylinder(h=400, d=4.5);
        translate([-CARCX/2+13, 0, XENDFullCZ-200]) cylinder(h=400, d=4.5);
        translate([-CARCX/2+13, 0, XENDFullCZ+2.8]) cylinder(h=30, d=9);
        translate([ CARCX/2-13, 0, XENDFullCZ+12.7]) cylinder(h=100, d=8.4);
        // M3 holes
        translate([-8,  CARCY/2-13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([ 8,  CARCY/2-13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([-8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([ 8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        // Back
        hull() {
          translate([-8, -CARCY/2+13, XENDFullCZ+DDBaseCZ]) cylinder(h=20, d=7);
          translate([ 8, -CARCY/2+13, XENDFullCZ+DDBaseCZ]) cylinder(h=20, d=7);
        }
        // Front
        hull() {
          translate([-8,  CARCY/2-13, XENDFullCZ+DDBaseCZ]) cylinder(h=20, d=7);
          translate([ 8,  CARCY/2-13, XENDFullCZ+DDBaseCZ]) cylinder(h=20, d=7);
        }
      }
      color("orange") {
        CoreXY_DD_EdgeCutter(lendStop=lendStop);
        toolHullD=6.9;
        *translate([-26.3+N17_X_Offs, 50, XENDFullCZ+9.5]) hull() {
          translate([10, 0, 0]) rotate([90, 0, 0]) cylinder(h=40, d=toolHullD);
          rotate([90, 0, 0]) cylinder(h=40, d=toolHullD);
          translate([0, 0, 10]) rotate([90, 0, 0]) cylinder(h=40, d=toolHullD);
        }
      }
      // Nema17 holes
      translate([N17_X_Offs, 0, DDTitan_BaseCZ/3]) color("green") {
        translate([-26.3, 50, XENDFullCZ+9.5]) rotate([90, 0, 0]) cylinder(h=100, d=3.3);
        translate([-26.3, 50, XENDFullCZ+40.5]) rotate([90, 0, 0]) cylinder(h=100, d=3.3);
        translate([4.7, 50, XENDFullCZ+9.5]) rotate([90, 0, 0]) cylinder(h=100, d=3.3);
        translate([4.7, 50, XENDFullCZ+40.5]) rotate([90, 0, 0]) cylinder(h=100, d=3.3);
        // Central
        translate([-10.8, 50, XENDFullCZ+25]) rotate([90, 0, 0]) cylinder(h=100, d=22.2);
      }
    }
  }
  //#CoreXY_DD_Plate(2.8);
}

module CoreXY_X_Carriage_v4(skipDims=false, carClr="Green", e3d=true) {
  if(!skipDims) {
    color("black") {
      translate([0, 0, XENDFullCZ]) x_dim(CAR2CX, 0, 0, 100);
      translate([0, 0, XENDFullCZ]) y_dim(0, CARCY, 0, 100);
      translate([0, 0, XENDFullCZ-XENDFullCZ/2]) y_dim(0, XRODSDiff, 0, 80);
    }
  }
  // Base
  difference() {
    union() {
      XCar_Base(carClr, e3d);
      car_lmu88_holders_all(carClr);
    }
    color("Magenta") XCar_Base_holes(centralHoles=true);
  }
  // Sink fan duct
  //#translate([CAR2CX/2, -20, -18.5]) cube([4, 40, 40]);
  *translate([CAR2CX/2, 0, 1.5]) rotate([0, 90, 0]) cylinder(h=4, d=40);
}


module CoreXY_Carriage_Titan_Modern() {
  translate([0, 0, -21.5]) {
      //%translate([0, 0, 26.4+DDTitan_BaseCZ-10]) rotate([0, 0, E3DRot]) E3D_v6_175_base(cla=0.2);
      *CoreXY_X_Carriage_v4(true, e3d=false);
      
      *%rotate([0, 0, 90]) Z_SinkFan();
      *%translate([-N17_X_Offs, 0, 26.4+DDTitan_BaseCZ]) rotate([0, 0, 0]) Titan_E3D_v6_Asm();
      mirror([1, 0, 0]) CoreXY_Direct_Drive_Compound_v1();
  }
}

CoreXY_Carriage_Titan_Modern();
