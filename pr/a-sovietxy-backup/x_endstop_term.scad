include <z-config.scad>
use <../../openscad/nema17.scad>
use <z.scad>
use <x_carriage_directdrive_enhanced.scad>
use <e3d_v5_liftdown_adapter.scad>

module X_EndStop_Stand() {
  sbz=17.65-CARTopBaseCZ/2;
  bdia=6;
  tz=3;
  hz=6;
  difference() {
    union() {
      // Vertical
      translate([6.5, 0, XENDFullCZ+38]) rotate([0, -90]) hull() {
        translate([-XENDCX/2+1, XENDCY/2-9, XENDFullCZ-hz+2.4]) cylinder(d=bdia+3, h=hz);
        translate([-XENDCX/2-13, XENDCY/2-13.5, XENDFullCZ-hz+2.4]) cube([1, bdia+3, hz]);
      }
      // Horizontal
      hull() {
        translate([-XENDCX/2+5, XENDCY/2-25+5, XENDFullCZ]) cylinder(d=bdia+1, h=tz);
        translate([-XENDCX/2+5, XENDCY/2-3, XENDFullCZ]) cylinder(d=bdia+1, h=tz);
        translate([-XENDCX/2+20, XENDCY/2-3, XENDFullCZ]) cylinder(d=bdia+1, h=tz);
      }
      // Bolts filler
      translate([-XENDCX/2+5, XENDCY/2-25+5, XENDFullCZ-3.1]) cylinder(d=5.4, h=tz*2+0.1);
      translate([-XENDCX/2+5, XENDCY/2-3, XENDFullCZ-3.1]) cylinder(d=5.4, h=tz*2+0.1);
      translate([-XENDCX/2+20, XENDCY/2-3, XENDFullCZ-3.1]) cylinder(d=5.4, h=tz*2+0.1);
    }
    color("Red") {
      translate([-XENDCX/2+5, XENDCY/2-25+5, XENDFullCZ-tz*2-5]) cylinder(d=3.1, h=20);
      translate([-XENDCX/2+5, XENDCY/2-3, XENDFullCZ-tz*2-5]) cylinder(d=3.1, h=20);
      translate([-XENDCX/2+20, XENDCY/2-3, XENDFullCZ-tz*2-5]) cylinder(d=3.1, h=20);
      translate([-XENDCX/2-25, XENDCY/2-8.9, XENDFullCZ+sbz]) rotate([0, 90, 0]) cylinder(d=3.3, h=100);
      // Nut 
      translate([-XENDCX/2+8.5, XENDCY/2-8.9, XENDFullCZ+sbz]) scale([3, 1.02, 1.02]) rotate([0, 90]) nut("M3");
    }
  }
  %translate([-XENDCX/2-15, XENDCY/2-8.9, XENDFullCZ+sbz]) rotate([0, 90, 0]) cylinder(d=2.5, h=40);
}

//X_EndStop_Stand();

%translate([115, -XENDCY/2, 10]) r_x_end();
translate([90, 0, 0]) X_EndStop_Stand();

  
