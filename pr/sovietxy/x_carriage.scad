half_length_factor=3;
$fn=64;
ocx=76;
ocy=76;
ocz=14;

lm8uu_od=16;
al_detector_d=18;
ecx=3;
ncx=ocx/half_length_factor+ecx;
nxofs=-ecx;
nydec=8;

module x_carriage_v5() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("printedparts/1xCoreXY_X-Carriage.stl");
}

module e3d_v6_175() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("../parts/E3D_v6_1.75mm_Universal.stl");
}


module x_carriage_1s() {
    difference() {
        difference() {
            union() {
                translate([nxofs, nydec/2, 0]) cube([ncx, ocy - nydec, ocz]);
                translate([nxofs, 13, 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uu_od+5, h=ncx);
                translate([nxofs, ocy-13, 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uu_od+5, h=ncx);
                //translate([ncx-21, ocy/2-25, 0]) cube([18, 50, 14]);
            }
            translate([0, 13, 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uu_od, h=50);
            translate([0, ocy-13, 10.5]) rotate([0, 90, 0]) cylinder(d=lm8uu_od, h=50);
        }
        translate([-10, 13, 10.5]) rotate([0, 90, 0]) cylinder(d=8, h=50);
        translate([-10, ocy-13, 10.5]) rotate([0, 90, 0]) cylinder(d=8, h=50);
        // vert bolts holes
        translate([30, 13, -10]) cylinder(d=3.2, h=20);
        translate([30, ocy-13, -10]) cylinder(d=3.2, h=20);
        // horizontal bolts holes
        translate([-10, 25.5, 8.5]) rotate([0, 90, 0]) cylinder(d=4.2, h=50);
        translate([-10, ocy-25.5, 8.5]) rotate([0, 90, 0]) cylinder(d=4.2, h=50);
        // E3D v6 mount
        translate([ncx-ecx, ocy/2, -10]) cylinder(d=20, h=15);
        translate([ncx-ecx, ocy/2, -10]) cylinder(d=10, h=30);
        translate([ncx+ecx-0.7, ocy/2+2.5, 19.5]) rotate([180, 0, 0]) e3d_v6_175();
    }
}

module x_carriage_1s_w_autoleveling_detector_hole() {
    dt_ofs=-0;
    difference() {
        union() {
            x_carriage_1s();
            translate([dt_ofs, ocy/2, 0]) cylinder(d=al_detector_d+2.5, h=ocz);
        }
        translate([dt_ofs, ocy/2, -10]) cylinder(d=al_detector_d, h=100);
    }
}

//%x_carriage_v5();
x_carriage_1s();
//x_carriage_1s_w_autoleveling_detector_hole();
