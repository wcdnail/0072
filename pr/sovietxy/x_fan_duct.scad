include <z-config.scad>
use <../../openscad/nema17.scad>
use <z.scad>
use <x_carriage_directdrive_enhanced.scad>
use <e3d_v5_liftdown_adapter.scad>
use <x_endstop_term.scad>

E3DnoLiftDown=true;

module Fan30(fh=4) {
    fd=30;      // fan diameter
    fhd=28;     // central hole diameter
    bhd=2.8;    // M3 bolt diameter
    diamdif=0;  // top & bottom diameter inc/dec
    difference() {
        //cube([30, 30, fh], center=true);
        union() {
            hull() {
                translate([-fd/2+1, -fd/2+1, 0]) cylinder(d=4, h=fh);
                translate([ fd/2-1, -fd/2+1, 0]) cylinder(d=4, h=fh);
                translate([ fd/2-1,  fd/2-1, 0]) cylinder(d=4, h=fh);
                translate([-fd/2+1,  fd/2-1, 0]) cylinder(d=4, h=fh);
            }
        }
        color("Red") {
            // Fan hole
            translate([0, 0, -fh*2]) cylinder(d1=fhd-diamdif, d2=fhd+diamdif, h=fh*4);
            // Bolt holes
            translate([-fd/2+3, -fd/2+3, -fh]) cylinder(d=bhd, h=fh*3);
            translate([ fd/2-3, -fd/2+3, -fh]) cylinder(d=bhd, h=fh*3);
            translate([ fd/2-3,  fd/2-3, -fh]) cylinder(d=bhd, h=fh*3);
            translate([-fd/2+3,  fd/2-3, -fh]) cylinder(d=bhd, h=fh*3);
        }
    }
    %translate([0, 0, -fh*2+1]) import("../parts/fan_30mm.stl");
}

module CoreXY_Carriage_Z_Sensor() {
    sby=58;
    sbz=30;
    //render()
    difference() {
        union() {
            translate([0, 0, CARTopZBeg]) linear_extrude(height=CARTopBaseCZ/2)
                polygon(points=[[ 16, 20],[ 16, 18.5],[-13, 18.5],[-16, 15],[-38, 15],[-38, 32],[-16, 32],[-16, sby],[16, sby],[16, 32],[30, 32],[30, 20]]);
            translate([0, sby, CARTopZBeg-sbz]) cylinder(h=CARTopBaseCZ/2, d=32);
        }
        color("Red"){
            // M3 vert holes
            translate([-8, 25, -75]) cylinder(h=200, d=3.2);
            translate([ 8, 25, -75]) cylinder(h=200, d=3.2);
            // Z sensor
            translate([0, sby, CARTopZBeg-5-sbz]) cylinder(h=200, d=18.4);
        }
    }
    %translate([0, sby, CARTopZBeg-sbz-45]) cylinder(h=70, d=18);
}

module CoreXY_Assembled_Carriage_FanDuct() {
    // Каретка с хот-ендом
    CoreXY_X_Carriage_v2(true, "MediumSeaGreen", false);
    if (!E3DnoLiftDown) {
        E3D_v5_liftdown_adapter(true, "Brown");
        E3D_v5_liftdown_clamp("Brown");
        E3D_v5_temp(notTransparent=true);
    }
    else {
        translate([0, 0, CARTopZOffs+16.6]) E3D_v5_temp(notTransparent=true);
    }
    CoreXY_FanDuct_1();
}

module CoreXY_FanDuct_1() {
    blowerZ=-30;
    blowerH=2;
    blowerSH=3;
    blowerDia=60;
    blowerInnerDia=blowerDia+2;
    blowerOuterDia=blowerDia-2;
    rotate([-20]) translate([0, 35, 5]) rotate([90]) Fan30();
    difference() {
        translate([0, 0, blowerZ]) cylinder(d=blowerOuterDia, h=blowerSH);
        color("Red") translate([0, 0, blowerZ+blowerInnerDia/4]) sphere(d=blowerOuterDia);
    }
    difference() {
        intersection() {
            translate([0, 0, blowerZ]) cylinder(d=blowerInnerDia, h=blowerH);
            color("Red") translate([0, 0, blowerZ+blowerInnerDia/3]) sphere(d=blowerInnerDia);
        }
        color("Red") translate([0, 0, blowerZ-blowerInnerDia/4]) sphere(d=blowerInnerDia/1.2);
    }
}

CoreXY_Assembled_Carriage_FanDuct();
//CoreXY_Carriage_Z_Sensor();
