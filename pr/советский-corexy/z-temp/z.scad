include <z-config.scad>
use <../z-fan-duct-v5-30mm/z-fan-duct.scad>
use <../x-carriage/x_carriage_mess.scad>
use <../x-carriage/x_carriage_directdrive_enhanced.scad>

BEDZ=ZMax;

module Bed_Holders(skipDims=false, newRodHolders=true) {
    // Bed rod holders
	NRHCX=50; // ZrodHolder2CX
	NRHCY=30;
    if (newRodHolders) {
        translate([ZmotorXC-ZrodHolderDistToCenter, ZaxisML8UUCY, BEDZ-NRHCY]) Z_LM8UU_hld($fn=64);
        translate([ZmotorXC+ZrodHolderDistToCenter, ZaxisML8UUCY, BEDZ-NRHCY]) Z_LM8UU_hld($fn=64);
    }
    else {
        translate([ZmotorXC-ZrodHolderDistToCenter, ZaxisML8UUCY, BEDZ-ZaxisML8UUCZ]) z_lmu88_holder(true);
        translate([ZmotorXC+ZrodHolderDistToCenter, ZaxisML8UUCY, BEDZ-ZaxisML8UUCZ]) z_lmu88_holder(true);
    }
    translate([ZmotorXC, ZaxisML8UUCY, BEDZ]) z_transm_v2(true);
        
    if(!skipDims) {
        hldrCX = (newRodHolders ? NRHCX : ZrodHolderCX);
        color("Black") {
            // Z screw
            x_dim_abs(BEDPlateCX/2, 0, BARCZ, 130, rh=40, ox=ZmotorXC-BEDPlateCX/2, oz=BEDZ-BARCZ);
            x_dim_abs(BEDPlateCX/2, 0, BARCZ, 130, rh=40, ox=ZmotorXC, oz=BEDZ-BARCZ);
            x_dim_abs((BEDPlateCX-ZScrewHolderCX)/2, 0, BARCZ, 110, rh=40, ox=ZmotorXC-BEDPlateCX/2, oz=BEDZ-BARCZ);
            x_dim_abs((BEDPlateCX-ZScrewHolderCX)/2, 0, BARCZ, 110, lh=40, ox=ZmotorXC+ZScrewHolderCX/2, oz=BEDZ-BARCZ);
            // Rod holder left
            x_dim_abs(ZrodHolderDistToCenter+3-hldrCX/2, 0, BARCZ, 70, rh=40, ox=ZmotorXC-BEDPlateCX/2, oz=BEDZ-BARCZ);
            x_dim_abs(ZrodHolderDistToCenter+3+hldrCX/2, 0, BARCZ, 90, rh=40, ox=ZmotorXC-BEDPlateCX/2, oz=BEDZ-BARCZ);
            // Rod holder right
            x_dim_abs(ZrodHolderDistToCenter+3-hldrCX/2, 0, BARCZ, 70, lh=40, ox=ZmotorXC+BEDPlateCX/2-(ZrodHolderDistToCenter+3-hldrCX/2), oz=BEDZ-BARCZ);
            x_dim_abs(ZrodHolderDistToCenter+3+hldrCX/2, 0, BARCZ, 90, lh=40, ox=ZmotorXC+BEDPlateCX/2-(ZrodHolderDistToCenter+3+hldrCX/2), oz=BEDZ-BARCZ);
        }
    }
}

