include <../z-temp/z-config.scad>
use <../x-carriage/x_carriage_lda_v1.3.scad>
use <../../parts/chamfers.scad>

$fn=64;

ProbeMountCZ=4.6;
ProbeNutHeight=4.6;
LiftDownHotend=true;
NoHotEnd=false;
ShowCar=false;
OnlyFanDuct=false;
Show4Render=false;
ShowOnlyBackFanMount=false;

module Z_Probe_Draft(tnutz=21.5, hcz=ProbeMountCZ) {
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

module YA_FanDuct_Back_Mount_All(onlyMount, showProbe=true) {
  probepos=[-40, 0, -21.8];
  pmsize=[5, 30, ProbeMountCZ];
  pmpos=[-pmsize[0]-12.57, -pmsize[1]/2, 0];
  pmhdiam=7;
  pmconcx=3.8;
  difference() {
    union() { 
      if (!onlyMount) { // Sink fan back holder
        color("Yellow", 0.7) union() {
          translate([0, 0, 0]) import("fan_mount_back.stl");
          translate(pmpos) {
            hull() {
              cube(pmsize);
              translate([-pmconcx, pmhdiam/2, 0]) cylinder(d=pmhdiam, h=pmsize[2]);
              translate([-pmconcx, pmsize[1]-pmhdiam/2, 0]) cylinder(d=pmhdiam, h=pmsize[2]);
            }
          }
          translate(pmpos+[pmsize[0]-2.5, 0, 30-pmsize[2]]) cube(pmsize-[2.5, 0, 0]);
        }
      }
      else { // Probe holder
        color("Green", 0.7) translate(pmpos+[0, 0, pmsize[2]+0.1]) {
          hull() {
            translate([-pmconcx+2, pmhdiam/2, 0]) cylinder(d=pmhdiam, h=pmsize[2]);
            translate([-pmconcx+2, pmsize[1]-pmhdiam/2, 0]) cylinder(d=pmhdiam, h=pmsize[2]);
            translate([probepos[0]-pmpos[0], pmsize[1]/2, 0]) cylinder(d=pmsize[1]+2, h=pmsize[2]);
          }
        }
      }
    }
    color("Red") {
      // Bolts holes
      translate(pmpos) {
          bhd=3.2;
          bhdsx=1;
          bhdsy=4;
          nutsz=3.5;
          translate([-pmconcx+bhdsx, pmhdiam/2+bhdsy, -1.5]) { cylinder(d=bhd, h=pmsize[2]*3); translate([0, 0, nutsz]) scale([1.05, 1.05, 2]) nut("M3"); }
          translate([-pmconcx+bhdsx, pmsize[1]-pmhdiam/2-bhdsy, -1.5]) { cylinder(d=bhd, h=pmsize[2]*3); translate([0, 0, nutsz]) scale([1.05, 1.05, 2]) nut("M3"); }
      }
      // Probe hole
      translate(pmpos+[0, 0, pmsize[2]+0.1]) {
        translate([probepos[0]-pmpos[0], pmsize[1]/2, -1]) cylinder(d=18.4, h=pmsize[2]*2);
      }
    }
  }
  color("Red", 0.7) {
  }
  if (onlyMount && showProbe) {
    %translate(probepos) Z_Probe_Draft(25.85+pmsize[2]);
  }
}

module YA_FanDuct_Full(zoffs=62) {
  translate([0, 0, -zoffs]) {
    color("Green", 1) translate([0., 0, 0]) import("circular_duct.stl");
    color("Yellow", 0.5) translate([0.05, 0, 14.9]) import("fan_mount_40mm.stl");
    translate([-0.05, 0, 19.9]) {
      YA_FanDuct_Back_Mount_All(false);
      YA_FanDuct_Back_Mount_All(true);
    }
  }
}

if (Show4Render) {
  YA_FanDuct_Back_Mount_All(false);
  if (!ShowOnlyBackFanMount) {
    translate([54, 0, -ProbeMountCZ]) YA_FanDuct_Back_Mount_All(true, false);
  }
}
else if (OnlyFanDuct) {
  YA_FanDuct_Full();
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
    if (!NoHotEnd) {
      if (LiftDownHotend) {
        %translate([0, 0, -5.3]) E3D_v5_temp(fitting=true);
      }
      else {
        %translate([0, 0, CARTopZOffs+16.6]) E3D_v5_temp();
      }
    }
    YA_FanDuct_Full();
  }
}
