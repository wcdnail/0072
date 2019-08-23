include <../../openscad/libs/nutsnbolts/cyl_head_bolt.scad>

CarCX=43;
CarCY=90;
CarCZ=21.6;
CarThick=5.4;
IntCX=18;
IntCY=48;
InlCX=36;
InlCY=IntCY/2;

WithChainMount=false;
ChainMounterHeight=6;
ChainMounterXOffs=-8;
ChainMounterHullD=12;

module E3D_Titan_Base(clr="DeepSkyBlue", cla=undef) {
  color(clr, cla) {
    translate([39, 50, 64]) rotate([0, 0, 180]) rotate([0, 90, 0]) import("../parts/titan-mihatomi/e3d_Titan_extruder_-_e3d_extruder-1.STL");
  }
}

module E3D_v6_175(clr="DarkSlateGray", cla=undef) {
  color(clr, cla) translate([5.2, -2.5, 0]) rotate([0, 0, 0]) import("../parts/E3D_v6_1.75mm_Universal.stl");
}

module X_Car_Draft(clr="LightSlateGray", cla=undef) {
  color(clr, cla) difference() {
    cube([CarCX, CarCY, CarCZ], center=true);
    translate([0, 0, -CarThick/2]) cube([CarCX*2, 50, CarCZ], center=true);
    translate([0, 0, 5]) cube([IntCX, IntCY, 50], center=true);
    translate([0, InlCY/2, 5]) cube([InlCX, InlCY, 50], center=true);
  }
}

module Aero_Titan_Adapter(clr="MediumSeaGreen", cla=undef) {
  color(clr, cla) {
    rotate([0, 0, 180]) import("titan-aero-3/flyingbear_titan_aero_adapter.stl");
  }
}

module Aero_Titan_FanDuct(clr="MediumSpringGreen", cla=undef) {
  color(clr, cla) {
    rotate([90, 0, 0]) import("titan-aero-3/FB_DuctFan.STL");
  }
}

module Tevo_Titan_Adapter(clr="MediumSeaGreen", cla=undef) {
  color(clr, cla) {
    rotate([0, 0, -90]) import("titan-tevo-2/Titan_MOUNT_v2.STL");
  }
}

module Tevo_Titan_FanDuct(clr="MediumSpringGreen", cla=undef) {
  color(clr, cla) {
    rotate([0, 0, 180]) import("titan-tevo-2/Blower_Fan_DUCT_SHORT.STL");
  }
}

module Tevo_Titan_Adapter_1(clr=undef, cla=undef, noChain=!WithChainMount) {
  BotCY=60.26;
  color(clr, cla) difference() {
    union() {
      Tevo_Titan_Adapter(clr, cla);
      translate([14.35, -BotCY, 24.7]) cube([4.33, BotCY, CarThick+1]);
      translate([16, -BotCY+7, 27.94]) cube([13.47, BotCY-10, CarThick-0.3]);
      if (noChain) {
        translate([14.35, -3.4, 31]) cube([36, 3.4, 51.3]);
        // Wire mount washer
        translate([19, -2.6, 70]) rotate([90]) cylinder(d=6.4, h=1.6);
      }
      else {
        hull() {
          cmod=ChainMounterHullD;
          translate([ChainMounterXOffs+17.5, 0, 69.65+ChainMounterHeight-1.45]) rotate([90]) cylinder(d=cmod, h=3.4);
          translate([ChainMounterXOffs+27.5+25.5, 0, 69.65+ChainMounterHeight-1.45]) rotate([90]) cylinder(d=cmod, h=3.4);
          translate([14.35, -3.4, 31]) cube([36, 3.4, 49]);
        }
      }
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
      // Titan adjustment
      translate([33.7, 2, 79.7]) rotate([90]) cylinder(d=16, h=8);
      if (noChain) { // Wire mount hole
        translate([19, 25, 70]) rotate([90]) cylinder(d=3.2, h=50);
      }
      // Top slice
      //translate([48, noChain ? 60.9 : -70.9, 78]) cube([30, 67.5, 50]);
      // Chain mount holes
      cmbhd=3.4;
      translate([ChainMounterXOffs+17.5, 20, 69.65+ChainMounterHeight-1.45]) rotate([90]) cylinder(d=cmbhd, h=30);
      translate([ChainMounterXOffs+27.5, 20, 69.65+ChainMounterHeight-1.45]) rotate([90]) cylinder(d=cmbhd, h=30);
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
