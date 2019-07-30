include <bconf.scad>
use <../../openscad/nema17.scad>

//translate([0, 0, 0]) rotate([0, 0, 0])

ZmotorXC=BARXLen/2;
//ZrodHolderCenterOffset=BEDCX/3.5;
ZrodHolderCenterOffset=20;
ZrodHolderDistToCenter=ZrodHolderCenterOffset+ZmotorCX/2+ZrodHolderCX/2;

BEDYProfOffs=13;
BEDPlateCX=BEDProfLen;
BEDPlateCY=BEDProfLen-BEDYProfOffs;
BEDProfileCY=BEDPlateCY-BARCY*2;
BEDPlateCZ=3;

BEDZ=200;

module bed_rod_holders(skipDims=false) {
    // Bed rod holders
    translate([ZmotorXC-ZrodHolderDistToCenter, ZaxisML8UUCY, BEDZ-ZaxisML8UUCZ]) z_lmu88_holder(true);
    translate([ZmotorXC+ZrodHolderDistToCenter, ZaxisML8UUCY, BEDZ-ZaxisML8UUCZ]) z_lmu88_holder(true);
    if(!skipDims) {
        color("Black") {
        }
    }
}

module bed_frame_v2(skipDims=false, profClr="Gainsboro") {
    translate([ZmotorXC-BEDPlateCX/2, (BARYLen-BEDPlateCY)/2+BARCY/2, BEDZ-BARCZ/2]) rotate([0, 90, 0]) profile_2020(BEDProfLen, profClr);
    translate([ZmotorXC-BEDPlateCX/2, BARYLen-(BARYLen-BEDPlateCY)/2-BARCY/2, BEDZ-BARCZ/2]) rotate([0, 90, 0]) profile_2020(BEDProfLen, profClr);
    //translate([ZmotorXC-BEDPlateCX/2-BARCX/2, (BARYLen-BEDPlateCY)/2-BEDYProfOffs/2, BEDZ-BARCZ/2]) rotate([-90, 0, 0]) profile_2020(BEDProfLen, profClr);
    translate([ZmotorXC-BEDPlateCX/2+BARCX/2, (BARYLen-BEDPlateCY)/2+BARCY, BEDZ-BARCZ/2]) rotate([-90, 0, 0]) profile_2020(BEDProfileCY, profClr);
    translate([BARXLen-(ZmotorXC-BEDPlateCX/2+BARCX/2), (BARYLen-BEDPlateCY)/2+BARCY, BEDZ-BARCZ/2]) rotate([-90, 0, 0]) profile_2020(BEDProfileCY, profClr);
    if(!skipDims) {
        color("black") {
            x_dim_abs(BEDPlateCX, BEDPlateCY, 0, 50, ox=ZmotorXC-BEDPlateCX/2, oy=(BARYLen-BEDPlateCY)/2+BARCY/2, oz=BEDZ);
            y_dim_abs(0, BEDPlateCY, 0, -30, ox=ZmotorXC-BEDPlateCX/2-BEDYProfOffs, oy=-(BARYLen-BEDPlateCY)/2, oz=BEDZ);
            y_dim_abs(0, BEDProfileCY, 0, -10, ox=ZmotorXC-BEDPlateCX/2+BEDYProfOffs/2, oy=-(BARYLen-BEDPlateCY)/2, oz=BEDZ);
        }
    }
}

module bed_v2(skipDims=false, plateClr="Silver") {
    // Bed plate
    color(plateClr) translate([ZmotorXC-BEDPlateCX/2, (BARYLen-BEDPlateCY)/2, BEDZ]) cube([BEDPlateCX, BEDPlateCY, BEDPlateCZ]);
    // Bed
    color("White") translate([ZmotorXC-BEDCX/2, (BARYLen-BEDCY)/2, BEDZ+BEDSpringMinH]) cube([BEDCX, BEDCY, BEDCZ]);
    // Frame
    bed_frame_v2(skipDims);
    // Bed rod holders
    bed_rod_holders(skipDims);
    translate([0, BARYLen, 0]) mirror([0, 1, 0]) bed_rod_holders(skipDims);
    if(!skipDims) {
        color("Black") {
        }
    }
}