module Bed_Frame(skipDims=false, profClr="Gainsboro") {
    translate([ZmotorXC-BEDPlateCX/2, (BARYLen-BEDPlateCY)/2+BARCY/2, BEDZ-BARCZ/2]) rotate([0, 90, 0]) profile_2020(BEDProfLen, profClr);
    translate([ZmotorXC-BEDPlateCX/2, BARYLen-(BARYLen-BEDPlateCY)/2-BARCY/2, BEDZ-BARCZ/2]) rotate([0, 90, 0]) profile_2020(BEDProfLen, profClr);
  //translate([ZmotorXC-BEDPlateCX/2-BARCX/2, (BARYLen-BEDPlateCY)/2-BEDYProfOffs/2, BEDZ-BARCZ/2]) rotate([-90, 0, 0]) profile_2020(BEDProfLen, profClr);
    translate([ZmotorXC-BEDPlateCX/2+BARCX/2, (BARYLen-BEDPlateCY)/2+BARCY, BEDZ-BARCZ/2]) rotate([-90, 0, 0]) profile_2020(BEDProfileCY, profClr);
    translate([BARXLen-(ZmotorXC-BEDPlateCX/2+BARCX/2), (BARYLen-BEDPlateCY)/2+BARCY, BEDZ-BARCZ/2]) rotate([-90, 0, 0]) profile_2020(BEDProfileCY, profClr);
    if(!skipDims) {
        color("black") {
            x_dim_abs(BEDPlateCX, BEDPlateCY, 0, 200, ox=ZmotorXC-BEDPlateCX/2, oy=(BARYLen-BEDPlateCY)/2+BARCY/2, oz=BEDZ);
            y_dim_abs(0, BEDPlateCY, 0, -30, ox=ZmotorXC-BEDPlateCX/2-BEDYProfOffs, oy=-(BARYLen-BEDPlateCY)/2, oz=BEDZ);
            y_dim_abs(0, BEDProfileCY, 0, -10, ox=ZmotorXC-BEDPlateCX/2+BEDYProfOffs/2, oy=-(BARYLen-BEDPlateCY)/2, oz=BEDZ);
        }
    }
}

module Bed_v2(skipDims=false, plateClr="Silver", heaterClr="Magenta", newRodHolders=true) {
    // Bed plate
    color(plateClr) translate([ZmotorXC-BEDPlateCX/2, (BARYLen-BEDPlateCY)/2, BEDZ]) cube([BEDPlateCX, BEDPlateCY, BEDPlateCZ]);
    // Bed
    color(heaterClr) translate([ZmotorXC-BEDCX/2, (BARYLen-BEDCY)/2, BEDZ+BEDSpringMinH]) cube([BEDCX, BEDCY, BEDCZ]);
    // Frame
    Bed_Frame(skipDims);
    // Bed rod holders
    Bed_Holders(skipDims, newRodHolders);
    translate([0, BARYLen, 0]) mirror([0, 1, 0]) Bed_Holders(skipDims, newRodHolders);
    if(!skipDims) {
        color("Black") {
        }
    }
}

