include <z-config.scad>
use <../../openscad/nema17.scad>
use <z.scad>
use <x_carriage_directdrive_enhanced.scad>
use <e3d_v5_liftdown_adapter.scad>
use <x_endstop_term.scad>

E3DnoLiftDown=true;
E3DBottomPoint=-38.55;

module CoreXY_Assembled_Carriage_FanDuct() {
    // Каретка с хот-ендом
    CoreXY_X_Carriage_v2(true, "MediumSeaGreen", false);
    //CoreXY_Direct_Drive_v2("Yellow", rendStop=true, lendStop=true);
    if (!E3DnoLiftDown) {
        E3D_v5_liftdown_adapter(true, "Brown");
        E3D_v5_liftdown_clamp("Brown");
        rotate([0, 0, 90]) E3D_v5_temp(notTransparent=true);
    }
    else {
        translate([0, 0, CARTopZOffs+16.6]) rotate([0, 0, 90]) E3D_v5_temp(notTransparent=true);
    }
    rotate([0, 0, -90]) Z_FanDuct();
}

module ChamferCyl(scx, scy, cz, diam=3, center=false) {
    r=diam/2;
    cx=scx-diam;
    cy=scy-diam;
    sx=center?-scx/2+r:r;
    sy=center?-scy/2+r:r;
    sz=center?-cz/2:0;
    hull() {
        translate([sx, sy, sz]) cylinder(d=diam, h=cz);
        translate([sx+cx, sy, sz]) cylinder(d=diam, h=cz);
        translate([sx+cx, sy+cy, sz]) cylinder(d=diam, h=cz);
        translate([sx,  sy+cy, sz]) cylinder(d=diam, h=cz);
    }
}

module ChamferBox(scx, scy, scz, diam=3, center=false) {
    r=diam/2;
    cx=scx-diam;
    cy=scy-diam;
    cz=scz-diam;
    sx=center?-scx/2+r:r;
    sy=center?-scy/2+r:r;
    sz=center?-scz/2+r:r;
    hull() {
        // Bottom
        translate([sx, sy, sz]) sphere(d=diam);
        translate([sx+cx, sy, sz]) sphere(d=diam);
        translate([sx+cx, sy+cy, sz]) sphere(d=diam);
        translate([sx,  sy+cy, sz]) sphere(d=diam);
        // Top
        translate([sx, sy, sz+cz]) sphere(d=diam);
        translate([sx+cx, sy, sz+cz]) sphere(d=diam);
        translate([sx+cx, sy+cy, sz+cz]) sphere(d=diam);
        translate([sx,  sy+cy, sz+cz]) sphere(d=diam);
    }
}


module FanPlane(thickness, fanDiam, hullDiam, xo=0, yo=0, sx=1, sy=1) {
    hull() {
        translate([xo-fanDiam/2+1*sx, yo-fanDiam/2+1*sy, 0]) cylinder(d=hullDiam, h=thickness);
        translate([xo+fanDiam/2-1*sx, yo-fanDiam/2+1*sy, 0]) cylinder(d=hullDiam, h=thickness);
        translate([xo+fanDiam/2-1*sx, yo+fanDiam/2-1*sy, 0]) cylinder(d=hullDiam, h=thickness);
        translate([xo-fanDiam/2+1*sx, yo+fanDiam/2-1*sy, 0]) cylinder(d=hullDiam, h=thickness);
    }
}

module Fan(radius, thickness=4, edgeHullDiam=4, centralHoleCoef=0.93, boltsDiam=2.8) {
    difference() {
        FanPlane(thickness, radius, edgeHullDiam);
        color("Red") translate([0, 0, -thickness*2]) cylinder(d=centralHoleCoef*radius, h=thickness*4);
        color("OrangeRed") {
            translate([-radius/2+3, -radius/2+3, -thickness]) cylinder(d=boltsDiam, h=thickness*3);
            translate([ radius/2-3, -radius/2+3, -thickness]) cylinder(d=boltsDiam, h=thickness*3);
            translate([ radius/2-3,  radius/2-3, -thickness]) cylinder(d=boltsDiam, h=thickness*3);
            translate([-radius/2+3,  radius/2-3, -thickness]) cylinder(d=boltsDiam, h=thickness*3);
        }
    }
}

module Fan30(thickness=4, edgeHullDiam=4, centralHoleCoef=0.93, boltsDiam=2.8, clr="LightSalmon", drawFan=false) {
    color(clr) Fan(30, thickness, edgeHullDiam, centralHoleCoef, boltsDiam);
    if(drawFan) {
        %translate([0, 0, thickness*2+2.8]) rotate([180]) import("../parts/fan_30mm.stl");
    }
}

module Z_SinkFan() {
    // Sink fan config
    sy=32;
    sz=-10;
    bsx=31;
    bsy=31;
    bz=20;
    difference() {
        union() {
            // E3D body
            translate([0, 0, sz+6]) ChamferBox(bsx, bsy, bz, 4, true, $fn=16);
            // Sink fan
            translate([0, -sy, sz]) rotate([90]) {
                Fan30($fn=64);
                hull() {
                    translate([0, 0, -0.9]) ChamferCyl(32, 32, 2, 4, true, $fn=16);
                    translate([0, 6, -17]) ChamferCyl(bsx, bz, 4, 4, true, $fn=16);
                }
            }
        }
        color("DeepPink") translate([0, -sy, sz]) rotate([90]) {
            hull() {
                translate([0, 0, 0.3]) mirror([0, 0, 1]) cylinder(d=32*0.9, h=1.5, $fn=32);
                translate([0, 6.65, -18]) ChamferCyl(bsx-5, bz-5, 4, 4, true);
            }
            translate([0, 6.65, -38]) ChamferCyl(bsx-5, bz-5, 40, 4, true);
        }
        color("Red") translate([0, 0, -100]) cylinder(d=25.2, h=200, $fn=32);
    }
}

BlowerBottomOffset=3;

module BlowerImpl(by, bz, bh, bod, bid, bdc, tdc) {
    difference() {
        // Blower
        union() {
            translate([0, by, bz-0.1]) cylinder(d1=bod*bdc, d2=bod*tdc, h=bh/2+0.2);
            translate([0, by, bz+bh/2]) cylinder(d=bod*tdc, h=bh/2);
        }
        translate([0, 0, bz-2]) cylinder(d=bid, h=bh+4);
    }
}

module Z_FanDuct(blowerSlice=true) {
    baseYOffset=45;
    // Blower config
    bod=70;
    bid=45;
    by=baseYOffset/5;
    bh=8;
    bz=E3DBottomPoint+BlowerBottomOffset;
    bdc=0.95;
    tdc=1.02;
    bic=2.2;
    // Blower fan config
    fz=bz+bh+2;
    fy=baseYOffset-11.5;
    // Blower fan
    translate([0, fy, fz]) Fan30($fn=32);
    // Blower
    difference() {
        BlowerImpl(by, bz, bh, bod, bid, bdc, tdc, $fn=64);
        color("DeepPink") translate([0, 0, 1]) BlowerImpl(by, bz, bh-2, bod-bic, bid+bic, bdc, tdc, $fn=64);
        if (blowerSlice) {
            color("Red") translate([0, -50, -100]) cube([100, 100, 100]);
        }
    }
    Z_SinkFan();
}

Z_FanDuct();
//Z_SinkFan();
//translate([0, 0, CARTopZOffs+16.6]) E3D_v5_temp(notTransparent=true);
//CoreXY_Assembled_Carriage_FanDuct();
