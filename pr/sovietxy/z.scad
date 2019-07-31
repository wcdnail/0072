include <bconf.scad>
use <../../openscad/nema17.scad>

ZmotorXC=BARXLen/2;
ZrodHolderCenterOffset=25;
ZrodHolderDistToCenter=ZrodHolderCenterOffset+ZmotorCX/2+ZrodHolderCX/2;

BEDYProfOffs=13;
BEDPlateCX=BEDProfLen;
BEDPlateCY=BEDProfLen-BEDYProfOffs;
BEDProfileCY=BEDPlateCY-BARCY*2;
BEDPlateCZ=3;

ZMin=ZaxisML8UUCZ+BARCZ*2;
ZMax=330;
BEDZ=ZMax;

module bed_rod_holders(skipDims=false) {
    // Bed rod holders
    translate([ZmotorXC-ZrodHolderDistToCenter, ZaxisML8UUCY, BEDZ-ZaxisML8UUCZ]) z_lmu88_holder(true);
    translate([ZmotorXC+ZrodHolderDistToCenter, ZaxisML8UUCY, BEDZ-ZaxisML8UUCZ]) z_lmu88_holder(true);
    translate([ZmotorXC, ZaxisML8UUCY, BEDZ]) z_transm_v2(true);
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

module bed_v2(skipDims=false, plateClr="Silver", heaterClr="Magenta") {
    // Bed plate
    color(plateClr) translate([ZmotorXC-BEDPlateCX/2, (BARYLen-BEDPlateCY)/2, BEDZ]) cube([BEDPlateCX, BEDPlateCY, BEDPlateCZ]);
    // Bed
    color(heaterClr) translate([ZmotorXC-BEDCX/2, (BARYLen-BEDCY)/2, BEDZ+BEDSpringMinH]) cube([BEDCX, BEDCY, BEDCZ]);
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

module z_frame_half(skipDims=false, withMotor=true, withRods=true, newRodHolders=true, rodHolderBottom=false, drawMotor=true, transparentBars=false) {
    // Motor
    if (withMotor) {
        translate([ZmotorXC, BARCY+1.15, 0]) z_motor_c1(skipDims);
        if (drawMotor) {
            translate([ZmotorXC, BARCY+1.15, -N17Height/2-5.3]) Nema17(N17Height, N17Width, N17ShaftDiameter, N17ShaftLength, N17FixingHolesInteraxis);
        }
    }
    // Rod holder
    hldrCX = (newRodHolders ? ZrodHolder2CX : ZrodHolderCX);
    hldrZO = (newRodHolders ? (rodHolderBottom ? -BARCZ : BARCZ) : 0);
    if (newRodHolders) {
        hldrRotY = (rodHolderBottom ? 0 : 180);
        hldrZOreal = (rodHolderBottom ? -BARCZ : BARCZ*2);
        translate([ZmotorXC-ZrodHolderDistToCenter, BARCY+1.05, hldrZOreal]) rotate([0, hldrRotY, 0]) z_rod_holder_new();
        translate([ZmotorXC+ZrodHolderDistToCenter, BARCY+1.05, hldrZOreal]) rotate([0, hldrRotY, 0]) z_rod_holder_new();
    }
    else {
        translate([ZmotorXC-ZrodHolderDistToCenter, ZrodHolderCY/2, 0]) rotate([0, 0, 180]) z_rod_holder(true);
        translate([ZmotorXC+ZrodHolderDistToCenter, ZrodHolderCY/2, 0]) rotate([0, 0, 180]) z_rod_holder(true);
    }
    // Rods
    if (withRods) {
        color("White") {
            translate([ZmotorXC-ZrodHolderDistToCenter, ZaxisML8UUCY, hldrZO+RODZUp]) cylinder(d=8, h=RODZLen);
            translate([ZmotorXC+ZrodHolderDistToCenter, ZaxisML8UUCY, hldrZO+RODZUp]) cylinder(d=8, h=RODZLen);
        }
        // Coupler
        color("White") {
            translate([ZmotorXC, ZaxisML8UUCY, hldrZO+10]) cylinder(d=18.5, h=25);
        }
        // Z screw
        color("DimGray") {
            translate([ZmotorXC, ZaxisML8UUCY, hldrZO+25]) cylinder(d=8, h=ZScrewLen);
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
            x_dim_abs(ZmotorXC-ZrodHolderDistToCenter+hldrCX/2, 0, BARCZ, 90);
            x_dim_abs(ZmotorXC-ZrodHolderDistToCenter, 0, BARCZ, 70, rh=40);
            x_dim_abs(ZmotorXC-ZrodHolderDistToCenter-hldrCX/2, 0, BARCZ, 50);
            // Rod holder right
            x_dim_abs(BARXLen-ZmotorXC-ZrodHolderDistToCenter+hldrCX/2, 0, BARCZ, 90, ox=ZmotorXC+ZrodHolderDistToCenter-hldrCX/2);
            x_dim_abs(BARXLen-ZmotorXC-ZrodHolderDistToCenter, 0, BARCZ, 70, lh=40, ox=ZmotorXC+ZrodHolderDistToCenter);
            x_dim_abs(BARXLen-ZmotorXC-ZrodHolderDistToCenter-hldrCX/2, 0, BARCZ, 50, ox=ZmotorXC+ZrodHolderDistToCenter+hldrCX/2);
            // Rod Y middle
            y_dim_abs(0, ZrodHolderCY, BARCZ, BARXLen/2, rh=100, oy=-BARXLen/2.5);
            // Rod middle
            lrhBegX=ZmotorXC-ZrodHolderDistToCenter-hldrCX/2;
            rrhEndX=ZmotorXC+ZrodHolderDistToCenter+hldrCX/2;
            x_dim_abs(rrhEndX-lrhBegX, 0, BARCZ, -130, ox=lrhBegX);
            x_dim_abs(rrhEndX-lrhBegX-hldrCX*2, 0, BARCZ, -90, ox=lrhBegX+hldrCX);
            x_dim_abs(rrhEndX-lrhBegX-hldrCX, 0, BARCZ, -110, ox=lrhBegX+hldrCX/2);
            // Hieghts
            z_dim_abs(0, 0, TOPFrameZ+BARCZ, 70);
            z_dim_abs(0, 0, TOPFrameZ, 30, ox=-hldrZO);
        }
    }
}

module z_frame(skipDims=false, withMotor=true, withRods=true, newRodHolders=true, rodHolderBottom=false, drawMotor=false, transparentBars=false) {
    h_frame_2020(skipDims, transparentBars);
    z_frame_half(skipDims, withMotor, withRods, newRodHolders, rodHolderBottom, drawMotor, transparentBars);
    translate([0, BARYLen, 0]) mirror([0, 1, 0]) z_frame_half(skipDims, withMotor, withRods, newRodHolders, rodHolderBottom, drawMotor);
}

module top_frame(skipDims=false, transparentBars=false) {
    translate([0, 0, TOPFrameZ-BARCZ]) h_frame_2020(true);
    translate([0, 0, TOPFrameZ]) z_frame(true, false, false, false);
}

// Z frame w/new holders
module bottom_frame_sizes() {
    z_frame(drawMotor=false, withRods=false);
}

// Z frame w/old holders
module top_frame_sizes() {
    z_frame(newRodHolders=false, withRods=false, withMotor=false);
}

// Assembly
module z_assembly(carx=0, cary=0, skipDims=false, withE3D=true) {
    z_frame(rodHolderBottom=false, drawMotor=true);
    top_frame(transparentBars=true);
    translate([0, 0, TOPFrameZ+BARCZ]) core_xy_frame(withE3D=withE3D);
    bed_v2();
    if(!skipDims) {
        color("Black") {
        }
    }
}

//bed_v2();
//bottom_frame_sizes();
//top_frame_sizes();
z_assembly();
//x_carriage_new_check();
