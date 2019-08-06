include <z-config.scad>
use <../../openscad/nema17.scad>
use <z.scad>
use <x_carriage_directdrive_enhanced.scad>
use <e3d_v5_liftdown_adapter.scad>

module X_EndStop_Stand() {
    sbz=17.65-CARTopBaseCZ/2;
    bdia=10;
    tz=3;
    hz=4;
    //render() 
    difference() {
        union() {
            // Horizontal
            hull() {
                translate([-XENDCX/2+5, XENDCY/2-25+5, XENDFullCZ]) cylinder(d=bdia, h=tz);
                translate([-XENDCX/2+5, XENDCY/2-3, XENDFullCZ]) cylinder(d=bdia, h=tz);
                translate([-XENDCX/2-3, XENDCY/2-25, XENDFullCZ]) cube([6, 27, tz]);
            }
            // Vertical
            translate([-3.7, 0, XENDFullCZ+35]) rotate([0, -90]) hull() {
                translate([-XENDCX/2+5, XENDCY/2-25+9.5, XENDFullCZ]) cylinder(d=bdia, h=hz);
                translate([-XENDCX/2+5, XENDCY/2-3, XENDFullCZ]) cylinder(d=bdia, h=hz);
                translate([-XENDCX/2-13, XENDCY/2-25, XENDFullCZ]) cube([9, 27, hz]);
            }
            translate([-XENDCX/2+5, XENDCY/2-25+5, XENDFullCZ-3.1]) cylinder(d=5.6, h=tz*2+0.1);
            translate([-XENDCX/2+5, XENDCY/2-3, XENDFullCZ-3.1]) cylinder(d=5.6, h=tz*2+0.1);
        }
        color("Red") {
            translate([-XENDCX/2+5, XENDCY/2-25+5, XENDFullCZ-tz*2-5]) cylinder(d=3.1, h=30);
            translate([-XENDCX/2+5, XENDCY/2-3, XENDFullCZ-tz*2-5]) cylinder(d=3.1, h=30);
            translate([-XENDCX/2-25, XENDCY/2-8.9, XENDFullCZ+sbz]) rotate([0, 90, 0]) cylinder(d=3.3, h=40);
            // Nut 
            translate([-XENDCX/2-3.2, XENDCY/2-8.9, XENDFullCZ+sbz]) scale([3, 1, 1]) rotate([0, 90]) nut("M3");
        }
    }
    //color("Red") 
    %translate([-XENDCX/2-25, XENDCY/2-8.9, XENDFullCZ+sbz]) rotate([0, 90, 0]) cylinder(d=2.5, h=40);
}

X_EndStop_Stand();
