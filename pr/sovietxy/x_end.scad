include <../../openscad/libs/nutsnbolts/cyl_head_bolt.scad>
include <../../openscad/libs/nutsnbolts/materials.scad>
include <z-config.scad>

module linearBearing(od=LM8UUOutterDiam, hght=LM8UULen) {
    rotate([-90, 0, 0]) cylinder(d=od, h=hght);
}

module l_x_end_top() {
    difference() {
        translate([0, 70, 11]) rotate([180, 0, 0]) import("printedparts/2xCoreXY_X-End_Bolt.stl");
        translate([17.5, 3, 0.5]) linearBearing();
        translate([17.5, 42, 0.5]) linearBearing();
    }
}

module l_x_end_bottom() {
    boltholes_zofs=-15;
    nutsholes_zofs=-6.2;
    m3nutt="M3";
    m4nutt="M4";
    bnut_zscale=3;
    m3boltd=3.5;
    m4boltd=4.5;
    difference() {
        union() {
            translate([0, 0, -10.2]) rotate([0, 0, 0]) import("printedparts/2xCoreXY_X-End_Bolt.stl");
            translate([1.2,  -0.5, -10.2]) cube([47.5, 71, 5]);
        }
        // Bolt vert holes
        color("red") {
            // Back holes
            translate([5,  5, boltholes_zofs]) cylinder(d=m3boltd, h=30);
            translate([5, 26, boltholes_zofs]) cylinder(d=m3boltd, h=30);
            translate([5, 44, boltholes_zofs]) cylinder(d=m3boltd, h=30);
            translate([5, 65, boltholes_zofs]) cylinder(d=m3boltd, h=30);
            // Bearing holes
            translate([31.7, 26, boltholes_zofs]) cylinder(d=m4boltd, h=30);
            translate([31.7, 44, boltholes_zofs]) cylinder(d=m4boltd, h=30);
            // Front holes
            translate([45, 3, boltholes_zofs]) cylinder(d=m3boltd, h=30);
            translate([45, 20, boltholes_zofs]) cylinder(d=m3boltd, h=30);
            translate([45, 50, boltholes_zofs]) cylinder(d=m3boltd, h=30);
            translate([45, 67, boltholes_zofs]) cylinder(d=m3boltd, h=30);
            // Mid holes
            translate([30, 3, boltholes_zofs]) cylinder(d=m3boltd, h=30);
            translate([30, 67, boltholes_zofs]) cylinder(d=m3boltd, h=30);
        }
        // Nut holes
        color("blue") {
            // Back holes
            translate([5,  5, nutsholes_zofs]) scale([1, 1, bnut_zscale]) nut(m3nutt);
            translate([5, 26, nutsholes_zofs]) scale([1, 1, bnut_zscale]) nut(m3nutt);
            translate([5, 44, nutsholes_zofs]) scale([1, 1, bnut_zscale]) nut(m3nutt);
            translate([5, 65, nutsholes_zofs]) scale([1, 1, bnut_zscale]) nut(m3nutt);
            // Bearing holes
            translate([31.7, 26, nutsholes_zofs]) scale([1, 1, bnut_zscale]) nut(m4nutt);
            translate([31.7, 44, nutsholes_zofs]) scale([1, 1, bnut_zscale]) nut(m4nutt);
            // Front holes
            translate([45, 3, nutsholes_zofs]) scale([1, 1, bnut_zscale]) nut(m3nutt);
            translate([45, 20, nutsholes_zofs]) scale([1, 1, bnut_zscale]) nut(m3nutt);
            translate([45, 50, nutsholes_zofs]) scale([1, 1, bnut_zscale]) nut(m3nutt);
            translate([45, 67, nutsholes_zofs]) scale([1, 1, bnut_zscale]) nut(m3nutt);
            // Mid holes
            translate([30, 3, nutsholes_zofs]) scale([1, 1, bnut_zscale]) nut(m3nutt);
            translate([30, 67, nutsholes_zofs]) scale([1, 1, bnut_zscale]) nut(m3nutt);
        }
        translate([17.5, 3, 0.5]) linearBearing();
        translate([17.5, 42, 0.5]) linearBearing();
    }
}

l_x_end_bottom();