module Z_Motor_Half(skipDims=false, withMotor=true, withRods=true, newRodHolders=true, rodHolderBottom=false, drawMotor=true, transparentBars=false, shortRodHolders=false) {
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
        if (shortRodHolders) {
            hldrZOreal = BARCZ;
            translate([ZmotorXC-ZrodHolderDistToCenter, BARCY+1.05, hldrZOreal]) rotate([0, hldrRotY, 0]) z_rod_holder_short_new();
            translate([ZmotorXC+ZrodHolderDistToCenter, BARCY+1.05, hldrZOreal]) rotate([0, hldrRotY, 0]) z_rod_holder_short_new();
        }
        else {
            hldrZOreal = (rodHolderBottom ? -BARCZ : BARCZ*2);
            translate([ZmotorXC-ZrodHolderDistToCenter, BARCY+1.05, hldrZOreal]) rotate([0, hldrRotY, 0]) z_rod_holder_new();
            translate([ZmotorXC+ZrodHolderDistToCenter, BARCY+1.05, hldrZOreal]) rotate([0, hldrRotY, 0]) z_rod_holder_new();
        }
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
                x_dim_abs(ZmotorXC, 0, BARCZ, 280);
                x_dim_abs(BARXLen-ZmotorXC, 0, BARCZ, 280, ox=ZmotorXC);
                x_dim_abs(ZmotorXC-ZmotorCX/2, 0, BARCZ, 260);
                x_dim_abs(BARXLen-ZmotorXC-ZmotorCX/2, 0, BARCZ, 260, ox=ZmotorXC+ZmotorCX/2);
            }
            // Rod holder left
            x_dim_abs(ZmotorXC-ZrodHolderDistToCenter+hldrCX/2, 0, BARCZ, 240);
            x_dim_abs(ZmotorXC-ZrodHolderDistToCenter, 0, BARCZ, 220, rh=40);
            x_dim_abs(ZmotorXC-ZrodHolderDistToCenter-hldrCX/2, 0, BARCZ, 200);
            // Rod holder right
            x_dim_abs(BARXLen-ZmotorXC-ZrodHolderDistToCenter+hldrCX/2, 0, BARCZ, 240, ox=ZmotorXC+ZrodHolderDistToCenter-hldrCX/2);
            x_dim_abs(BARXLen-ZmotorXC-ZrodHolderDistToCenter, 0, BARCZ, 220, lh=40, ox=ZmotorXC+ZrodHolderDistToCenter);
            x_dim_abs(BARXLen-ZmotorXC-ZrodHolderDistToCenter-hldrCX/2, 0, BARCZ, 200, ox=ZmotorXC+ZrodHolderDistToCenter+hldrCX/2);
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

module z_frame(skipDims=false, withMotor=true, withRods=true, newRodHolders=true, rodHolderBottom=false, drawMotor=false, transparentBars=false, shortRodHolders=false) {
    h_frame_2020(skipDims, transparentBars);
    Z_Motor_Half(skipDims, withMotor, withRods, newRodHolders, rodHolderBottom, drawMotor, transparentBars, shortRodHolders);
    translate([0, BARYLen, 0]) mirror([0, 1, 0]) Z_Motor_Half(skipDims, withMotor, withRods, newRodHolders, rodHolderBottom, drawMotor, transparentBars, shortRodHolders);
}

module top_frame(skipDims=false, transparentBars=false) {
    translate([0, 0, TOPFrameZ-BARCZ]) h_frame_2020(true);
    translate([0, 0, TOPFrameZ]) z_frame(skipDims=true, withMotor=false, withRods=false, newRodHolders=true, shortRodHolders=true);
}

// Z frame w/new holders
module bottom_frame_sizes(center=true) {
    sx = center ? -BARXLen/2 : 0;
    sy = center ? -BARYLen/2 : 0;
    sz = 0;
    translate([sx, sy, sz]) {
        z_frame(drawMotor=false, withRods=false);
    }
}

// Z frame w/old holders
module top_frame_sizes(center=true) {
    sx = center ? -BARXLen/2 : 0;
    sy = center ? -BARYLen/2 : 0;
    sz = 0;
    translate([sx, sy, sz]) {
        z_frame(skipDims=false, withMotor=false, withRods=false, newRodHolders=true, shortRodHolders=true);
    }
}

module table_sizes(center=true) {
    sx = center ? -BARXLen/2 : 0;
    sy = center ? -BARYLen/2 : 0;
    sz = 0;
    translate([sx, sy, sz]) {
        Bed_v2();
    }
}

// Assembly
module z_assembly(carx=0, cary=0, skipDims=false, withE3D=true, center=true) {
    sx = center ? -BARXLen/2 : 0;
    sy = center ? -BARYLen/2 : 0;
    sz = 0;
    translate([sx, sy, sz]) {
        z_frame(rodHolderBottom=false, drawMotor=true);
        top_frame(transparentBars=true);
        translate([0, 0, TOPFrameZ+BARCZ]) core_xy_frame(withE3D=withE3D);
        Bed_v2();
        if(!skipDims) {
            color("Black") {
            }
        }
    }
}

//table_sizes();
//bottom_frame_sizes();
//top_frame_sizes();
z_assembly();
