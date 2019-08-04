include <z-config.scad>
use <z.scad>
use <../../openscad/nema17.scad>

E3Dv5STDZOffset=-34.8;
E3Dv5ZOffset=E3Dv5STDZOffset-17;

module e3d_v5_temp(skipDims=true) {
    %translate([0, 0, E3Dv5ZOffset-CARTopZOffs]) rotate([0, 0, 90]) e3d_v5_stl();
    if (!skipDims) {
        color("Black") {
            z_dim_abs(0, 0, 69, 60, ox=38);
            z_dim_abs(0, 0, 50, 40, ox=19);
        }
    }
}

module car_e3d_v5_holder(withNut, vtH=16.6) {
    mdia=CARCentralHoleDiam-0.9;
    vzo=53;
    vbx=CARCentralHoleDiam+6;
    vby=CARCentralHoleDiam/3;
    vbz=8.9;
    xfd=2.8;
    ybd=-CARCentralHoleDiam/3.7;
    render()
    difference() {
        union() {
            translate([0, 0, E3Dv5ZOffset+56.7]) cylinder(h=vtH, d=mdia);
          //translate([-vbx/2, -vby, E3Dv5ZOffset+vzo]) cube([vbx, vby, vbz]);
          //translate([0, 0, E3Dv5ZOffset+vzo]) cylinder(h=vbz, d=vbx);
        }
        color("Red") {
            translate([0, 0, E3Dv5ZOffset+64]) cylinder(h=vtH, d=16);
            translate([-CARCentralHoleDiam, 0, E3Dv5ZOffset+52]) cube([CARCentralHoleDiam*2, CARCentralHoleDiam, vtH+6]);
            translate([ CARCentralHoleDiam/xfd, CARCentralHoleDiam, E3Dv5ZOffset+59.5]) rotate([90]) cylinder(d=3.05, h=CARCentralHoleDiam*2);
            translate([-CARCentralHoleDiam/xfd, CARCentralHoleDiam, E3Dv5ZOffset+59.5]) rotate([90]) cylinder(d=3.05, h=CARCentralHoleDiam*2);
            if (withNut) {
                translate([ CARCentralHoleDiam/xfd, ybd-4.9, E3Dv5ZOffset+59.5]) rotate([90]) scale([1, 1, 2]) nut("M3");
                translate([-CARCentralHoleDiam/xfd, ybd-4.9, E3Dv5ZOffset+59.5]) rotate([90]) scale([1, 1, 2]) nut("M3");
            }
            else {
                translate([ CARCentralHoleDiam/xfd, ybd, E3Dv5ZOffset+59.5]) rotate([90]) cylinder(d=6.1, h=5);
                translate([-CARCentralHoleDiam/xfd, ybd, E3Dv5ZOffset+59.5]) rotate([90]) cylinder(d=6.1, h=5);
            }
        }
        color("Blue") translate([0, 0, E3Dv5ZOffset-CARTopZOffs]) e3d_v5_rad(0.09, 0.4);
    }
}

module e3d_v5_clamp() {
    rotate([0, 0, 180]) car_e3d_v5_holder(false);
}

module fan_duct_30_1(clr="Green") {
    color(clr) rotate([0, 0, 90]) 
        translate([0, 16.5, E3Dv5ZOffset+30.8]) rotate([90, 0, 0]) 
            import("../parts/PM_E3D_V5_fan_holder.stl");
}

CARTopZBeg=21.5;
CARTopBaseCZ=6.7;
CARTopE3DHoleDia=16;

module car_top_middle() {
    render() 
    difference() {
        union() {
            translate([0, 0, CARTopZBeg]) linear_extrude(height=CARTopBaseCZ/2)
                polygon(points=[
                     [-16, 0]
                    ,[ 16, 0]
                    ,[ 16, 20]
                    ,[ 30, 20]
                    ,[ 30, -23.355]
                    ,[ 16, -38]
                    ,[-26.4, -38]
                    ,[-38, -15]
                    ,[-38, 15]
                    ,[-16, 15]
                    ]);
            car_e3d_v5_holder(true, 18);
        }
        // E3D hole
        translate([0, 0, E3Dv5ZOffset+64]) cylinder(h=200, d=CARTopE3DHoleDia);
        // M4 vert holes
        translate([ 25, 0, -75]) cylinder(h=200, d=4.2);
        translate([-25, 0, -75]) cylinder(h=200, d=4.2);
        // M3 vert holes
        translate([-8, -25, -75]) cylinder(h=200, d=3.2);
        translate([ 8, -25, -75]) cylinder(h=200, d=3.2);
    }
}

