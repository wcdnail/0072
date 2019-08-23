include <z-config.scad>
use <../../openscad/nema17.scad>
use <z.scad>
use <x_carriage_directdrive_enhanced.scad>
use <e3d_v5_liftdown_adapter.scad>

module EndStop_Mount(cy=6, clr=undef, clra=undef) {
  hd=11.5;
  %rotate([0, 0, 90]) rotate([-90]) opt_endstop();
  color(clr, clra) difference() {
    union() {
      // Vert
      hull() {
        translate([0, -10, 9.15]) rotate([0, 0, 90]) rotate([0, 90]) cylinder(d=hd, h=cy, $fn=17);
        translate([0, -10, -9.15]) rotate([0, 0, 90]) rotate([0, 90]) cylinder(d=hd, h=cy, $fn=17);
      }
      // ---
      translate([0, -5, 9.15]) rotate([0, 0, 90]) rotate([0, 90]) cylinder(d=6.2, h=2.2);
      translate([0, -5, -9.15]) rotate([0, 0, 90]) rotate([0, 90]) cylinder(d=6.2, h=2.2);
    }
    // Holes
    color("Red") {
      translate([0, -50, 9.15]) rotate([0, 0, 90]) rotate([0, 90]) cylinder(d=3.3, h=100);
      translate([0, -50, -9.15]) rotate([0, 0, 90]) rotate([0, 90]) cylinder(d=3.3, h=100);
      // Nuts
      translate([0, -7.4, 9.15]) rotate([0, 0, 90]) scale([1+NutScaleInc+2, 1+NutScaleInc, 1+NutScaleInc]) rotate([0, 90]) nut("M3");
      translate([0, -7.4, -9.15]) rotate([0, 0, 90]) scale([1+NutScaleInc+2, 1+NutScaleInc, 1+NutScaleInc]) rotate([0, 90]) nut("M3");
    }
  }
}

module Y_EndStop_Mount(clr=undef, clra=undef) {
  cy=6;
  translate([10.5, -38, 20.5]) {
    difference() {
      union() {
        EndStop_Mount(cy, clr, clra);
        color(clr, clra) {
          translate([0, 7.5, -20.8]) cube([5.84, 35, 2], center=true);
          translate([0, 1, -18.8]) hull() {
            cube([20, 20, 3], center=true);
            translate([0, 16, -1.5]) cylinder(d=20, h=3);
          }
          hull() {
            translate([0, -7, -10]) cube([11, cy, 1], center=true);
            translate([0, -7, -17.8]) cube([20, cy, 5], center=true);
          }
          translate([0, 17, -18]) cylinder(d=15, h=2);
        }
      }
      color("Red") {
        translate([0, -50, -9.15]) rotate([0, 0, 90]) rotate([0, 90]) cylinder(d=3.3, h=100);
        translate([0, 17, -50]) cylinder(d=5.2, h=100);
        //translate([0, 17, -18]) cylinder(d=10, h=30);
      }
    }
  }
}

module Y_Endstop_Term(clr=undef, clra=undef) {
  etcx=16;
  ecx=10.48;
  color(clr, clra) union() {
    translate([ecx, -7.5, 20.5]) rotate([90]) {
      difference() {
        union() {
          cylinder(d=16.7, h=3);
          translate([0, 0, -.99]) cylinder(d1=7, d2=13, h=1);
          hull() {
            translate([0, 6.85, 0]) cylinder(d=3, h=3);
            translate([-4, -5, 0]) cylinder(d=3, h=3);
            translate([-14+1.5, 0, 0]) cylinder(d=3, h=3);
            translate([-14, 6.85-1.5, 0]) cube([3, 3, 3]);
          }
        }
        translate([0, 0, -10]) cylinder(d=3, h=40);
        translate([0, 0, 4]) scale(1.02) nut("M3");
      }
    }
    difference() {
      union() {
        hhd=8.8;
        hull() {
          translate([2, -9, 25.85]) cylinder(d=3, h=3);
          translate([-8.5, -9, 25.85]) cylinder(d=hhd, h=3);
        }
        hull() {
          translate([-8.5, -9, 25.85]) cylinder(d=hhd, h=3);
          translate([-8.5, -9+18, 25.85]) cylinder(d=hhd, h=3);
        }
      }
      translate([-8.5, -9, 0]) cylinder(d=3.4, h=50);
      translate([-8.5, -9+18, 0]) cylinder(d=3.4, h=50);
    }
  }
  %color("Red", 0.4) {
    translate([ecx, 7, 20.5]) rotate([90]) cylinder(d=3, h=40);
  }
}

module Endstops_Mess() {
  %translate([0, 90, 0]) r_idler("MediumSeaGreen", .8);
  %translate([-3.5, -XENDCY/2, 15]) r_x_end("DarkSlateGray", .8);
  %translate([0, -100, 0]) r_motor("MediumSeaGreen", .8);
  translate([BARCX/2+0.5, -100, -BARCZ/2]) rotate([-90, 0, 0]) profile_2020(170, true, "Gainsboro");

  Y_EndStop_Mount("Yellow", .8);
  Y_Endstop_Term("Yellow", .8);
  mirror([0, 1, 0]) Y_EndStop_Mount("Yellow", .8);
}

module Two_Endstops() {
  translate([0, 0, 48]) {
    rotate([90]) Y_EndStop_Mount();
    translate([24, 0, 0]) rotate([90]) Y_EndStop_Mount();
  }
}

module Y_Endstop_Term_Prod() {
  translate([0, 0, 28.85]) rotate([0, 180, 0]) Y_Endstop_Term();
}

Two_Endstops();
translate([7, -40, 0]) rotate([0, 0, -90]) Y_Endstop_Term_Prod();
mirror([1, 0, 0]) translate([-37, -40, 0]) rotate([0, 0, -90]) Y_Endstop_Term_Prod();


//Endstops_Mess();
