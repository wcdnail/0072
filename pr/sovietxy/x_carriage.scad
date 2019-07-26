include <../../openscad/libs/nutsnbolts/cyl_head_bolt.scad>
include <../../openscad/libs/nutsnbolts/materials.scad>
include <bconf.scad>

module x_carriage_v5() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("printedparts/1xCoreXY_X-Carriage.stl");
}

module x_belt_clamp() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("belt_tensioner.stl");
}

module x_carriage_direct_drive() {
    translate([0, ocy, 0]) rotate([180, 0, 0]) import("printedparts/1xCoreXY_Direct_Drive.stl");
}

module e3d_v6_175() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("../parts/E3D_v6_1.75mm_Universal.stl");
}

module l_x_end_top() {
    translate([0, 70, 11.1]) rotate([180, 0, 0]) import("printedparts/2xCoreXY_X-End_Bolt.stl");
}

module l_x_end_bottom() {
    translate([0, 0, -10.2]) rotate([0, 0, 0]) import("printedparts/2xCoreXY_X-End_Nut.stl");
}

module l_x_end() {
    l_x_end_bottom();
    l_x_end_top();
}

module x_carriage_1s(linguide_d=8, e3d_h=0, hnut_oy=0, lgho=0) {
    difference() {
        difference() {
            union() {
                translate([nxofs, nydec/2, 0.5]) cube([ncx, ocy-nydec-lgho*2, ocz]);
                translate([nxofs, (13+lgho), 10.5]) rotate([0, 90, 0]) cylinder(d=LM8UU_OD+5, h=ncx);
                translate([nxofs, ocy-(13+lgho), 10.5]) rotate([0, 90, 0]) cylinder(d=LM8UU_OD+5, h=ncx);
                translate([ncx-(e3dh_cx+ecx), ocy/2-25, 0.5]) cube([e3dh_cx, 50-lgho*2, e3dh_cz+e3d_h-0.5]);
            }
            translate([0, 13, 10.5]) rotate([0, 90, 0]) cylinder(d=LM8UU_OD, h=50);
            translate([0, ocy-13, 10.5]) rotate([0, 90, 0]) cylinder(d=LM8UU_OD, h=50);
        }
        // Linear guides holes
        translate([-10, (13+lgho), 10.5]) rotate([0, 90, 0]) cylinder(d=linguide_d, h=50);
        translate([-10, ocy-(13+lgho), 10.5]) rotate([0, 90, 0]) cylinder(d=linguide_d, h=50);
        // vert bolts holes
        //translate([30, (13+lgho), -10]) cylinder(d=3.2, h=20);
        //translate([30, ocy-(13+lgho), -10]) cylinder(d=3.2, h=20);
        // vert nut hole
        translate([(ncx)/2+vhole_ofs, ocy/2, -20+hnut_hh]) cylinder(d=4.2, h=40);
        translate([(ncx)/2+vhole_ofs, ocy/2, 1+hnut_hh]) scale([1, 1, 2]) nut(vnut_m);
        // horizontal bolts holes
        translate([-10, (25.5+hnut_oy), hnut_hh]) rotate([0, 90, 0]) cylinder(d=hbolt_d, h=50);
        translate([-10, ocy-(25.5+hnut_oy), hnut_hh]) rotate([0, 90, 0]) cylinder(d=hbolt_d, h=50);
        // horizontal nut holes
        translate([ncx-e3dh_cx-0.5, (25.5+hnut_oy), hnut_hh]) rotate([0, 90, 0]) scale([1, 1, hnut_sf]) nut(hnut_m);
        translate([ncx-e3dh_cx-0.5, ocy-(25.5+hnut_oy), hnut_hh]) rotate([0, 90, 0]) scale([1, 1, hnut_sf]) nut(hnut_m);
        // E3D v6 mount
        translate([ncx-ecx, ocy/2, -10]) cylinder(d=20, h=15);
        translate([ncx-ecx, ocy/2, -10]) cylinder(d=10, h=30);
        translate([ncx+ecx-0.7, ocy/2+2.5, 19.5]) rotate([180, 0, 0]) e3d_v6_175();
        //
        //translate([-6.2, ocy/2, -20]) scale([0.5, 1, 1]) cylinder($fn=10, d=ocx/2.3, h=50);
    }
}

