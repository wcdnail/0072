include <z-config.scad>
use <z.scad>

CARTopZOffs=3.5;

module x_end_rods_check() {
    translate([-120, -XENDCY/2, 10]) l_x_end();
    translate([-90,  XRODSDiff/2, XENDFullCZ/2]) rotate([0, 90, 0]) cylinder(d=RODXYDiam, h=RODXLen);
    translate([-90, -XRODSDiff/2, XENDFullCZ/2]) rotate([0, 90, 0]) cylinder(d=RODXYDiam, h=RODXLen);
}

module car_base_holes() {
    color("Red") {
        translate([0, 0, XENDFullCZ-200]) cylinder(h=400, d=E3DradDiam+3);
        translate([-CARCX/2+13, 0, XENDFullCZ-200]) cylinder(h=400, d=4.5);
        translate([ CARCX/2-13, 0, XENDFullCZ-200]) cylinder(h=400, d=4.5);
        translate([-8,  CARCY/2-13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([ 8,  CARCY/2-13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([-8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([ 8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([ 0,  CARCY/2-20, XENDFullCZ-200]) cylinder(h=400, d=8);
        translate([ 0,  CARCY/2-25, XENDFullCZ-100]) cube([8, 10, 300], center=true);
        translate([-CARCX/2+13, 0, XENDFullCZ-4]) scale([1, 1, 2]) nut("M4");
        translate([ CARCX/2-13, 0, XENDFullCZ-4]) scale([1, 1, 2]) nut("M4");
    }
}

module car_base() {
    %translate([0, 0, 16.5-CARTopZOffs]) rotate([0, 0, 90]) e3d_v6_175();
    translate([-CAR2CX/2, -CARCY/2, XENDFullCZ-CARBaseCZ]) cube([CAR2CX, CARCY, CARBaseCZ]);
}

module car_lmu88_holder1() {
    sz=XENDFullCZ;
    bhy=CARCY/2.8;
    bhz=LM8UUOutterDiam-3.5;
    bslicez=14.6;
    wsz=5;
    wz=6.7;
    difference() {
        // Bearing holder
        union() {
            translate([CARCX/2-LM8UULen-CARXE, CARCY/2-bhy, sz]) rotate([0, 90, 0])
                linear_extrude(height=LM8UULen+CARXE*2) polygon(points=[[0, 0],[CARBaseCZ, 0],[CARBaseCZ+bhz, bhy/6],[CARBaseCZ+bhz, bhy-bhy/7],[CARBaseCZ, bhy], [0, bhy]]);
            translate([-0.1, -0.1, sz-wsz]) cube([CARCX/4, CARCY/2-CARXE*2, wsz]);
            translate([16, -0.1, sz-wz]) cube([18, CARCY/4, wz]);
        }
        // Linear bearing
        color("Red") {
            translate([CARCX/2-LM8UULen, XRODSDiff/2, sz/2]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam, h=LM8UULen);
            translate([CARCX/2-LM8UULen*1.5, XRODSDiff/2, sz/2]) rotate([0, 90, 0]) cylinder(d=RODXYDiam*1.3, h=LM8UULen*2);
            translate([CARCX/2-LM8UULen/2, XRODSDiff/2, 0]) scale([1, 1, 0.7]) rotate([45, 0, 0]) cube([LM8UULen*2, LM8UULen, LM8UULen], center=true);
            cube([CARCX*2, CARCY*2, bslicez], center=true);
        }
    }
}

module car_lmu88_holder2() {
    translate([0, 0, -0.35]) car_lmu88_holder1();
    translate([0, 0, -0.35]) mirror([0, 1, 0]) car_lmu88_holder1();
}

module car_lmu88_holders_all() {
    car_lmu88_holder2();
    mirror([1, 0, 0]) car_lmu88_holder2();
}

module carriage_v12(skipDims=false) {
    difference() {
        union() {
            car_base();
            car_lmu88_holders_all();
        }
        car_base_holes();
    }
    if(!skipDims) {
        color("black") {
            translate([0, 0, XENDFullCZ]) x_dim(CAR2CX, 0, 0, 100);
            translate([0, 0, XENDFullCZ]) y_dim(0, CARCY, 0, 100);
            translate([0, 0, XENDFullCZ-XENDFullCZ/2]) y_dim(0, XRODSDiff, 0, 80);
        }
    }
}

module carriage_v12_direct(modelClr="Crimson") {
    color(modelClr) translate([0, 0, -CARTopZOffs]) rotate([0, 0, 180]) translate([-CARCX/2, -CARCY/2, 25]) import("printedparts/1xCoreXY_Direct_Drive.stl");
}

%x_end_rods_check();
//%translate([0, 0, XENDFullCZ]) rotate([180, 0, 0]) x_carriage_v5();
carriage_v12_direct();
carriage_v12(true);
//translate([0, 0, 16.5]) rotate([0, 0, 90]) e3d_v6_175();
