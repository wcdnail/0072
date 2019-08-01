include <z-config.scad>

//translate([0, 0, 0]) rotate([0, 0, 0])

ZmotorYC=BARYLen/2+10;
//ZrodHolderCenterOffset=(BEDProfLen*3)/ZrodHolderCX;
ZrodHolderCenterOffset=BEDProfLen/(ZrodHolderCX*2);
ZrodHolderDistToCenter=ZrodHolderCenterOffset+ZmotorCX/2+ZrodHolderCX/2;

BEDPlateCX=BEDProfLen+6.4;
BEDPlateCY=BEDProfLen;
BEDPlateCZ=3;

BEDZ=300;

module bed_rod_holders_alt(skipDims=false) {
    // Bed rod holders
    translate([ZaxisML8UUCY, ZmotorYC-ZrodHolderDistToCenter, BEDZ-ZaxisML8UUCZ]) rotate([0, 0, -90]) z_lmu88_holder(true);
    translate([ZaxisML8UUCY, ZmotorYC+ZrodHolderDistToCenter, BEDZ-ZaxisML8UUCZ]) rotate([0, 0, -90]) z_lmu88_holder(true);
    if(!skipDims) {
        color("Black") {
        }
    }
}

module bed_frame_alt(skipDims=false, profClr="Gainsboro") {
    frameXS=(BARXLen-BEDPlateCX)/2;
    frameYS=ZmotorYC-(BEDProfLen-BARCY)/2-BARCY;
    // Y bars
    translate([frameXS, ZmotorYC-BEDPlateCY/2, BEDZ-BARCZ/2]) rotate([-90, 0, 0]) profile_2020(BEDProfLen, profClr);
    translate([BARXLen-frameXS, ZmotorYC-BEDPlateCY/2, BEDZ-BARCZ/2]) rotate([-90, 0, 0]) profile_2020(BEDProfLen, profClr);
    // X bars
    //translate([frameXS+BEDXProfOffs/2, frameYS, BEDZ-BARCZ/2]) rotate([0, 90, 0]) profile_2020(BEDProfLen, profClr);
    //translate([frameXS+BEDXProfOffs/2, ZmotorYC+BEDProfLen/2+BARCY/2, BEDZ-BARCZ/2]) rotate([0, 90, 0]) profile_2020(BEDProfLen, profClr);
    /*
    if(!skipDims) {
        color("black") {
            x_dim_abs(BEDPlateCX+BARCX*2, BEDPlateCY, 0, 60, ox=ZmotorXC-BEDPlateCX/2-BARCX, oy=(BARYLen-BEDPlateCY)/2+BARCY/2, oz=BEDZ);
            x_dim_abs(BEDPlateCX, BEDPlateCY, 0, 40, ox=ZmotorXC-BEDPlateCX/2, oy=(BARYLen-BEDPlateCY)/2+BARCY/2, oz=BEDZ);
            y_dim_abs(0, BEDPlateCY, 0, -60, ox=ZmotorXC-BEDPlateCX/2-BEDYProfOffs, oy=-(BARYLen-BEDPlateCY)/2, oz=BEDZ);
            y_dim_abs(0, BEDProfLen-BARCY*2-BEDYProfOffs, 0, -40, ox=ZmotorXC-BEDPlateCX/2+BEDYProfOffs/2, oy=-(BARYLen-BEDPlateCY)/2, oz=BEDZ);
            y_dim_abs(0, BEDYProfOffs/2, 0, -80, ox=ZmotorXC-BEDPlateCX/2-BARCX, oy=-(BARYLen-BEDPlateCY)/2, oz=BEDZ, textLoc=DIM_OUTSIDE);
        }
    }
    */
}

module bed_v2_alt(skipDims=false, plateClr="Silver") {
    // Bed plate
    //color(plateClr) translate([ZmotorXC-BEDPlateCX/2, (BARYLen-BEDPlateCY)/2, BEDZ]) cube([BEDPlateCX, BEDPlateCY, BEDPlateCZ]);
    // Bed
    //color("White") translate([ZmotorXC-BEDCX/2, (BARYLen-BEDCY)/2, BEDZ+BEDSpringMinH]) cube([BEDCX, BEDCY, BEDCZ]);
    // Frame
    bed_frame_alt(skipDims);
    // Bed rod holders
    bed_rod_holders_alt(skipDims);
    translate([BARXLen, 0, 0]) mirror([1, 0, 0]) bed_rod_holders_alt(skipDims);
    if(!skipDims) {
        color("Black") {
        }
    }
}

