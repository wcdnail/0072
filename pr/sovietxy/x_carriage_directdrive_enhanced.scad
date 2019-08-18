include <z-config.scad>
use <z.scad>

XEndStopMountCX=5;
NutScaleInc=0.05;

module Chain_Mount(clr="MediumSeaGreen") {
  hbz=19;
  color(clr) difference() {
    // Base
    hull() {
      translate([16, -22, CARTopZBeg+CARTopBaseCZ/2+13]) cube([14, 18, hbz/2]);
      translate([16, -19, CARTopZBeg+CARTopBaseCZ/2+13+hbz-7.5]) rotate([0, 90, 0]) cylinder(d=6, h=14, $fn=12);
      translate([16, -7, CARTopZBeg+CARTopBaseCZ/2+13+hbz-7.5]) rotate([0, 90, 0]) cylinder(d=6, h=14, $fn=12);
    }
    // Holes
    translate([8, -15.7, CARTopZBeg+CARTopBaseCZ+hbz]) rotate([0, 90]) cylinder(h=30, d=4.4);
    translate([8, -8.1, CARTopZBeg+CARTopBaseCZ+hbz]) rotate([0, 90]) cylinder(h=30, d=4);
    translate([20, -15, CARTopZBeg+CARTopBaseCZ/2+12]) cube([4, 6, 50]);
    // Nuts
    translate([19, -15.7, CARTopZBeg+CARTopBaseCZ+hbz]) scale([3, 1+NutScaleInc, 1+NutScaleInc]) rotate([0, 90]) nut("M4");
    translate([19, -8.1, CARTopZBeg+CARTopBaseCZ+hbz]) scale([3, 1+NutScaleInc, 1+NutScaleInc]) rotate([0, 90]) nut("M3");
  }
}

module EndStop_Mount(clr="MediumSeaGreen") {
  esbx=CARCX/2-12;
  eslbx=-CARCX/2;
  esby=27;
  esbz=CARTopZBeg+14.3;
  cx=XEndStopMountCX;
  color(clr) 
  difference() {
    union() {
      hull() {
        translate([esbx-cx-5, esby-1, CARTopZBeg+22.5]) rotate([0, 90, 0]) cylinder(d=14, h=cx, $fn=11);
        translate([esbx-cx-5, esby-8, CARTopZBeg]) cube([cx, 14, 16]);
      }
      // Шайбы
      translate([esbx-cx-0.2, esby-0.89, CARTopZBeg+5.15]) rotate([0, 90, 0]) cylinder(d=7, h=1.8);
      translate([esbx-cx-0.2, esby-0.89, CARTopZBeg+23.45]) rotate([0, 90, 0]) cylinder(d=7, h=1.8);
      // Connector
      translate([esbx-cx-5, esby-16, CARTopZBeg]) cube([cx, 22, 9.7]);
    }
    // Holes
    translate([esbx-20, esby-0.89, CARTopZBeg+5.15]) rotate([0, 90, 0]) cylinder(d=3.2, h=30);
    translate([esbx-20, esby-0.89, CARTopZBeg+23.45]) rotate([0, 90, 0]) cylinder(d=3.2, h=30);
    // Nuts
    translate([esbx-cx-3, esby-0.9, CARTopZBeg+5.2]) scale([3, 1+NutScaleInc, 1+NutScaleInc]) rotate([0, 90]) nut("M3");
    translate([esbx-cx-3, esby-0.9, CARTopZBeg+23.5]) scale([3, 1+NutScaleInc, 1+NutScaleInc]) rotate([0, 90]) nut("M3");
  }
  %translate([esbx, esby-0.89, esbz]) rotate([-90]) opt_endstop();
}

module CoreXY_Direct_Drive_Base(clr="MediumSeaGreen") {
  color(clr) difference() {
    union() {
      CoreXY_Direct_Drive();
      // Right clamp
      translate([16, 0, CARTopZBeg+CARTopBaseCZ]) rotate([0, 0, 90]) rotate([90]) linear_extrude(height=14) polygon(points=[[-38, 0],[-22, 10],[-16, 10],[-16, -1],[-38, -1]]);
    }
    // E3D v5 enlarger
    translate([0, 0, E3Dv5ZOffset-CARTopZOffs+zE3Dv5HolderOffset]) E3D_v5_cylinders(0.09, 0.4);
    translate([0, 0, CARTopZOffs+26]) cylinder(d=16.1, h=50);
    // Hatch slices
    translate([40.5, -48.5, -10]) rotate([0, 0, 46.2]) cube([50, 50, 120], center=true);
    translate([-53.9, -39, -10]) rotate([0, 0, 26.7]) cube([50, 50, 120], center=true);
  }
}

module CoreXY_Direct_Drive_v2(clr="MediumSeaGreen", rendStop=false, lendStop=true, noMotorMount=false, noChainMount=false, renderBase=false) {
  union() {
    if (renderBase) {
		color(clr) render() CoreXY_Direct_Drive_Base(clr);
	}
	else {
		CoreXY_Direct_Drive_Base(clr);
	}
    // Chain mount
    if(!noChainMount) {
      Chain_Mount(clr);
    }
    if(rendStop) {
      EndStop_Mount(clr);
    }
    if(lendStop) {
      translate([0, 0, 0]) mirror([1, 0, 0]) EndStop_Mount(clr);
    }
    // Middle connector
    if(rendStop && lendStop) {
      color(clr) difference() {
        translate([-21, 20, CARTopZBeg]) cube([42, 13, CARTopBaseCZ/3.5]);
        // M3 vert holes
        translate([-8, 25, -75]) cylinder(h=200, d=3.2);
        translate([ 8, 25, -75]) cylinder(h=200, d=3.2);
        // Mid hole
        translate([0, 13, -75]) scale([2, 1.2, 1]) cylinder(h=200, d=16);
      }
    }
  }
}

//CoreXY_Direct_Drive_Base();
// With chain mount
CoreXY_Direct_Drive_v2("MediumSeaGreen", rendStop=true, lendStop=true);
// No chain mount
//CoreXY_Direct_Drive_v2("MediumSeaGreen", rendStop=true, lendStop=true, noChainMount=true);
