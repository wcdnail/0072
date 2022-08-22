include <../z-temp/z-config.scad>
use <../x-carriage/x_carriage_lda_v1.3.scad>
use <../x-carriage/x_carriage_directdrive_enhanced.scad>

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
    translate([8.5, -1.9, zOffs+5.4]) rotate([0, 0, 0]) E3D_Titan_Base(cla=1);
    %translate([0, 0, zOffs]) rotate([0, 0, E3DRot]) E3D_v6_175_base(cla=1); // Z-=43.25 for patched STL
    translate([8.3, -30.4-TMMountCY, zOffs+31.3]) rotate([-90, 90, 0]) Nema17_usual();
}

module E3D_v6_175(clr="DarkSlateGray", cla=undef) {
  color(clr, cla) translate([5.2, -2.5, 0]) rotate([0, 0, 0]) import("../../parts/E3D_v6_1.75mm_Universal.stl");
}

module BackHardenner(beltStBY) {
  difference() {
    hull() {
      translate([-38, -10.0-beltStBY-beltStBY, 21.498]) cube([7, beltStBY+0.1, 16.7]);
      translate([-26.5, -38, 21.498]) cube([7, beltStBY+0.1, 8]);
      translate([9.2, -38, 21.498]) cube([7, beltStBY+0.1, 8]);
      translate([23, -23.4, 21.498]) cube([7, beltStBY+0.1, 8]);
      translate([16, -10.0-beltStBY-beltStBY, 21.498]) cube([14, beltStBY+0.1, 16.7]);
    }
    translate([-8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
    translate([ 8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
    translate([-22, -34, 28]) cube([36, 14, 20]);
  }
}

module CoreXY_Direct_Drive_Clean_v1(clr="Khaki") {
  beltStCY=5.41;
  beltStCX=15.2;
  beltStBY=5;
  
  color(clr) union() {
    difference() {
      CoreXY_Direct_Drive(clr);
      color("red") {
        translate([0, 0, -75]) cylinder(h=200, d=16);
        translate([-16, -50, 23.4]) cube([32, 100, 30]);
        translate([-75, -45, 23.4]) cube([150, 30, 30]);
        translate([-31, -24.99, 23.4]) cube([20, 40, 30]);
        translate([-45, -40.0, 23.4]) cube([30, 30, 30]);
      }
    }
    difference() {
      union() {
        translate([-31.2, -24.99+40-beltStCY, 23.4-0.2]) cube([beltStCX, beltStCY, 18.0]);
        translate([-31.2, -24.99+40-beltStCY-19.6-beltStBY, 23.4-0.2]) cube([beltStCX, beltStCY+beltStBY, 18.0]);
      }
      translate([-29, -50, 42]) rotate([0, 60, 0]) cube([40, 100, 30]);
    }
    translate([-38, -10.0-beltStBY, 23.2]) cube([7, beltStBY+0.1, 18]);
    BackHardenner(beltStBY=beltStBY);
  }
}

module CoreXY_Direct_Drive_Titan_Mount() {
  difference() {
    union() {
      hull() {
        //translate([-17.7, -31.9, 23.2]) cube([4, 46.3, 55]);
        translate([-17.7, 15, 23.5]) cube([4, 15, 24]);
        translate([-17.7, 7.4, 78.4]) rotate([0, 90, 0]) cylinder(h=4, d=14);
        translate([-17.7, -32, 23.5]) cube([4, 15, 15]);
        translate([-17.7, -32, 70.3]) cube([4, 15, 15]);
        //translate([-17.7, -28, 78.4]) rotate([0, 90, 0]) cylinder(h=4, d=14);
      }
      hull() {
        translate([-17.7, -31.9, 23.5]) cube([4, 61.9, 4]);
        translate([10, -31.9, 23.5]) cube([4, 61.9, 7]);
        translate([-17.7, -31.9, 36.5]) cube([4, 61.9, 4]);
      }
    }
    BackHardenner(beltStBY=5);
    // M3 vert holes
    translate([-8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.3);
    translate([ 8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.3);
    hull() {
      translate([-8, -CARCY/2+13, 30]) cylinder(h=20, d=3.3);
      translate([ 8, -CARCY/2+13, 30]) cylinder(h=20, d=3.3);
    }
    translate([-8, 25, -75]) cylinder(h=200, d=3.2);
    translate([ 8, 25, -75]) cylinder(h=200, d=3.2);
    hull() {
      translate([-8, 25, 30]) cylinder(h=20, d=3.3);
      translate([ 8, 25, 30]) cylinder(h=20, d=3.3);
    }
    // Central holes
    translate([0, 0, -75]) cylinder(h=200, d=16);
    translate([0, 18, -75]) cylinder(h=200, d=8);
  }
}


module CoreXY_Direct_Drive_Titan_v4(clr="DeepPink", rendStop=false, lendStop=true, noMotorMount=false, noChainMount=false) {
  esbx=CARCX/2-3;
  cx=XEndStopMountCX;
  beltStCY=5.41;
  beltStCX=15.2;
  
  difference() {
    union() {
      CoreXY_Direct_Drive_Clean_v1(clr);
      // Chain mount
      if(!noChainMount) {
        translate([54, -4, 0]) rotate([0, 0, -90]) Chain_Mount_Solid(clr);
        // Right corner
        //color(clr) {
          //translate([16, -30, CARTopZBeg]) cube([14, 14, 16.7]);
          //translate([16, -38, CARTopZBeg]) cube([14, 9, 9.7]);
        //}
      }
      if(rendStop) {
        X_EndStop_Mount(esbx, cx, clr);
      }
      if(lendStop) {
        translate([0, 0, 0]) mirror([1, 0, 0]) X_EndStop_Mount(esbx, cx, clr);
      }
      // Middle connector
      if(rendStop && lendStop) {
        color(clr) difference() {
          translate([-esbx+5, 15-30, CARTopZBeg]) cube([esbx*2-cx*2, 48, CARTopBaseCZ/3.5]);
          // M3 vert holes
          translate([-8, 25, -75]) cylinder(h=200, d=3.2);
          translate([ 8, 25, -75]) cylinder(h=200, d=3.2);
          // M4 holes 
          translate([-CARCX/2+13, 0, XENDFullCZ-200]) cylinder(h=400, d=4.5);
          translate([ CARCX/2-13, 0, XENDFullCZ-200]) cylinder(h=400, d=4.5);
        }
        //translate([0, 0, -75]) cylinder(h=200, d=16);
      }
    }
    // Side holes
    translate([8, 15, 31.35]) rotate([0, 90, 0]) cylinder(h=30, d=3.2);
    // Central holes
    translate([0, 0, -75]) cylinder(h=200, d=E3D_CentralHole_D);
    translate([0, 18, -75]) cylinder(h=200, d=8);
  }
}

module CoreXY_Carriage_Titan_Classic_Vulcanus(noRordsCheck=false, withMotor=false) {
  translate([0, 0, -21.5]) {
      %color("Khaki", 0.7) CoreXY_X_Carriage_v3(true, e3d=false);
      translate([0, 0, 43]) rotate([0, 0, 0]) Titan_E3D_v6_Asm();
  }
  //#translate([0, 0, 0]) rotate([180, 0, 0]) CoreXY_X_Carriage_v3_wLDA();
  translate([0, 0, -21.5]) {
    render() CoreXY_Direct_Drive_Titan_v4(rendStop=true, lendStop=true, noChainMount=true, noMotorMount=true);
    //render() CoreXY_Direct_Drive_Clean_v1();
    //color("cyan") CoreXY_Direct_Drive_Titan_Mount();
  }
}

module CoreXY_Carriage_Titan_Modern() {
  translate([0, 0, -21.5]) {
      color("Khaki", 0.7) CoreXY_X_Carriage_v3(true, e3d=false);
      translate([0, 0, 26.4]) rotate([0, 0, 90]) Titan_E3D_v6_Asm();
      //#CoreXY_Direct_Drive_Clean_v1();
  }
}


//CoreXY_Carriage_Titan_Classic_Vulcanus();

CoreXY_Carriage_Titan_Modern();
