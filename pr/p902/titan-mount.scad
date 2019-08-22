use <../parts/fans.scad>
use <../parts/chamfers.scad>
include <titan-common.scad>

$fn=64;

module Tevo_Titan_Adapter_1(clr=undef, cla=undef) {
  BotCY=60.26;
  color(clr, cla) 
  //render() 
  difference() {
    union() {
      Tevo_Titan_Adapter(clr, cla);
      translate([14.35, -BotCY, 24.7]) cube([4.33, BotCY, CarThick+1]);
      translate([16, -BotCY+7, 27.94]) cube([13.47, BotCY-10, CarThick-0.3]);
      translate([14.35, -3.4, 31]) cube([36, 3.4, 47]);
      // Wire mount thicker
      translate([19, -2.6, 70]) rotate([90]) cylinder(d=6.4, h=1.6);
    }
    color("Red") {
      // Remove 30mm fan
      translate([0, -BotCY-5, 24.7-40]) cube([40, BotCY+10, 40]);
      translate([18.64, -BotCY-3, 24.7]) cube([4.33, BotCY+6, CarThick-2.17]);
      // Remove top garbage
      translate([40, -70.9, 33]) cube([40, 19.23, 40]);
      translate([-10, -70.9, 33]) cube([50, 22, 40]);
      translate([44.1, -70, 10]) cube([5, 30, 40]);
      // E3D
      translate([36.5, -38, -30]) cylinder(d=25.2, h=100);
      // top
      translate([40, -70.9, 78]) cube([30, 90, 50]);
      // Fan duct holes
      translate([18.34, 25, 48]) {
        hull() {
          rotate([90]) cylinder(d=3.5, h=50);
          translate([0, 0, -3]) rotate([90]) cylinder(d=3.5, h=50);
        }
      }
      translate([18.34, 25, 39]) {
        hull() {
          rotate([90]) cylinder(d=3.5, h=50);
          translate([0, 0, -3]) rotate([90]) cylinder(d=3.5, h=50);
        }
      }
      // Holes & holes
      translate([19, 25, 70]) rotate([90]) cylinder(d=3.2, h=50);
      translate([33.7, 2, 79.7]) rotate([90]) cylinder(d=16, h=8);
    }
  }
  color("Red") {
    
  }
}

module TM_SinkFanHull(fx=-10, cx=16, cy=30, le=0, re=0, fs=42, llen=60) {
  ttx=12;
  hull() {
    translate([fx+5.5-le, -38, 15]) rotate([0, 90]) ChamferCyl(fs, fs, 5, 4, true, $fn=16);
    translate([ttx, -38, 14.5]) rotate([0, 90]) ChamferCyl(cx, cy, 2, 4, true, $fn=16);
  }
  hull() {
    translate([ttx, -38, 14.5]) rotate([0, 90]) ChamferCyl(cx, cy, 2, 4, true, $fn=16);
    translate([llen+re, -38, 14.5]) rotate([0, 90]) ChamferCyl(cx, cy, 2, 4, true, $fn=16);
  }
}

module Tevo_Titan_SinkFan(clr=undef, cla=undef, smallFan=false) {
  fx=-4;
  FanD=smallFan ? 32 : 42;
  translate([fx, -38, 15]) rotate([0, 90]) {
    if(smallFan) {
      FanMount30(clr=clr);
    } else {
      FanMount40(clr=clr);
    }
  }
  color(clr, cla) 
  //render()
  difference() {
    union() {
      TM_SinkFanHull(fx, fs=FanD, llen=36.6);
      hull() {
        translate([25.261, -55.64, 18.5]) cylinder(d=10, h=CarThick);
        translate([20.2, -50, 18.5]) cube([10, 27, CarThick]);
      }
      //translate([47.2, -60, 18.5]) cube([10, 37, CarThick]);
    }
    TM_SinkFanHull(fx, 13, 27, 0.1, 2, fs=FanD-4);
    color("Red") {
      hull() {
        translate([36.5, -38, -30]) cylinder(d=22.8, h=100);
        translate([106.5, -38, -30]) cylinder(d=22.8, h=100);
      }
      translate([25.261, -55.64, 0]) cylinder(d=3.5, h=100);
      //translate([52.461, -55.64, 0]) cylinder(d=3.5, h=100);
    }
  }
}

module Full_Assembly(smallFan=false) {
  %X_Car_Draft(cla=.5);

  translate([7, 9, 4.5]) rotate([0, 0, -90]) {
    %translate([-11.1, -11, 35.6]) E3D_Titan_Base(cla=.5);
    %translate([0, -11, 9.12]) rotate([0, 0, 90]) E3D_v6_175(cla=.5);
  }
  translate([-40.5, 47, -17]) {
    Tevo_Titan_Adapter_1("MediumSeaGreen");
    Tevo_Titan_SinkFan("Yellow", smallFan=smallFan);
  }
  if (true) {
    %translate([21.7, 75.4, -30]) Tevo_Titan_FanDuct("Yellow");
  }
}

//Full_Assembly();

//translate([0, -70, 0]) Full_Assembly();
//translate([0,  70, 0]) Full_Assembly(true);

rotate([-90]) Tevo_Titan_Adapter_1();
//rotate([0, -90]) Tevo_Titan_SinkFan();
//rotate([0, -90]) Tevo_Titan_SinkFan(smallFan=true);
