include <../../openscad/libs/nutsnbolts/cyl_head_bolt.scad>
include <../../openscad/libs/nutsnbolts/materials.scad>
include <bconf.scad>

module x_carriage_1s(rodsHolesDiam=8, e3dZOffset=0) {
    difference() {
        difference() {
            union() {
                translate([carBaseXOffset, carYShrink/2, carBaseZOffset]) cube([carCX, OrigCARWidth-carYShrink-LM8UUCenterOffset*2, OrigCARHeightWOHolder]);
                translate([carBaseXOffset, (13+LM8UUCenterOffset), carBaseZOffset+10.5]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam+LM8UUHolderOD, h=carCX);
                translate([carBaseXOffset, OrigCARWidth-(13+LM8UUCenterOffset),  carBaseZOffset+10.5]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam+LM8UUHolderOD, h=carCX);
                translate([carCX-(e3dBaseXOffset+carXEdge), OrigCARWidth/2-25,  carBaseZOffset]) cube([e3dBaseXOffset, 50-LM8UUCenterOffset*2, e3dBaseYOffset+e3dZOffset-0.5]);
            }
            translate([0, 13, carBaseZOffset+10.5]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam, h=50);
            translate([0, OrigCARWidth-13, carBaseZOffset+10.5]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam, h=50);
        }
        // Linear guides holes
        translate([-10, (13+LM8UUCenterOffset), carBaseZOffset+10.5]) rotate([0, 90, 0]) cylinder(d=rodsHolesDiam, h=50);
        translate([-10, OrigCARWidth-(13+LM8UUCenterOffset), carBaseZOffset+10.5]) rotate([0, 90, 0]) cylinder(d=rodsHolesDiam, h=50);
        // Vert bolts holes
        //translate([30, (13+LM8UUCenterOffset), carBaseZOffset-10]) cylinder(d=hbolt_d, h=20);
        //translate([30, OrigCARWidth-(13+LM8UUCenterOffset), carBaseZOffset-10]) cylinder(d=hbolt_d, h=20);
        // Vert nut hole
        translate([(carCX)/2+vhole_ofs, OrigCARWidth/2, carBaseZOffset-20+hnut_hh]) cylinder(d=vbolt_d, h=40);
        translate([(carCX)/2+vhole_ofs, OrigCARWidth/2, carBaseZOffset+1+hnut_hh]) scale([1, 1, 2]) nut(vnut_m);
        // Horizontal bolts holes
        translate([-10, (25.5+e3dNutsYOffset), carBaseZOffset+hnut_hh]) rotate([0, 90, 0]) cylinder(d=hbolt_d, h=50);
        translate([-10, OrigCARWidth-(25.5+e3dNutsYOffset), carBaseZOffset+hnut_hh]) rotate([0, 90, 0]) cylinder(d=hbolt_d, h=50);
        // horizontal nut holes
        translate([carCX-e3dBaseXOffset-0.5, (25.5+e3dNutsYOffset), carBaseZOffset+hnut_hh]) rotate([0, 90, 0]) scale([1, 1, hnut_sf]) nut(hnut_m);
        translate([carCX-e3dBaseXOffset-0.5, OrigCARWidth-(25.5+e3dNutsYOffset), carBaseZOffset+hnut_hh]) rotate([0, 90, 0]) scale([1, 1, hnut_sf]) nut(hnut_m);
        // E3D v6 mount
        translate([carCX-carXEdge, OrigCARWidth/2, carBaseZOffset-10]) cylinder(d=20, h=15);
        translate([carCX-carXEdge, OrigCARWidth/2, carBaseZOffset-10]) cylinder(d=10, h=30);
        translate([carCX+carXEdge-0.7, OrigCARWidth/2+2.5, carBaseZOffset+19.5]) rotate([180, 0, 0]) e3d_v6_175();
        //
        //translate([-6.2, OrigCARWidth/2, carBaseZOffset-20]) scale([0.8, 1, 1]) cylinder($fn=10, d=OrigCARLen/2.3, h=50);
    }
}