module x_carriage_dd_1s() {
    difference() {
        translate([2.57+vhole_ofs, 0, 0]) x_carriage_direct_drive();
        color("grey") translate([ncx-ecx-3.9+vhole_ofs, -5, -ocz*5]) cube([ocx, ocy, ocz*7]);
        color("grey") translate([0, -ocy+17, -ocz*5]) cube([ocx, ocy, ocz*7]);
    }
}

module x_carriage_1s_stl() {
    import("x_carriage-one-half-draft.stl");
}

bxs=3;
bcx=ncx*2-ecx*2-bxs*2;
bcy=ncy;
bcz=16.7;
bhcx=bcx/2.1;
bhcy=bcy/1.2;
tbh_ybase=-1.6;

module x_carriage_top() {
    sl_ang=45;
    difference() {
        union() {
            translate([bxs, nydec/2, -bcz]) cube([bcx, bcy, bcz]);
        }
        translate([bxs+(bcx-bhcx)/2, nydec/2+(bcy-bhcy)/2, -bcz*1.5]) cube([bhcx, bhcy, bcz*2]);
        // vert holes 
        translate([(ncx)/2+vhole_ofs, ocy/2, -100]) cylinder(d=4.2, h=200);
        translate([(ncx)/2+vhole_ofs, ocy/2, -(bcz+6)]) cylinder(d=8.1, h=10);
        translate([(ncx*2-ecx*2)-((ncx)/2+vhole_ofs), ocy/2, -100]) cylinder(d=4.2, h=200);
        translate([(ncx*2-ecx*2)-((ncx)/2+vhole_ofs), ocy/2, -(bcz+6)]) cylinder(d=8.1, h=10);
        // Top bolts holes
        translate([-ocx/2, tbh_ybase+26.1, -9.85]) rotate([0, 90, 0]) cylinder(d=3.05, h=ocx*2);
        translate([-ocx/2, tbh_ybase+53, -9.85]) rotate([0, 90, 0]) cylinder(d=3.05, h=ocx*2);
        // Top nut holes
        translate([12.1, tbh_ybase+26, -24.2]) cube([3, 5.6, 35], center=true);
        translate([12.1, tbh_ybase+53, -24.2]) cube([3, 5.6, 35], center=true);
        translate([(ncx*2-ecx*2)-12.1, tbh_ybase+26, -24.2]) cube([3, 5.6, 35], center=true);
        translate([(ncx*2-ecx*2)-12.1, tbh_ybase+53, -24.2]) cube([3, 5.6, 35], center=true);
        //
        translate([-ecx*2, 10, -(bcz + 19)]) rotate([sl_ang, 0, 0]) cube([ocx, 20, 30]);
        mirror([0, 1, 0]) translate([-ecx*2, -(ocy-10), -(bcz + 19)]) rotate([sl_ang, 0, 0]) cube([ocx, 20, 30]);
        //
        translate([bxs+(bcx-bhcx)/2, -(bcy-bhcy)/2, -(bcz-7+30)]) cube([bhcx, bhcy*2, 30]);
    }
}

//color("blue") translate([ncx+ecx-0.7, ocy/2+2.5, 19.5]) rotate([180, 0, 0]) e3d_v6_175();
//%x_carriage_v5();
//translate([-3.425, 0, 0]) %x_carriage_direct_drive();
//x_carriage_1s(12, -1, 3);
//x_carriage_1s_stl();
//translate([ncx*2-ecx*2, 0, 0]) mirror([1, 0, 0]) x_carriage_1s_stl();
//translate([0, 0, -0.2]) x_carriage_top();
//rotate([180, 0, 0]) x_carriage_top();
//translate([-6, 38.08, -10.16]) rotate([90, 0, 90]) color("Red") x_belt_clamp();