module z_frame_half_alt(skipDims=false, withMotor=true) {
    // Motor
    if (withMotor) {
        translate([BARCX+1.15, ZmotorYC, 0]) rotate([0, 0, -90]) z_motor_c1(skipDims);
    }
    // Rod holder
    translate([ZrodHolderCY/2, ZmotorYC-ZrodHolderDistToCenter, 0]) rotate([0, 0, 90]) z_rod_holder(true);
    translate([ZrodHolderCY/2, ZmotorYC+ZrodHolderDistToCenter, 0]) rotate([0, 0, 90]) z_rod_holder(true);
    // Rods
    color("White") {
        translate([ZaxisML8UUCY, ZmotorYC-ZrodHolderDistToCenter, 0]) cylinder(d=8, h=RODZLen);
        translate([ZaxisML8UUCY, ZmotorYC+ZrodHolderDistToCenter, 0]) cylinder(d=8, h=RODZLen);
    }
    if(!skipDims) {
        color("Black") {
            // Motor
            if (withMotor) {
                y_dim_abs(0, ZmotorYC, BARCZ, -130);
                y_dim_abs(0, BARYLen-ZmotorYC, BARCZ, -130, ox=ZmotorYC);
                y_dim_abs(0, ZmotorYC-ZmotorCX/2, BARCZ, -110);
                y_dim_abs(0, BARYLen-ZmotorYC-ZmotorCX/2, BARCZ, -110, ox=ZmotorYC+ZmotorCX/2);
            }
            // Rod holder left
            y_dim_abs(0, ZmotorYC-ZrodHolderDistToCenter+ZrodHolderCX/2, BARCZ, -90);
            y_dim_abs(0, ZmotorYC-ZrodHolderDistToCenter, BARCZ, -70, rh=40);
            y_dim_abs(0, ZmotorYC-ZrodHolderDistToCenter-ZrodHolderCX/2, BARCZ, -50);
            // Rod holder right
            y_dim_abs(0, BARYLen-ZmotorYC-ZrodHolderDistToCenter+ZrodHolderCX/2, BARCZ, -90, ox=ZmotorYC+ZrodHolderDistToCenter-ZrodHolderCX/2);
            y_dim_abs(0, BARYLen-ZmotorYC-ZrodHolderDistToCenter, BARCZ, -70, lh=40, ox=ZmotorYC+ZrodHolderDistToCenter);
            y_dim_abs(0, BARYLen-ZmotorYC-ZrodHolderDistToCenter-ZrodHolderCX/2, BARCZ, -50, ox=ZmotorYC+ZrodHolderDistToCenter+ZrodHolderCX/2);
            // Rod Y middle
            x_dim_abs(ZrodHolderCY, 0, BARCZ, BARXLen/2, rh=100, oy=BARYLen/1.6);
            // Rod middle
            lrhBegX=ZmotorYC-ZrodHolderDistToCenter-ZrodHolderCX/2;
            rrhEndX=ZmotorYC+ZrodHolderDistToCenter+ZrodHolderCX/2;
            y_dim_abs(0, rrhEndX-lrhBegX, BARCZ, 130, ox=lrhBegX);
            y_dim_abs(0, rrhEndX-lrhBegX-ZrodHolderCX*2, BARCZ, 90, ox=lrhBegX+ZrodHolderCX);
            y_dim_abs(0, rrhEndX-lrhBegX-ZrodHolderCX, BARCZ, 110, ox=lrhBegX+ZrodHolderCX/2);
        }
    }
}

module z_frame_alt(skipDims=false) {
    h_frame_2020(skipDims);
    z_frame_half_alt(skipDims);
    translate([BARXLen, 0, 0]) mirror([1, 0, 0]) z_frame_half_alt(skipDims);
    if(!skipDims) {
        color("Black") {
        }
    }
}

z_frame_alt();
bed_v2_alt();