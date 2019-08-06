include <z-config.scad>
use <../../openscad/nema17.scad>
use <z.scad>
use <x_carriage_directdrive_enhanced.scad>
use <e3d_v5_liftdown_adapter.scad>
use <x_endstop_term.scad>

E3DnoLiftDown=true;

module FanPlane(thickness, fanDiam, hullDiam, xo=0, yo=0, sx=1, sy=1) {
    hull() {
        translate([xo-fanDiam/2+1*sx, yo-fanDiam/2+1*sy, 0]) cylinder(d=hullDiam, h=thickness);
        translate([xo+fanDiam/2-1*sx, yo-fanDiam/2+1*sy, 0]) cylinder(d=hullDiam, h=thickness);
        translate([xo+fanDiam/2-1*sx, yo+fanDiam/2-1*sy, 0]) cylinder(d=hullDiam, h=thickness);
        translate([xo-fanDiam/2+1*sx, yo+fanDiam/2-1*sy, 0]) cylinder(d=hullDiam, h=thickness);
    }
}

module FanInnerHull(dist, begThickness, begDiam, begHull, endThickness, endDiam, endHull, begX=0, begY=0, endX=0, endY=0, begSX=1, begSY=1, endSX=1, endSY=1, begHullHole=false, useEndHoleCoef=true, EndHoleCoef=0.9) {
    begCoef=endDiam/begDiam+0.2;
    endCoef=endDiam/begDiam+0.35;
    hull() {
        if (begHullHole) {
            translate([0, 0,  dist/2+1*begCoef]) FanPlane(begThickness, begDiam*begCoef, begHull, begX, begY, begSX, begSY);
        }
        else {
            translate([0, 0,  dist/2+1*begCoef]) cylinder(d=begDiam*0.9, h=begThickness);
        }
        if (useEndHoleCoef) {
            translate([0, 0, -dist/2-1*endCoef]) FanPlane(endThickness, endDiam*endCoef, endHull, endX, endY, endSX, endSY);
        }
        else {
            translate([0, 0, -dist/2-1]) FanPlane(endThickness, endDiam*EndHoleCoef, endHull, endX, endY, endSX, endSY);
        }
    }
}

module FanHull(dist, begThickness, begDiam, begHull, endThickness, endDiam, endHull, begX=0, begY=0, endX=0, endY=0, begSX=1, begSY=1, endSX=1, endSY=1, begHullHole=false, useEndHoleCoef=true, EndHoleCoef=0.9) {
    bhd=2.5; // M3 bolt diameter
    difference() {
        hull() {
            translate([0, 0,  dist/2]) FanPlane(begThickness, begDiam, begHull, begX, begY, begSX, begSY);
            translate([0, 0, -dist/2]) FanPlane(endThickness, endDiam, endHull, endX, endY, endSX, endSY);
        }
        color("Red") {
            // Fan hole
            FanInnerHull(dist, begThickness, begDiam, begHull, endThickness, endDiam, endHull, begX, begY, endX, endY, begSX, begSY, endSX, endSY, begHullHole, useEndHoleCoef, EndHoleCoef);
            // Bolt holes
            translate([-begDiam/2+3, -begDiam/2+3, dist/2-1]) cylinder(d=bhd, h=begThickness+4);
            translate([ begDiam/2-3, -begDiam/2+3, dist/2-1]) cylinder(d=bhd, h=begThickness+4);
            translate([ begDiam/2-3,  begDiam/2-3, dist/2-1]) cylinder(d=bhd, h=begThickness+4);
            translate([-begDiam/2+3,  begDiam/2-3, dist/2-1]) cylinder(d=bhd, h=begThickness+4);
        }
    }
}

module Fan30(fh=4) {
    fd=30;      // fan diameter
    fhd=28;     // central hole diameter
    bhd=2.8;    // M3 bolt diameter
    diamdif=0;  // top & bottom diameter inc/dec
    difference() {
        FanPlane(fh, fd, 4);
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
    //%translate([0, 0, -fh*2+1]) import("../parts/fan_30mm.stl");
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
        translate([0, 0, CARTopZOffs+16.6]) rotate([0, 0, 90]) E3D_v5_temp(notTransparent=true);
    }
    CoreXY_FanDuct();
}

