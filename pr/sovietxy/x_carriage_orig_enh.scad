include <z-config.scad>
use <z.scad>

//%x_end_rods_check();

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

// Каретка с хот-ендом
//carriage_v12(true, drawE3D=false);
//e3d_v5_temp();


//car_e3d_v5_holder(true);
//e3d_v5_clamp();
//fan_duct_30_1();

CARTopZBeg=21.5;
CARTopBaseCZ=6.7;
CARTopE3DHoleDia=16;

module car_top_middle() {
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

module car_top_enhanced() {
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
            translate([-38, 0, CARTopZBeg+CARTopBaseCZ]) rotate([0, 0, 90]) rotate([90]) linear_extrude(height=14)
                polygon(points=[
                     [-38, 0]
                    ,[-22, 13]
                    ,[-3.5, 13]
                    ,[-3.5, -1]
                    ,[-38, -1]
                ]);
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
    }
}


car_top_middle();
color("red") car_top_enhanced();
