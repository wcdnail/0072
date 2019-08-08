include <z-config.scad>
use <../../openscad/nema17.scad>
use <z.scad>
use <x_carriage_directdrive_enhanced.scad>
use <e3d_v5_liftdown_adapter.scad>
use <x_endstop_term.scad>

E3DnoLiftDown=true;
E3DBottomPoint=-38.55;

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
        %translate([0, 0, 6.8+thickness]) rotate([180]) import("../parts/fan_30mm.stl");
    }
}

module M3BoltMount(bz, bh, noBolt=false) {
    difference() {
        translate([19, 25, bz-0.1]) {
            hull() {
                translate([-8, -8, 0]) cube([5, 5, bh/1.2]);
                cylinder(d=10, h=bh/2);
                translate([0, 0, bh/2]) cylinder(d=6, h=bh/2+0.2);
            }
        }
        color("Red") {
            translate([19, 25, bz+4]) { 
                if (!noBolt) {
                    translate([0, 0, -0.1]) cylinder(d=3.3, h=30.1); 
                    translate([0, 0, -10]) cylinder(d=6.3, h=10); 
                }
                else {
                    translate([0, 0, -30]) cylinder(d=3.3, h=50); 
                    translate([0, 0, 0]) scale([1, 1, 3]) nut("M3");
                }
            }
        }
    }
    if (!noBolt) {
        %translate([19, 25, bz+4]) { translate([0, 0, -0.1]) cylinder(d=3, h=30.1); translate([0, 0, -2]) cylinder(d=6, h=2); }
    }
}

module M3BoltMountAll(bz, bh, noBolts=false) {
    M3BoltMount(bz, bh, noBolts);
    mirror([0, 1, 0]) M3BoltMount(bz, bh, noBolts);
    mirror([1, 0, 0]) {
        M3BoltMount(bz, bh, noBolts);
        mirror([0, 1, 0]) M3BoltMount(bz, bh, noBolts);
    }
}

