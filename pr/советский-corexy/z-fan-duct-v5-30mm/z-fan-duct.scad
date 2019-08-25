include <../z-temp/z-config.scad>
use <../z-temp/z.scad>
use <../x-carriage/x_carriage_directdrive_enhanced.scad>
use <../e3d-v5/e3d_v5_liftdown_adapter.scad>
use <../x-carriage/x_endstop_term.scad>
use <../../parts/fans.scad>

ShowAll=true;
E3DnoLiftDown=true;
E3DBottomPoint=-38.55;

module M3BoltMount(bz, bh, singleFan=false, noBolt=false) {
    sx=singleFan ? 19 : 25;
    sy=singleFan ? 25 : 19;
    difference() {
        translate([sx, sy, bz-0.1]) {
            hull() {
                translate([-8, -8, 0]) cube([5, 5, bh/1.2]);
                cylinder(d=10, h=bh/2);
                translate([0, 0, bh/2]) cylinder(d=6, h=bh/2+0.2);
            }
        }
        color("Red") {
            translate([sx, sy, bz+4]) { 
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
        %translate([sx, sy, bz+4]) { translate([0, 0, -0.1]) cylinder(d=3, h=30.1); translate([0, 0, -2]) cylinder(d=6, h=2); }
    }
}

module M3BoltMountAll(bz, bh, singleFan=false, noBolts=false) {
    M3BoltMount(bz, bh, singleFan, noBolts);
    mirror([0, 1, 0]) M3BoltMount(bz, bh, singleFan, noBolts);
    mirror([1, 0, 0]) {
        M3BoltMount(bz, bh, singleFan, noBolts);
        mirror([0, 1, 0]) M3BoltMount(bz, bh, singleFan, noBolts);
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
                        FanMount30(drawFan=false, $fn=64);
                        hull() {
                            translate([0, 0, -0.9]) ChamferCyl(32, 32, 2, 4, true, $fn=16);
                            translate([0, bzo, -17]) ChamferCyl(bsx, bz, 4, 4, true, $fn=16);
                        }
                    }
                    mirror([0, 0, 1]) M3BoltMountAll(sz+15, 8, singleFan=true, noBolts=true);
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

module Z_FanDuct(singleFan=false, blowerSlice=false, useAngle=true) {
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
    fy=useAngle ? 32.5 : 36;
    // Fan angle...
    fya=useAngle ? 45 : 0;
    fyo=useAngle ? -0.4 : 0;
    fzo=useAngle ? -3.4 : 0;
    fzo2=useAngle ? 3.9 : 0;
    fidia=32*0.89;
    // Blower fan
    translate([0, fy+fyo, fz+fzo]) rotate([fya]) rotate([-90]) FanMount30(6, drawFan=false, $fn=32);
    if(!singleFan) {
        mirror([0, 1, 0]) translate([0, fy+fyo, fz+fzo]) rotate([fya]) rotate([-90]) FanMount30(6, drawFan=false, $fn=32);
    }
    // Blower
    difference() {
        union() {
            BlowerImpl(by, bz, bh, bod, bid, bdc, tdc, $fn=64);
            // Fan 1
            translate([0, fy, fz]) rotate([-90]) hull() {
                translate([0, fzo2, -0.9]) rotate([fya]) ChamferCyl(32, 32, 2, 4, true, $fn=16);
                translate([0, 12, -11.5]) ChamferCyl(20, 8, 4, 4, true, $fn=16);
            }
            // Fan 2
            if(!singleFan) {
                mirror([0, 1, 0]) translate([0, fy, fz]) rotate([-90]) hull() {
                    translate([0, fzo2, -0.9]) rotate([fya]) ChamferCyl(32, 32, 2, 4, true, $fn=16);
                    translate([0, 12, -11.5]) ChamferCyl(20, 8, 4, 4, true, $fn=16);
                }
            }
            // Bolt mount
            M3BoltMountAll(bz, bh, singleFan, noBolts=blowerSlice);
        }
        color("DeepPink") {
            translate([0, 0, 1]) BlowerImpl(by, bz, bh-2, bod-bic, bid+bic, bdc, tdc, $fn=64);
            // Fan 1
            translate([0, fy, fz]) rotate([-90]) hull() {
                translate([0, fzo2, -0.9]) rotate([fya]) cylinder(d=fidia, h=4, $fn=32);
                translate([0, 12.9, -11.5]) ChamferCyl(20*0.8, 5*0.8, 4, 4, true, $fn=16);
            }
            // Fan 2
            if(!singleFan) {
                mirror([0, 1, 0]) translate([0, fy, fz]) rotate([-90]) hull() {
                    translate([0, fzo2, -0.9]) rotate([fya]) cylinder(d=fidia, h=4, $fn=32);
                    translate([0, 12.9, -11.5]) ChamferCyl(20*0.8, 5*0.8, 4, 4, true, $fn=16);
                }
            }
        }
        if (blowerSlice) {
            color("Red") translate([0, -50, -100]) cube([100, 100, 100]);
        }
        // Щель
        color("Magenta") {
            difference() {
                translate([0, 0, bz+10]) sphere(d=bod/1.1, $fn=64);
                translate([0, 0, bz+10]) sphere(d=bod/1.22, $fn=64);
                translate([0, 0, bz+bod/2+5]) cube([bod, bod, bod], center=true);
            }
        }
    }
}

module Z_Probe_Holder_Temp() {
    // Z sensor
    ZprobeCARXOffs=52;
    ZprobeCZ=4;
    %translate([ZprobeCARXOffs, 27, E3DBottomPoint+BlowerBottomOffset-2]) cylinder(h=70, d=18, $fn=32);
    union() {
        linear_extrude(height=ZprobeCZ) polygon(points=[[20, -10.2],[50, -10.2],[54, -6.2],[54, 30],[40, 30],[38, 28],[38, 10.2],[20, 10.2],[20, 5],[23, 2],[23, -2],[20, -5]]);
        translate([ZprobeCARXOffs, 27, 0]) cylinder(h=ZprobeCZ, d=22, $fn=12);
    }
}

if (ShowAll) {
  %Z_SinkFan();
  rotate([0, 0, 90]) Z_FanDuct(singleFan=false);
  translate([0, 0, CARTopZOffs+16.6]) E3D_v5_temp(notTransparent=true);
  %render() rotate([0, 0, -90]) CoreXY_X_Carriage_v2(true, "MediumSeaGreen", false);
}
else {
  Z_FanDuct(singleFan=false, blowerSlice=true);
}
