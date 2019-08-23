include <z-config.scad>
use <z.scad>
use <../x-carriage/x_carriage_directdrive_enhanced.scad>
use <../x-carriage/x_endstop_term.scad>
use <../x-carriage/x_carriage_lda_v1.3.scad>
use <../e3d-v5/e3d_v5_liftdown_adapter.scad>
use <../../parts/fans.scad>
use <../../parts/chamfers.scad>

$fn=18;

JustFanDuct=false;
ShowCar=true;
ShowDuct=true;
ShowProbeMount=true;
NoHotEnd=false;

ProbeX=1.86;
ProbeY=52;
ProbeZ=32.8;
ProbeHeight=4;
ProbeNutHeight=4.6;
ProbeCX=32;
ProbeConSX=6.2;
LiftDownHotend=true;

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
  x=ProbeX+ProbeConSX/2;
  tnutz=ProbeZ+10;
  hcx=ProbeCX;
  hcz=ProbeHeight;
  %translate([x, ProbeY, -63]) Z_Probe_Draft(tnutz);
  color("Yellow")
  translate([x, ProbeY, -63]) {
    difference() {
      hull() {
        translate([0, 0, tnutz-hcz]) cylinder(h=hcz, d=hcx);
        translate([-hcx/2+ProbeConSX/2, -31, tnutz-hcz]) cube([hcx-ProbeConSX, hcz, hcz]);
      }
      color("Red") {
        cylinder(h=70, d=18.3);
        // Holes
        hsy=-26.5;
        hull() {
          translate([-7, hsy+2, ProbeZ-20]) cylinder(d=3.2, h=40);
          translate([-7, hsy-1, ProbeZ-20]) cylinder(d=3.2, h=40);
        }
        hull() {
          translate([7, hsy+2, ProbeZ-20]) cylinder(d=3.2, h=40);
          translate([7, hsy-1, ProbeZ-20]) cylinder(d=3.2, h=40);
        }
      }
    }
  }
  color("Red") {
  }
}

module SA_FanDuct_2() {
  x=ProbeX+ProbeConSX/2;
  sx=ProbeConSX;
  cz=ProbeHeight*1;
  //union() {
    translate([0, 0, 0]) StandAlone_Fan_Duct_x2_40();
    render() difference() {
      union() {
        translate([ProbeX+sx/2, 15, -63+ProbeZ+cz/2+1]) ChamferCyl(ProbeCX-sx, 30, cz, center=true);
        translate([ProbeX, 0, -63+ProbeZ+cz/2+1]) ChamferCyl(45, 30, cz*2, center=true);
      }
      color("Red") {
        translate([0, 0, -100]) scale([1, 1, 1]) cylinder(h=250, d=25.55);
        // Back slice
        translate([ProbeX, 0, -63+ProbeZ+cz/2+1]) cube([100, 3, 100], center=true);
        // Vert holes
        translate([x-7, ProbeY-26.5, -63+ProbeZ-20]) cylinder(d=3.2, h=40);
        translate([x+7, ProbeY-26.5, -63+ProbeZ-20]) cylinder(d=3.2, h=40);
        // Nuts
        translate([x-7, ProbeY-26.5, -63+ProbeZ+3]) scale([1, 1, 2]) nut("M3");
        translate([x+7, ProbeY-26.5, -63+ProbeZ+3]) scale([1, 1, 2]) nut("M3");
        // Horiz bolt
        translate([-16, 50, -63+ProbeZ+cz/2+1]) rotate([90]) cylinder(d=4.4, h=100);
        // Fan slice
        translate([ProbeX-2, 0, -63+ProbeZ+cz/2+1]) rotate([0, 90]) cylinder(d1=28, d2=44, h=30);
      }
    }
  //}
  if (!NoHotEnd) {
    if (LiftDownHotend) {
      %translate([0, 0, -5.3]) E3D_v5_temp(fitting=true);
    }
    else {
      %translate([0, 0, CARTopZOffs+16.6]) E3D_v5_temp();
    }
  }
  color("Red", 0.7) {
  }
}

if (JustFanDuct) {
  StandAlone_Fan_Duct_x2_40();
}
else {
  translate([0, 0, 70]) {
    if (ShowCar) {
      if (LiftDownHotend) {
        %translate([0, 0, 21.5]) rotate([180]) CoreXY_X_Carriage_v3_wLDA(true, "MediumSeaGreen", false);
      }
      else {
        %CoreXY_X_Carriage_v2(true, "MediumSeaGreen", false);
      }
    }
    if (ShowDuct) {
      SA_FanDuct_2();
    }
    if (ShowProbeMount) {
      Z_Probe_Holder();
    }
  }
}
