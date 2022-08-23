include <../z-temp/z-config.scad>
use <../x-carriage/x_carriage_lda_v1.3.scad>
use <../x-carriage/x_carriage_directdrive_enhanced.scad>

//$fn=16;

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
E3D_CentralHole_D=26;
// Titan mount sizes
TMMountCY=5;

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
    *%translate([0, 0, zOffs]) rotate([0, 0, E3DRot]) E3D_v6_175_base(cla=1); // Z-=43.25 for patched STL
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

module CoreXY_DD_Plate(cz=2.8) {
  translate([0, 0, XENDFullCZ]) linear_extrude(height=cz) 
    polygon(points=[[18+14.4, -21], 
                    [18+14.4, -21+44.5], 
                    [20, -21+44.5+10],
                    [-28.1, -21+44.5+10],
                    [-(18+14.4+8.1), -21+44.5],
                    [-(18+14.4+8.1), -21],
                    [-(18+14.4+8.1)+12.4, -21-10],
                    [20, -21+-10],
    ]);
}

module CoreXY_DD_EdgeCutter() {
  difference() {
    // almost real dims - translate([-4.2, 1.1, 7]) cube([75, 69, 165], center=true);
    translate([-4.2, 1.1, 7]) cube([300, 300, 165], center=true);
    translate([0, 0, -100]) CoreXY_DD_Plate(170);
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
        polygon(points=[[-31, -2.7], [-22, 10], [-20.8, 10], [-20.8, -6.7], [-31, -6.7]]);
      }
      // bottom plate 
      translate([-2, -100, XENDFullCZ]) cube([64, 220, 2.8]);
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
    translate([16, 0, CARTopZBeg+CARTopBaseCZ]) rotate([0, 0, 90]) rotate([90]) {
      translate([0, 0, -54]) linear_extrude(height=7) 
      polygon(points=[[-31, -2.7], [-22, 13], [-20.8, 13], [-20.8, -6.7], [-31, -6.7]]);
    }
    translate([-52, 68, CARTopZBeg+CARTopBaseCZ]) rotate([0, 0, 180]) rotate([90]) {
      translate([0, 0, -54]) linear_extrude(height=19.5) 
      polygon(points=[[-31, -2.7], [-21, 13], [-14, 13], [-14, -6.7], [-31, -6.7]]);
    }
    // bottom plate 
    translate([-62, -100, XENDFullCZ]) cube([64, 220, 2.8]);
    difference() {
      translate([-38, -21, XENDFullCZ]) cube([7, 44.5, 19.7]);
      translate([-60, 7.05, -0.2]) mirror([0, 1, 0]) Belt_Holes();
    }
  }
}

module CoreXY_Direct_Drive_Compound_v1(clr="Khaki") {
  *color(clr, 0.4) CoreXY_Direct_Drive(clr);
  difference() {
    color(clr) union() {
      CoreXY_Direct_Drive_Belt_TensMnt();
      translate([-2.5, 0, 0]) CoreXY_Direct_Drive_Belt_Mnt();
      translate([-23.51, -31, XENDFullCZ]) cube([43.5, 64.5, 4]);
      translate([-40.5, -31, XENDFullCZ]) cube([20.5, 22, 4]);
      // Nema17 mount
      hull() {
        translate([-40.5, -17.6, XENDFullCZ]) cube([20.5, 4, 32]);
        translate([-32, -17.6, XENDFullCZ+46]) rotate([-90, 0, 0]) cylinder(h=4, d=6);
        translate([10, -17.6, XENDFullCZ+46]) rotate([-90, 0, 0]) cylinder(h=4, d=6);
        translate([20.5, -17.6, XENDFullCZ]) cube([2, 4, 32]);
      }
      //CoreXY_DD_Plate(2.8);
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
      // M3 holes
      translate([-8,  CARCY/2-13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
      translate([ 8,  CARCY/2-13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
      translate([-8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
      translate([ 8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
      // Back
      hull() {
        translate([-8, -CARCY/2+13, 24.1]) cylinder(h=20, d=7);
        translate([ 8, -CARCY/2+13, 24.1]) cylinder(h=20, d=7);
      }
      // Front
      hull() {
        translate([-8,  CARCY/2-13, 24.1]) cylinder(h=20, d=7);
        translate([ 8,  CARCY/2-13, 24.1]) cylinder(h=20, d=7);
      }
    }
    color("orange") {
      CoreXY_DD_EdgeCutter();
      translate([-26.3, 50, XENDFullCZ+9.5]) hull() {
        translate([10, 0, 0]) rotate([90, 0, 0]) cylinder(h=40, d=5);
        rotate([90, 0, 0]) cylinder(h=40, d=5);
        translate([0, 0, 10]) rotate([90, 0, 0]) cylinder(h=40, d=5);
      }
    }
    // Nema17 holes
    color("green") {
      translate([-26.3, 50, XENDFullCZ+9.5]) rotate([90, 0, 0]) cylinder(h=100, d=3.3);
      translate([-26.3, 50, XENDFullCZ+40.5]) rotate([90, 0, 0]) cylinder(h=100, d=3.3);
      translate([4.7, 50, XENDFullCZ+9.5]) rotate([90, 0, 0]) cylinder(h=100, d=3.3);
      translate([4.7, 50, XENDFullCZ+40.5]) rotate([90, 0, 0]) cylinder(h=100, d=3.3);
      // Central
      translate([-10.8, 50, XENDFullCZ+25]) rotate([90, 0, 0]) cylinder(h=100, d=22.2);
    }
  }
  //#CoreXY_DD_Plate(2.8);
}

module CoreXY_Carriage_Titan_Modern() {
  translate([0, 0, -21.5]) {
      *color("Khaki", 0.3) CoreXY_X_Carriage_v3(true, e3d=false);
      translate([0, 0, 30.4]) rotate([0, 0, 0]) Titan_E3D_v6_Asm();
      mirror([1, 0, 0]) CoreXY_Direct_Drive_Compound_v1();
  }
}

CoreXY_Carriage_Titan_Modern();