module z_frame_half(skipDims=false, withMotor=true, withRods=true) {
    // Motor
    if (withMotor) {
        translate([ZmotorXC, BARCY+1.15, 0]) z_motor_c1(skipDims);
        translate([ZmotorXC, BARCY+1.15, -N17Height/2-5.3]) Nema17(N17Height, N17Width, N17ShaftDiameter, N17ShaftLength, N17FixingHolesInteraxis);
    }
    // Rod holder
    translate([ZmotorXC-ZrodHolderDistToCenter, ZrodHolderCY/2, 0]) rotate([0, 0, 180]) z_rod_holder(true);
    translate([ZmotorXC+ZrodHolderDistToCenter, ZrodHolderCY/2, 0]) rotate([0, 0, 180]) z_rod_holder(true);
    // Rods
    if (withRods) {
        color("White") {
            translate([ZmotorXC-ZrodHolderDistToCenter, ZaxisML8UUCY, 0]) cylinder(d=8, h=RODZLen);
            translate([ZmotorXC+ZrodHolderDistToCenter, ZaxisML8UUCY, 0]) cylinder(d=8, h=RODZLen);
        }
    }
    if(!skipDims) {
        color("Black") {
            // Motor
            if (withMotor) {
                x_dim_abs(ZmotorXC, 0, BARCZ, 130);
                x_dim_abs(BARXLen-ZmotorXC, 0, BARCZ, 130, ox=ZmotorXC);
                x_dim_abs(ZmotorXC-ZmotorCX/2, 0, BARCZ, 110);
                x_dim_abs(BARXLen-ZmotorXC-ZmotorCX/2, 0, BARCZ, 110, ox=ZmotorXC+ZmotorCX/2);
            }
            // Rod holder left
            x_dim_abs(ZmotorXC-ZrodHolderDistToCenter+ZrodHolderCX/2, 0, BARCZ, 90);
            x_dim_abs(ZmotorXC-ZrodHolderDistToCenter, 0, BARCZ, 70, rh=40);
            x_dim_abs(ZmotorXC-ZrodHolderDistToCenter-ZrodHolderCX/2, 0, BARCZ, 50);
            // Rod holder right
            x_dim_abs(BARXLen-ZmotorXC-ZrodHolderDistToCenter+ZrodHolderCX/2, 0, BARCZ, 90, ox=ZmotorXC+ZrodHolderDistToCenter-ZrodHolderCX/2);
            x_dim_abs(BARXLen-ZmotorXC-ZrodHolderDistToCenter, 0, BARCZ, 70, lh=40, ox=ZmotorXC+ZrodHolderDistToCenter);
            x_dim_abs(BARXLen-ZmotorXC-ZrodHolderDistToCenter-ZrodHolderCX/2, 0, BARCZ, 50, ox=ZmotorXC+ZrodHolderDistToCenter+ZrodHolderCX/2);
            // Rod Y middle
            y_dim_abs(0, ZrodHolderCY, BARCZ, BARXLen/2, rh=100, oy=-BARXLen/2.5);
            // Rod middle
            lrhBegX=ZmotorXC-ZrodHolderDistToCenter-ZrodHolderCX/2;
            rrhEndX=ZmotorXC+ZrodHolderDistToCenter+ZrodHolderCX/2;
            x_dim_abs(rrhEndX-lrhBegX, 0, BARCZ, -130, ox=lrhBegX);
            x_dim_abs(rrhEndX-lrhBegX-ZrodHolderCX*2, 0, BARCZ, -90, ox=lrhBegX+ZrodHolderCX);
            x_dim_abs(rrhEndX-lrhBegX-ZrodHolderCX, 0, BARCZ, -110, ox=lrhBegX+ZrodHolderCX/2);
        }
    }
}

module z_frame(skipDims=false, withMotor=true, withRods=true) {
    h_frame_2020(skipDims);
    z_frame_half(skipDims, withMotor, withRods);
    translate([0, BARYLen, 0]) mirror([0, 1, 0]) z_frame_half(skipDims, withMotor, withRods);
    if(!skipDims) {
        color("Black") {
        }
    }
}

module top_frame(skipDims=false) {
    translate([0, 0, RODZLen-BARCZ]) z_frame(true, false, false);
    translate([0, 0, RODZLen]) h_frame_2020(true);
}

z_frame();
//top_frame();
//bed_v2();
//z_lmu88_holder(false);
