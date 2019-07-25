include <x_carriage.scad>

rods_diff=0.7;

slice_zo=ocz+8;
slice_zyo=2;
sl_cy=11.65;
sl_zo=2.5;

x_rodh=420;
y_rodh=405;
x_barh=490;
y_barh=450;

module x_carriage_opened(lm8uuend_d=12, lgho=1.5) {
    difference() {
        union() {
            x_carriage_1s(12, -1, 3, lgho);
            translate([nxofs, 13, 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uu_od+5, h=ncx);
            translate([nxofs, ocy-13, 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uu_od+5, h=ncx);
        }
        color("red") translate([-ecx*2, -1.9, slice_zo]) cube([(ocx-ecx)/2, ocy/3, ocz*2]);
        color("red") translate([-ecx*2, ocy-ocy/3+slice_zyo, slice_zo]) cube([(ocx-ecx)/2, ocy/3, ocz*2]);
        // LM8UU slices
        translate([0, (13+lgho), slice_zo-sl_zo]) cube([(ncx+ecx)*2, sl_cy, 5], center=true);
        translate([0, ocy-(13+lgho), slice_zo-sl_zo]) cube([ocx, sl_cy, 5], center=true);
        // LM8UU holes
        translate([0, (13+lgho), 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uu_od, h=lm8uu_cx);
        translate([0, ocy-(13+lgho), 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uu_od, h=lm8uu_cx);
        // Linear guides holes
        translate([-10, (13+lgho), 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uuend_d, h=50);
        translate([-10, ocy-(13+lgho), 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uuend_d, h=50);
    }
}

module x_rods(rod_d, bx, cx, by, cy, px = 0, py = 0) {
    xe_px=bx/2 + px;
    xe_py=by/2 + py;
    translate([(bx-cx)/2, xe_py - 25, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=rod_d);
    translate([(bx-cx)/2, xe_py - 25 + 50, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=rod_d);
}

//translate([ncx+ecx*2+10, 0, 0]) %x_carriage_1s_stl();
translate([-50, -187, -5]) %x_rods(10, x_barh, x_rodh, y_barh, y_rodh);
x_carriage_opened(12, rods_diff);