module FanDuct_InnerTor(cz, rad, diam, wall, smooth) {
    translate([0, 0, cz]) rotate_extrude(convexity=10) translate([rad, 0, 0]) circle(r=diam-wall, $fn=smooth);
}

module FanDuct_Tor(cz, rad, diam, wall, smooth, slice=false) {
    difference() {
        translate([0, 0, cz]) rotate_extrude(convexity=10) translate([rad, 0, 0]) circle(r=diam, $fn=smooth);
        color("Blue") FanDuct_InnerTor(cz, rad, diam, wall, smooth);
        if (slice) {
            color("Red") translate([0, 0, cz+rad/2]) cube([rad*3, rad*3, rad], center=true);
        }
    }
}

E3DBlowerZ=-30;

module CoreXY_FanDuct_Blower() {
    blowerZ=E3DBlowerZ;
    blowerFanZOffs=5.1;
    blowerFanXOffs=25;
    blowerEndHullZCoef=-7;
    blowerFanXAngl=-30.2;
    blowerRad=25;
    torDiam=6;
    bpnt=-torDiam*3+2;
    //render() 
    difference() {
        union() {
            FanDuct_Tor(blowerZ, blowerRad, torDiam, 1, 10);
            translate([blowerFanXOffs, 0, blowerZ+blowerFanZOffs]) rotate([blowerFanXAngl, 0, 90]) rotate([90]) FanHull(12, 4, 30, 4, 4, 8, 2, 0, 0, 0, -5, 1, 1, blowerEndHullZCoef, 1);
            mirror([1, 0, 0]) translate([blowerFanXOffs, 0, blowerZ+blowerFanZOffs]) rotate([blowerFanXAngl, 0, 90]) rotate([90]) FanHull(12, 4, 30, 4, 4, 8, 2, 0, 0, 0, -5, 1, 1, blowerEndHullZCoef, 1);
        }
        // Blower cooler 1 hole
        color("Blue") {
            FanDuct_InnerTor(blowerZ, blowerRad, torDiam, 1, 10);
            translate([blowerFanXOffs, 0, blowerZ+blowerFanZOffs]) rotate([blowerFanXAngl, 0, 90]) rotate([90]) FanInnerHull(12, 4, 30, 4, 4, 8, 2, 0, 0, 0, -5, 1, 1, blowerEndHullZCoef, 1);
            mirror([1, 0, 0]) translate([blowerFanXOffs, 0, blowerZ+blowerFanZOffs]) rotate([blowerFanXAngl, 0, 90]) rotate([90]) FanInnerHull(12, 4, 30, 4, 4, 8, 2, 0, 0, 0, -5, 1, 1, blowerEndHullZCoef, 1);
        }
        color("Red") FanDuct_Tor(blowerZ-2.1, blowerRad-5, torDiam+0.6, 1, 16, true);
    }
}

module CoreXY_FanDuct() {
    blowerZ=E3DBlowerZ;
    union() {
        rotate([0, 0, 90]) CoreXY_FanDuct_Blower();
        difference() {
            union() {
                translate([3, 0, blowerZ+20.9]) rotate([0, 0, 90]) rotate([90]) 
                    FanHull(42, 4, 30, 4, 4, 20, 4, 0, 0, 0, 5, 1, 1, -6, 1, false, false, 0.7);
                //color("Blue") translate([5, -20, blowerZ+4.75]) cube([17, 40, 3.4]);
            }
            color("Blue") translate([0, 0, blowerZ-30]) cylinder(d=E3Dv5RadDiam+0.3, h=100);
            color("Magenta") {
                translate([-7.4, -100, blowerZ+28.9]) cube([3, 200, 2.25]);
                translate([ 4.5, -100, blowerZ+28.9]) cube([3, 200, 2.25]);
            }
        }
    }
}

//CoreXY_Assembled_Carriage_FanDuct();
CoreXY_FanDuct();
