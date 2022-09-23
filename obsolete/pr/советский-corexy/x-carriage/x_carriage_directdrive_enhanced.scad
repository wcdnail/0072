include <../z-temp/z-config.scad>
use <../z-temp/z.scad>

ShowBase=false;
ShowWithChainMount=true;
ShowNoChainMount=false;

module Chain_Mount_Holes() {
  hbz=19;
  // Holes
  translate([8, -15.7, CARTopZBeg+CARTopBaseCZ+hbz]) rotate([0, 90]) cylinder(h=30, d=4.4);
  translate([8, -8.1, CARTopZBeg+CARTopBaseCZ+hbz]) rotate([0, 90]) cylinder(h=30, d=3.5);
  // Nuts
  translate([19, -15.7, CARTopZBeg+CARTopBaseCZ+hbz]) scale([3, 1+NutScaleInc, 1+NutScaleInc]) rotate([0, 90]) nut("M4");
  translate([19, -8.1, CARTopZBeg+CARTopBaseCZ+hbz]) scale([3, 1+NutScaleInc, 1+NutScaleInc]) rotate([0, 90]) nut("M3");
}

module Chain_Mount_Solid(clr=undef, cx=8) {
  hullCD=5;
  hullFN=12;
  color(clr) difference() {
    translate([16, -38, CARTopZBeg]) {
      hull() {
        cube([cx, 14, 16]);
        translate([0, 20-hullCD/2, 32-hullCD/2-12]) rotate([0, 90, 0]) cylinder(d=hullCD, h=cx, $fn=hullFN);
        translate([0, hullCD/2, 32-hullCD/2]) rotate([0, 90, 0]) cylinder(d=hullCD, h=cx, $fn=hullFN);
        translate([0, 20-hullCD/2, 32-hullCD/2]) rotate([0, 90, 0]) cylinder(d=hullCD, h=cx, $fn=hullFN);
      }
    }
    translate([-1, -15.3, 0]) Chain_Mount_Holes();
  }
}

module CoreXY_Direct_Drive_Base(clr=undef, noSharper=true) {
  color(clr) difference() {
    union() {
      CoreXY_Direct_Drive();
      if(!noSharper) {
        // Right clamp
        translate([16, 0, CARTopZBeg+CARTopBaseCZ]) rotate([0, 0, 90]) rotate([90]) 
          linear_extrude(height=14) 
            polygon(points=[[-38, 0],[-22, 10],[-16, 10],[-16, -1],[-38, -1]]);
      }
    }
    // E3D v5 enlarger
    translate([0, 0, E3Dv5ZOffset-CARTopZOffs+zE3Dv5HolderOffset-5.6]) E3D_v5_cylinders(0.2, 0.4);
    translate([0, 0, CARTopZOffs+26]) cylinder(d=16.1, h=50);
    if(!noSharper) {
      // Hatch slices
      translate([40.5, -48.5, -10]) rotate([0, 0, 46.2]) cube([50, 50, 120], center=true);
      translate([-53.9, -39, -10]) rotate([0, 0, 26.7]) cube([50, 50, 120], center=true);
    }
  }
}

module CoreXY_Direct_Drive_v2(clr="MediumSeaGreen", rendStop=false, lendStop=true, noMotorMount=false, noChainMount=false, renderBase=false) {
  esbx=CARCX/2-3;
  cx=XEndStopMountCX;
  union() {
    if (renderBase) {
      color(clr) render() CoreXY_Direct_Drive_Base(clr);
    }
    else {
      CoreXY_Direct_Drive_Base(clr);
    }
    // Chain mount
    if(!noChainMount) {
      translate([54, -6, 0]) rotate([0, 0, -90]) Chain_Mount_Solid(clr);
      // Right corner
      color(clr) {
        translate([16, -30, CARTopZBeg]) cube([14, 14, 16.7]);
        translate([16, -38, CARTopZBeg]) cube([14, 9, 9.7]);
      }
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
        translate([-esbx+5, 15, CARTopZBeg]) cube([esbx*2-cx*2, 18, CARTopBaseCZ/3.5]);
        // M3 vert holes
        translate([-8, 25, -75]) cylinder(h=200, d=3.2);
        translate([ 8, 25, -75]) cylinder(h=200, d=3.2);
        // Mid hole
        translate([0, 13, -75]) scale([2, 1.2, 1]) cylinder(h=200, d=16);
      }
    }
  }
}

if (ShowBase) {
  CoreXY_Direct_Drive_Base();
}
else if (ShowWithChainMount) {
  CoreXY_Direct_Drive_v2("MediumSeaGreen", rendStop=true, lendStop=true);
}
else if (ShowNoChainMount) {
  CoreXY_Direct_Drive_v2("MediumSeaGreen", rendStop=true, lendStop=true, noChainMount=true);
}