module car_top_enhanced_1() {
    render() difference() {
        union() {
            difference() {
                union() {
                    carriage_v12_direct();
                    translate([-16, -32, CARTopZBeg+CARTopBaseCZ/2]) cube([32, 32, CARTopBaseCZ/2]);
                }
                // Bottom slice
                translate([-150, -150, CARTopZBeg-2]) cube([300, 300, CARTopBaseCZ/2+2]);
                // E3D hole
                translate([0, 0, E3Dv5ZOffset+64]) cylinder(h=200, d=CARTopE3DHoleDia);
                // M3 vert bolt holes
                translate([-8, -25, CARTopZBeg+CARTopBaseCZ-5]) cylinder(h=30, d=6.5);
                translate([ 8, -25, CARTopZBeg+CARTopBaseCZ-5]) cylinder(h=30, d=6.5);
                // Side slice
                translate([-24, -35, CARTopZBeg+CARTopBaseCZ]) cube([32, 60, 20]);
                // Back slice 
                translate([-36, -39, CARTopZBeg+CARTopBaseCZ]) cube([100, 15, 10]);
            }
            translate([16, 0, CARTopZBeg+CARTopBaseCZ]) rotate([0, 0, 90]) rotate([90]) linear_extrude(height=14)
                polygon(points=[
                    [-38, 0]
                    ,[-22, 10]
                    ,[-16, 10]
                    ,[-16, -1]
                    ,[-38, -1]
                ]);
            // Thick side
            //translate([-38, 0, CARTopZBeg+CARTopBaseCZ]) rotate([0, 0, 90]) rotate([90]) linear_extrude(height=14)
                //polygon(points=[[-38, 0],[-22, 13],[-3.5, 13],[-3.5, -1],[-38, -1]]);
        }
        // Base slice
        translate([0, 50, CARTopZBeg+CARTopBaseCZ]) rotate([90]) linear_extrude(height=100)
            polygon(points=[
             [-20.7, 0]
            ,[ 16, 0]
            ,[ 16, 13.5]
            ,[-31, 13.5]
            ,[-31, 13]
            ,[-20.7, 3]
        ]);
        // Hatch slices
        translate([40.5, -48.5, -10]) rotate([0, 0, 46.2]) cube([50, 50, 120], center=true);
        translate([-53.9, -39, -10]) rotate([0, 0, 26.7]) cube([50, 50, 120], center=true);
        // Motor
        translate([-27, -54, CARTopZBeg+CARTopBaseCZ]) cube([43, 44, 44]);
    }
}

