include <../../openscad/libs/nutsnbolts/cyl_head_bolt.scad>
include <../../openscad/libs/nutsnbolts/materials.scad>
include <../../openscad/libs/temp/dimlines.scad>
include <bconf.scad>

// translate([0, 0, 0])
// rotate([0, 0, 0])

ZmotorCX=84.6;
ZmotorCY=42.3;
ZmotorHeight=20;

DIM_FONTSCALE=0.3;
DIM_LINE_WIDTH=0.2;

module x_dim(cx, cy, cz, offs=20, lh=6, rh=6) {
    color("black") {
        translate([-cx/2, -cy/2-offs, cz]) dimensions(cx);
        translate([-cx/2, -cy/2+lh/2, cz]) rotate([0, 0, -90]) line(offs+lh);
        translate([cx/2, -cy/2+rh/2, cz]) rotate([0, 0, -90]) line(offs+rh);
    }
}

module y_dim(cx, cy, cz, offs=20, lh=6, rh=6) {
    rotate([0, 0, 90]) x_dim(cy, cx, cz, offs, lh, rh);
}

module z_dim(cx, cy, cz, offs=20, lh=6, rh=6) {
    translate([0, 0, cz/2]) rotate([0, 90, 0]) x_dim(cz, cy, cx/2, offs, lh, rh);
}

module z_motor_cutted(skipDims=false) {
    difference() {
        translate([ZmotorCX/4, -ZmotorCX/4, 20]) 
            rotate([0, 0, 180]) rotate([180, 0, 0]) 
                import("printedparts/2xCoreXY_Z_Motor.stl");
        translate([0, -ZmotorCX/3, -9.9]) 
            cube([ZmotorCX+20, ZmotorCY+20, 20], center=true);
    }
    if(!skipDims) {
        translate([ZmotorCX/4, 0, 0]) x_dim(ZmotorCX/2, ZmotorCY, ZmotorHeight, 15, ZmotorCX/2+3);
        translate([-ZmotorCX/4+2, -ZmotorCY/4, 0]) y_dim(ZmotorCX/2, ZmotorCY/2, ZmotorHeight, 45);
        x_dim(ZmotorCX, ZmotorCY, ZmotorHeight, 25);
        y_dim(ZmotorCX, ZmotorCY, ZmotorHeight, 25, rh=ZmotorCX/2+3);
        z_dim(ZmotorCX, ZmotorCY, ZmotorHeight, 10);
    }
}

z_motor_cutted();