module x_carriage_dd_1s() {
    difference() {
        translate([2.57+vhole_ofs, 0, 0]) x_carriage_direct_drive();
        color("grey") translate([carCX-carXEdge-3.9+vhole_ofs, -5, -OrigCARHeightWOHolder*5]) cube([OrigCARLen, OrigCARWidth, OrigCARHeightWOHolder*7]);
        color("grey") translate([0, -OrigCARWidth+17, -OrigCARHeightWOHolder*5]) cube([OrigCARLen, OrigCARWidth, OrigCARHeightWOHolder*7]);
    }
}

bxs=3;
bcx=carCX*2-carXEdge*2-bxs*2;
bcy=carCY;
bcz=16.7;
bhcx=bcx/2.1;
bhcy=bcy/1.2;
tbh_ybase=-1.6;

module x_carriage_top() {
    sl_ang=45;
    difference() {
        union() {
            translate([bxs, carYShrink/2, -bcz]) cube([bcx, bcy, bcz]);
        }
        translate([bxs+(bcx-bhcx)/2, carYShrink/2+(bcy-bhcy)/2, -bcz*1.5]) cube([bhcx, bhcy, bcz*2]);
        // vert holes 
        translate([(carCX)/2+vhole_ofs, OrigCARWidth/2, -100]) cylinder(d=4.2, h=200);
        translate([(carCX)/2+vhole_ofs, OrigCARWidth/2, -(bcz+6)]) cylinder(d=8.1, h=10);
        translate([(carCX*2-carXEdge*2)-((carCX)/2+vhole_ofs), OrigCARWidth/2, -100]) cylinder(d=4.2, h=200);
        translate([(carCX*2-carXEdge*2)-((carCX)/2+vhole_ofs), OrigCARWidth/2, -(bcz+6)]) cylinder(d=8.1, h=10);
        // Top bolts holes
        translate([-OrigCARLen/2, tbh_ybase+26.1, -9.85]) rotate([0, 90, 0]) cylinder(d=3.05, h=OrigCARLen*2);
        translate([-OrigCARLen/2, tbh_ybase+53, -9.85]) rotate([0, 90, 0]) cylinder(d=3.05, h=OrigCARLen*2);
        // Top nut holes
        translate([12.1, tbh_ybase+26, -24.2]) cube([3, 5.6, 35], center=true);
        translate([12.1, tbh_ybase+53, -24.2]) cube([3, 5.6, 35], center=true);
        translate([(carCX*2-carXEdge*2)-12.1, tbh_ybase+26, -24.2]) cube([3, 5.6, 35], center=true);
        translate([(carCX*2-carXEdge*2)-12.1, tbh_ybase+53, -24.2]) cube([3, 5.6, 35], center=true);
        //
        translate([-carXEdge*2, 10, -(bcz + 19)]) rotate([sl_ang, 0, 0]) cube([OrigCARLen, 20, 30]);
        mirror([0, 1, 0]) translate([-carXEdge*2, -(OrigCARWidth-10), -(bcz + 19)]) rotate([sl_ang, 0, 0]) cube([OrigCARLen, 20, 30]);
        //
        translate([bxs+(bcx-bhcx)/2, -(bcy-bhcy)/2, -(bcz-7+30)]) cube([bhcx, bhcy*2, 30]);
    }
}

//color("blue") translate([carCX+carXEdge-0.7, OrigCARWidth/2+2.5, 19.5]) rotate([180, 0, 0]) e3d_v6_175();
//%x_carriage_v5();
//translate([-3.425, 0, 0]) %x_carriage_direct_drive();
//x_carriage_1s(12, -1);
//x_carriage_1s_stl();
//translate([carCX*2-carXEdge*2, 0, 0]) mirror([1, 0, 0]) x_carriage_1s_stl();
//translate([0, 0, -0.2]) x_carriage_top();
//rotate([180, 0, 0]) x_carriage_top();
//translate([-6, 38.08, -10.16]) rotate([90, 0, 90]) color("Red") x_belt_clamp();