module car_top_enhanced(clr="MediumSeaGreen", rendStop=false, lendStop=true) {
    esbx=CARCX/2-4;
    eslbx=-CARCX/2;
    esby=27;
    esbz=CARTopZBeg+CARTopBaseCZ+11;
    color(clr) {
        car_top_enhanced_1();
        render() difference() {
            union() {
                translate([-36, -10, CARTopZBeg+CARTopBaseCZ]) cube([56, 6.5, 10]);
                if(rendStop) {
                    translate([esbx-9, esby-0.9, CARTopZBeg+CARTopBaseCZ/2+23]) rotate([0, 90, 0]) cylinder(d=11.8, h=5);
                    translate([esbx-9, esby-9, CARTopZBeg+CARTopBaseCZ/2]) cube([5, 14, 23]);
                }
                if(lendStop) {
                    translate([eslbx, esby-0.9, CARTopZBeg+CARTopBaseCZ/2+23]) rotate([0, 90, 0]) cylinder(d=11.8, h=5);
                    translate([eslbx, esby-16, CARTopZBeg+CARTopBaseCZ/2]) cube([5, 21, 23]);
                }
            }
            // E3D hole
            translate([0, 0, E3Dv5ZOffset+64]) cylinder(h=200, d=CARTopE3DHoleDia);
            translate([-21, 20, CARTopZBeg+CARTopBaseCZ+5.7]) rotate([90]) cylinder(d=3.8, h=50);
            translate([10, 20, CARTopZBeg+CARTopBaseCZ+5.7]) rotate([90]) cylinder(d=3.8, h=50);
            // Right endstop holes
            if(rendStop) {
                translate([esbx-20, esby-0.9, CARTopZBeg+CARTopBaseCZ/2+5.2]) rotate([0, 90, 0]) cylinder(d=3.2, h=30);
                translate([esbx-20, esby-0.9, CARTopZBeg+CARTopBaseCZ/2+23.5]) rotate([0, 90, 0]) cylinder(d=3.2, h=30);
                translate([esbx-14, esby-20.8, CARTopZBeg+CARTopBaseCZ/2+13.35]) cube([18, 14, 14+13.35]);
            }
            if(lendStop) {
                translate([eslbx-20, esby-0.9, CARTopZBeg+CARTopBaseCZ/2+5.2]) rotate([0, 90, 0]) cylinder(d=3.2, h=30);
                translate([eslbx-20, esby-0.9, CARTopZBeg+CARTopBaseCZ/2+23.5]) rotate([0, 90, 0]) cylinder(d=3.2, h=30);
                translate([eslbx-4, esby-20.8, CARTopZBeg+CARTopBaseCZ/2+16.3]) cube([18, 14, 14+13.35]);
            }
        }
    }
    if (rendStop) {
        %translate([esbx, esby-0.89, esbz]) rotate([-90]) opt_endstop();
    }
    if (lendStop) {
        %translate([eslbx-4, esby-0.89, esbz]) rotate([0, 0, 180]) rotate([-90]) opt_endstop();
    }
}

module x_endstop_term() {
    sbz=17.7;
    //render() 
    difference() {
        union() {
            hull() {
                translate([-XENDCX/2+5, XENDCY/2-25+5, XENDFullCZ]) cylinder(d=9, h=3);
                translate([-XENDCX/2+5, XENDCY/2-3, XENDFullCZ]) cylinder(d=9, h=3);
            }
            translate([-XENDCX/2+2.5, XENDCY/2-14.37, XENDFullCZ+2]) rotate([-7]) cube([5, 7, sbz-1]);
            translate([-XENDCX/2+2.5, XENDCY/2-8.9, XENDFullCZ+sbz]) rotate([0, 90, 0]) cylinder(d=7, h=5);
        }
        color("Red") {
            translate([-XENDCX/2+5, XENDCY/2-25+5, XENDFullCZ-3]) cylinder(d=3.1, h=10);
            translate([-XENDCX/2+5, XENDCY/2-3, XENDFullCZ-3]) cylinder(d=3.1, h=10);
            translate([-XENDCX/2-5, XENDCY/2-8.9, XENDFullCZ+sbz]) rotate([0, 90, 0]) cylinder(d=3.1, h=20);
        }
    }
}

module full_assemled_carriage() {
    %x_end_rods_check();
    color("Red") mirror([1, 0, 0]) translate([95, 0, 0]) x_endstop_term();
    %translate([115, -XENDCY/2, 10]) r_x_end();
    color("Red") translate([90, 0, 0]) x_endstop_term();
    // Каретка с хот-ендом
    carriage_v12(true, "MediumSeaGreen", drawE3D=false);
    e3d_v5_temp();
    color("Yellow") e3d_v5_clamp();
    color("Yellow") car_top_middle();
    car_top_enhanced("MediumSeaGreen", rendStop=true, lendStop=true);
    color("Yellow") translate([CARCX/2-2, 2, CARTopZBeg]) x_belt_clamp();
    // Motor
    //translate([-5.5, -50.2, CARTopZBeg+CARTopBaseCZ+N17Height/2+1.3]) rotate([0, -90, 0]) rotate([-90]) Nema17(N17Height, N17Width, N17ShaftDiameter, N17ShaftLength, N17FixingHolesInteraxis);
    // Fan ducts
    //fan_duct_30_1("Blue");
}

full_assemled_carriage();
