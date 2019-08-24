include <cyl_head_bolt.scad>

$fn=64;

JustFanDuct=false;
ShowDuct=true;
ShowProbeMount=true;
NoHotEnd=false;

ProbeX=1.86;
ProbeY=52;
ProbeZ=32.8;
ProbeHeight=4;
ProbeNutHeight=4.6;
ProbeCX=12;
ProbeConSX=15.7;
ProbeConXOffset=12.2;
LiftDownHotend=true;

module StandAlone_Fan_Duct_x2_40() {
  translate([97.47, -5.99, -53]) import("Fan_Duct_E3D_v5_40_LQ.stl");
}

module chamfer_plate(scx, scy, cz, diam=3, center=false) {
  r=diam/2;
  cx=scx-diam;
  cy=scy-diam;
  sx=center?-scx/2+r:r;
  sy=center?-scy/2+r:r;
  sz=center?-cz/2:0;
  hull() {
    translate([sx, sy, sz]) cylinder(d=diam, h=cz);
    translate([sx+cx, sy, sz]) cylinder(d=diam, h=cz);
    translate([sx+cx, sy+cy, sz]) cylinder(d=diam, h=cz);
    translate([sx,  sy+cy, sz]) cylinder(d=diam, h=cz);
  }
}

module chamfer_cube(v3, d=3, center=false) {
  chamfer_plate(v3[0], v3[1], v3[2], diam=d, center=center);
}

module Z_Probe_Draft(tnutz=21.5, hcz=ProbeHeight) {
  nutcz=ProbeNutHeight;
  bnutz=tnutz-nutcz-hcz;
  // Screw body
  color("SlateGrey", 0.6) translate([0, 0, 9.1]) cylinder(h=60.9, d=18);
  // Sensor
  color("Orange", 0.6) translate([0, 0, 0]) cylinder(h=9.1, d=18);
  // Top nut
  color("White", 0.6) translate([0, 0, tnutz+1.41]) cylinder(h=3.1, d=27);
  color("Gray", 0.6) translate([0, 0, tnutz]) cylinder(h=1.4, d=30);
  // Bottom nut
  color("White", 0.6) translate([0, 0, bnutz]) cylinder(h=3.1, d=27);
  color("Gray", 0.6) translate([0, 0, bnutz+3.11]) cylinder(h=1.4, d=30);
}

module Z_Probe_Holder() {
  x=ProbeX+ProbeConSX/2-ProbeConXOffset;
  tnutz=ProbeZ+10;
  hcx=ProbeCX * 2.5 + 6;
  hcz=ProbeHeight;
  %translate([x, ProbeY, -63]) Z_Probe_Draft(tnutz);
  color("Yellow") translate([x, ProbeY, -63]) {
    difference() {
      hull() {
        translate([0, 0, tnutz-hcz]) cylinder(h=hcz, d=hcx - 6);
        translate([-hcx/2+ProbeConSX/2, -31, tnutz-hcz]) cube([hcx-ProbeConSX, hcz, hcz]);
      }
      color("Red") {
        cylinder(h=70, d=18.3);
        // Holes
        hsy=-26.5;
        hull() {
          translate([-7, hsy+4, ProbeZ-20]) cylinder(d=3.2, h=40);
          translate([-7, hsy-1, ProbeZ-20]) cylinder(d=3.2, h=40);
        }
        hull() {
          translate([7, hsy+4, ProbeZ-20]) cylinder(d=3.2, h=40);
          translate([7, hsy-1, ProbeZ-20]) cylinder(d=3.2, h=40);
        }
      }
    }
  }
}

module SA_FanDuct_2() {
  x=ProbeX+ProbeConSX/2;
  sx=ProbeConSX;
  cz=ProbeHeight*1;
  z=-63+ProbeZ+cz/2+1;
  %translate([0, 0, 0]) StandAlone_Fan_Duct_x2_40();
  translate([-ProbeConXOffset, 0, -4]) difference() {
    union() {
      hull() {
        translate([-(ProbeCX)/2+sx, 15.5, z-10]) cube([ProbeCX, 1, cz+10]);
        translate([x-7, ProbeY-26.5, z]) cylinder(d=10, h=cz);
        translate([x+7, ProbeY-26.5, z]) cylinder(d=10, h=cz);
      }
    }
    color("Red") { // Vert holes
      translate([x-7, ProbeY-26.5, -63+ProbeZ-20]) cylinder(d=3.2, h=40);
      translate([x+7, ProbeY-26.5, -63+ProbeZ-20]) cylinder(d=3.2, h=40);
      // Nuts
      translate([x-7, ProbeY-26.5, -63+ProbeZ+5]) scale([1, 1, 5]) nut("M3");
      translate([x+7, ProbeY-26.5, -63+ProbeZ+5]) scale([1, 1, 5]) nut("M3");
    }
    if (false) {
      translate([ProbeX, 0, -63+ProbeZ+cz/2+1]) chamfer_cube([45, 30, cz*2], center=true);
      color("Red") {
        translate([0, 0, -100]) scale([1, 1, 1]) cylinder(h=250, d=25.55);
        // Back slice
        translate([ProbeX, 0, -63+ProbeZ+cz/2+1]) cube([100, 3, 100], center=true);
        // Horiz bolt
        translate([-16, 50, -63+ProbeZ+cz/2+1]) rotate([90]) cylinder(d=4.4, h=100);
        // Fan slice
        translate([ProbeX-2, 0, -63+ProbeZ+cz/2+1]) rotate([0, 90]) cylinder(d1=28, d2=44, h=30);
      }
    }
  }
}

if (JustFanDuct) {
  StandAlone_Fan_Duct_x2_40();
}
else {
  translate([0, 0, 70]) {
    if (ShowDuct) {
      SA_FanDuct_2();
    }
    if (ShowProbeMount) {
      Z_Probe_Holder();
    }
  }
}
