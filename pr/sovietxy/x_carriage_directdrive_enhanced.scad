include <z-config.scad>
use <z.scad>

module CoreXY_Direct_Drive_v2(clr="MediumSeaGreen", rendStop=false, lendStop=true, noMotorMount=false, noChainMount=false) {
    esbx=CARCX/2-4;
    eslbx=-CARCX/2;
    esby=27;
    esbz=CARTopZBeg+14.3;
    color(clr) {
        render()
        difference() {
            union() {
                CoreXY_Direct_Drive();
                // Chain mount
                if(!noChainMount) {
                    translate([16, -22, CARTopZBeg+CARTopBaseCZ/2+13]) cube([14, 18, 16]);
                }
                // Right clamp
                translate([16, 0, CARTopZBeg+CARTopBaseCZ]) rotate([0, 0, 90]) rotate([90]) linear_extrude(height=14)
                    polygon(points=[[-38, 0],[-22, 10],[-16, 10],[-16, -1],[-38, -1]]);

                if(rendStop) {
                    translate([esbx-9, esby-0.9, CARTopZBeg+23]) rotate([0, 90, 0]) cylinder(d=11.8, h=5);
                    translate([esbx-9, esby-9, CARTopZBeg]) cube([5, 14, 23]);
                }
                if(lendStop) {
                    translate([eslbx, esby-0.9, CARTopZBeg+23]) rotate([0, 90, 0]) cylinder(d=11.8, h=5);
                    translate([eslbx, esby-16, CARTopZBeg]) cube([5, 21, 23]);
                }
                if(rendStop && lendStop) {
                    translate([-35, 12, CARTopZBeg]) cube([65, 20, CARTopBaseCZ/2]);
                }
            }
            // E3D v5 enlarger
            translate([0, 0, E3Dv5ZOffset-CARTopZOffs+zE3Dv5HolderOffset]) E3D_v5_cylinders(0.09, 0.4);
            translate([0, 0, CARTopZOffs+26]) cylinder(d=16.1, h=50);
            // Chain mount
            if(!noChainMount) {
                translate([8, -15.7, CARTopZBeg+CARTopBaseCZ+21]) rotate([0, 90]) cylinder(h=30, d=4.4);
                translate([8, -8.1, CARTopZBeg+CARTopBaseCZ+21]) rotate([0, 90]) cylinder(h=30, d=4);
                translate([20, -15, CARTopZBeg+CARTopBaseCZ/2+12]) cube([4, 6, 50]);
                // Nuts
                translate([19, -15.7, CARTopZBeg+CARTopBaseCZ+21]) scale([3, 1, 1]) rotate([0, 90]) nut("M4");
                translate([19, -8.1, CARTopZBeg+CARTopBaseCZ+21]) scale([3, 1, 1]) rotate([0, 90]) nut("M3");
            }
            // Endstops holes
            if(rendStop) {
                translate([esbx-20, esby-0.9, CARTopZBeg+5.2]) rotate([0, 90, 0]) cylinder(d=3.2, h=30);
                translate([esbx-20, esby-0.9, CARTopZBeg+23.5]) rotate([0, 90, 0]) cylinder(d=3.2, h=30);
                translate([esbx-14, esby-20.8, CARTopZBeg+16.7]) cube([18, 14, 14+13.35]);
                // Nuts
                translate([esbx-6.6, esby-0.9, CARTopZBeg+5.2]) scale([3, 1, 1]) rotate([0, 90]) nut("M3");
                translate([esbx-6.6, esby-0.9, CARTopZBeg+23.5]) scale([3, 1, 1]) rotate([0, 90]) nut("M3");
            }
            if(lendStop) {
                translate([eslbx-20, esby-0.9, CARTopZBeg+5.2]) rotate([0, 90, 0]) cylinder(d=3.2, h=30);
                translate([eslbx-20, esby-0.9, CARTopZBeg+23.5]) rotate([0, 90, 0]) cylinder(d=3.2, h=30);
                translate([eslbx-4, esby-20.8, CARTopZBeg+19.7]) cube([18, 14, 14+13.35]);
                // Nuts
                translate([eslbx+10, esby-0.9, CARTopZBeg+5.2]) scale([3, 1, 1]) rotate([0, 90]) nut("M3");
                translate([eslbx+10, esby-0.9, CARTopZBeg+23.5]) scale([3, 1, 1]) rotate([0, 90]) nut("M3");
            }
            if(rendStop && lendStop) {
                // M3 vert holes
                translate([-8, 25, -75]) cylinder(h=200, d=3.2);
                translate([ 8, 25, -75]) cylinder(h=200, d=3.2);
                // Mid hole
                translate([0, 11, -75]) scale([2, 1.2, 1]) cylinder(h=200, d=16);
            }
            // Hatch slices
            translate([40.5, -48.5, -10]) rotate([0, 0, 46.2]) cube([50, 50, 120], center=true);
            translate([-53.9, -39, -10]) rotate([0, 0, 26.7]) cube([50, 50, 120], center=true);
        }
    }
    if (rendStop) {
        %translate([esbx, esby-0.89, esbz]) rotate([-90]) opt_endstop();
    }
    if (lendStop) {
        %translate([eslbx-4, esby-0.89, esbz]) rotate([0, 0, 180]) rotate([-90]) opt_endstop();
    }
}


// With chain mount
CoreXY_Direct_Drive_v2("MediumSeaGreen", rendStop=true, lendStop=true);
// No chain mount
//CoreXY_Direct_Drive_v2("MediumSeaGreen", rendStop=true, lendStop=true, noChainMount=true);