module Z_SinkFan() {
    // Sink fan config
    sy=27.5;
    sz=-10;
    bsx=31.5;
    bsy=45;
    bz=20;
    bzo=6;
    difference() {
        union() {
            difference() {
                union() {
                    // E3D body
                    translate([0, 9, sz+bzo]) rotate([90]) ChamferCyl(bsx, bz, bsy, 4, true, $fn=16);
                    // Sink fan
                    translate([0, -sy, sz]) rotate([90]) {
                        Fan30(drawFan=false, $fn=64);
                        hull() {
                            translate([0, 0, -0.9]) ChamferCyl(32, 32, 2, 4, true, $fn=16);
                            translate([0, bzo, -17]) ChamferCyl(bsx, bz, 4, 4, true, $fn=16);
                        }
                    }
                    mirror([0, 0, 1]) M3BoltMountAll(sz+15, 8, noBolts=true);
                }
                color("Red") translate([0, 0, -100]) cylinder(d=25.2, h=200, $fn=32);
                color("DeepPink") {
                    // E3D body
                    translate([0, 9, sz+bzo]) rotate([90]) ChamferCyl(bsx*0.8, bz*0.8, bsy+5, 4, true, $fn=16);
                    // Sink fan
                    translate([0, -sy, sz]) rotate([90]) {
                        hull() {
                            translate([0, 0, -0.9]) cylinder(d=32*0.9, h=2, $fn=32);
                            translate([0, bzo, -17]) ChamferCyl(bsx*0.8, bz*0.8, 6, 4, true, $fn=16);
                        }
                    }
                }
            }
            // Nuts
            translate([0, -CARCY/2+13, sz+bz/2+1]) cylinder(d1=10, d2=13, h=4, $fn=32);
            translate([0,  CARCY/2-13, sz+bz/2+1]) cylinder(d1=10, d2=13, h=4, $fn=32);
        }
        color("Blue") {
            translate([0, -CARCY/2+13, sz+bz/2+3.6]) scale([1, 1, 2]) nut("M4");
            translate([0,  CARCY/2-13, sz+bz/2+3.6]) scale([1, 1, 2]) nut("M4");
        }
        // Bolts
        translate([0, -CARCY/2+13, sz]) cylinder(d=4.2, h=30, $fn=32);
        translate([0,  CARCY/2-13, sz]) cylinder(d=4.2, h=30, $fn=32);
        // Hatch
        color("Black") translate([0, 87.6, -5]) rotate([64]) cube([100, 100, 100], center=true);
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

module Z_FanDuct(singleFan=true, blowerSlice=false) {
    // Blower config
    bod=55;
    bid=35;
    by=0;
    bh=8;
    bz=E3DBottomPoint+BlowerBottomOffset;
    bdc=0.95;
    tdc=1.02;
    bic=2.2;
    // Blower fan config
    fz=bz+32/2-0.1;
    fy=35;
    // Blower fan
    translate([0, fy, fz]) rotate([-90]) Fan30(5, drawFan=false, $fn=32);
    if(!singleFan) {
        mirror([0, 1, 0]) translate([0, fy, fz]) rotate([-90]) Fan30(5, drawFan=false, $fn=32);
    }
    // Blower
    difference() {
        union() {
            BlowerImpl(by, bz, bh, bod, bid, bdc, tdc, $fn=64);
            // Fan 1
            translate([0, fy, fz]) rotate([-90]) hull() {
                translate([0, 0, -0.9]) ChamferCyl(32, 32, 2, 4, true, $fn=16);
                translate([0, 12, -11.5]) ChamferCyl(20, 8, 4, 4, true, $fn=16);
            }
            // Fan 2
            if(!singleFan) {
                mirror([0, 1, 0]) translate([0, fy, fz]) rotate([-90]) hull() {
                    translate([0, 0, -0.9]) ChamferCyl(32, 32, 2, 4, true, $fn=16);
                    translate([0, 12, -11.5]) ChamferCyl(20, 8, 4, 4, true, $fn=16);
                }
            }
            // Bolt mount
            M3BoltMountAll(bz, bh, noBolts=false);
        }
        color("DeepPink") {
            translate([0, 0, 1]) BlowerImpl(by, bz, bh-2, bod-bic, bid+bic, bdc, tdc, $fn=64);
            // Fan 1
            translate([0, fy, fz]) rotate([-90]) hull() {
                translate([0, 0, -0.9]) cylinder(d=32*0.85, h=4, $fn=32);
                translate([0, 12.9, -11.5]) ChamferCyl(20*0.8, 5*0.8, 4, 4, true, $fn=16);
            }
            // Fan 2
            if(!singleFan) {
                mirror([0, 1, 0]) translate([0, fy, fz]) rotate([-90]) hull() {
                    translate([0, 0, -0.9]) cylinder(d=32*0.85, h=4, $fn=32);
                    translate([0, 12.9, -11.5]) ChamferCyl(20*0.8, 5*0.8, 4, 4, true, $fn=16);
                }
            }
        }
        if (blowerSlice) {
            color("Red") translate([0, -50, -100]) cube([100, 100, 100]);
        }
        color("Red") {
            difference() {
                translate([0, 0, bz+10]) sphere(d=bod/1.16, $fn=64);
                translate([0, 0, bz+10]) sphere(d=bod/1.2, $fn=64);
                translate([0, 0, bz+bod/2+5]) cube([bod, bod, bod], center=true);
            }
        }
    }
}

//Z_SinkFan();
Z_FanDuct(singleFan=true);
//rotate([0, 0, 90]) Z_FanDuct(singleFan=false);
//translate([0, 0, CARTopZOffs+16.6]) E3D_v5_temp(notTransparent=true);
//%render() rotate([0, 0, -90]) CoreXY_X_Carriage_v2(true, "MediumSeaGreen", false);
// Z sensor
//%translate([48, 0, E3DBottomPoint+BlowerBottomOffset-2]) cylinder(h=70, d=18, $fn=32);
