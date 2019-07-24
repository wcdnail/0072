include <x_carriage.scad>

slice_zo=ocz+8;
slice_zyo=2;
sl_cy=12;
sl_zo=2.5;

module x_carriage_opened(linguide_d=12) {
    difference() {
        union() {
            x_carriage_1s_stl();
            translate([nxofs, 13, 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uu_od+5, h=ncx);
            translate([nxofs, ocy-13, 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uu_od+5, h=ncx);
        }
        color("red") translate([-ecx*2, -1.9, slice_zo]) cube([(ocx-ecx)/2, ocy/3, ocz*2]);
        color("red") translate([-ecx*2, ocy-ocy/3+slice_zyo, slice_zo]) cube([(ocx-ecx)/2, ocy/3, ocz*2]);
        // LM8UU slices
        translate([0, 13, slice_zo-sl_zo]) cube([(ncx+ecx)*2, sl_cy, 5], center=true);
        translate([0, ocy-13, slice_zo-sl_zo]) cube([ocx, sl_cy, 5], center=true);
        // LM8UU holes
        translate([0, 13, 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uu_od, h=lm8uu_cx);
        translate([0, ocy-13, 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uu_od, h=lm8uu_cx);
        // Linear guides holes
        translate([-10, 13, 10.5]) rotate([0, 90, 0]) cylinder(d=linguide_d, h=50);
        translate([-10, ocy-13, 10.5]) rotate([0, 90, 0]) cylinder(d=linguide_d, h=50);
    }
}

x_carriage_opened();



