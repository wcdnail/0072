include <z-config.scad>
use <../z-fan-duct-v5-30mm/z-fan-duct.scad>
use <../2x-fan-duct-e3d-v5/ya-v5-fan-duct.scad>
use <../x-carriage/x_carriage_mess.scad>
use <../x-carriage/x_carriage_directdrive_enhanced.scad>
use <../x-carriage/x_carriage_lda_v1.3.scad>
use <../x-carriage/x_endstop_term.scad>
use <../y-temp/y-end-stops.scad>

BEDZ=ZMax;

ShowDims=false;
ShowAll=true;
ShowProfiles=true;
ShowCoreXY=true;
ShowXAxis=true;
ShowXCar=true;
ShowBed=true;
ShowZ=true;
BedColor="White";
ShowTableSize=false;
ShowZFrameSize=false;
ShowTopFrameSize=false;

module Bed_Holders(skipDims=!ShowDims, newRodHolders=true) {
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

module Bed_Frame(skipDims=!ShowDims, profClr="Gainsboro") {
  if (ShowProfiles) {
    translate([ZmotorXC-BEDPlateCX/2, (BARYLen-BEDPlateCY)/2+BARCY/2, BEDZ-BARCZ/2]) rotate([0, 90, 0]) profile_2020(BEDProfLen, profClr);
    translate([ZmotorXC-BEDPlateCX/2, BARYLen-(BARYLen-BEDPlateCY)/2-BARCY/2, BEDZ-BARCZ/2]) rotate([0, 90, 0]) profile_2020(BEDProfLen, profClr);
    //translate([ZmotorXC-BEDPlateCX/2-BARCX/2, (BARYLen-BEDPlateCY)/2-BEDYProfOffs/2, BEDZ-BARCZ/2]) rotate([-90, 0, 0]) profile_2020(BEDProfLen, profClr);
    translate([ZmotorXC-BEDPlateCX/2+BARCX/2, (BARYLen-BEDPlateCY)/2+BARCY, BEDZ-BARCZ/2]) rotate([-90, 0, 0]) profile_2020(BEDProfileCY, profClr);
    translate([BARXLen-(ZmotorXC-BEDPlateCX/2+BARCX/2), (BARYLen-BEDPlateCY)/2+BARCY, BEDZ-BARCZ/2]) rotate([-90, 0, 0]) profile_2020(BEDProfileCY, profClr);
  }
  if(!skipDims) {
    color("black") {
      x_dim_abs(BEDPlateCX, BEDPlateCY, 0, 200, ox=ZmotorXC-BEDPlateCX/2, oy=(BARYLen-BEDPlateCY)/2+BARCY/2, oz=BEDZ);
      y_dim_abs(0, BEDPlateCY, 0, -30, ox=ZmotorXC-BEDPlateCX/2-BEDYProfOffs, oy=-(BARYLen-BEDPlateCY)/2, oz=BEDZ);
      y_dim_abs(0, BEDProfileCY, 0, -10, ox=ZmotorXC-BEDPlateCX/2+BEDYProfOffs/2, oy=-(BARYLen-BEDPlateCY)/2, oz=BEDZ);
    }
  }
}

module Bed_v2(skipDims=!ShowDims, plateClr="Silver", heaterClr=BedColor, newRodHolders=true) {
  if (ShowBed) { 
    // Bed plate
    color(plateClr) translate([ZmotorXC-BEDPlateCX/2, (BARYLen-BEDPlateCY)/2, BEDZ]) cube([BEDPlateCX, BEDPlateCY, BEDPlateCZ]);
    // Bed
    color(heaterClr) translate([ZmotorXC-BEDCX/2, (BARYLen-BEDCY)/2, BEDZ+BEDSpringMinH]) cube([BEDCX, BEDCY, BEDCZ]);
  }
  // Frame
  Bed_Frame(skipDims);
  if (ShowZ) {
    // Bed rod holders
    Bed_Holders(skipDims, newRodHolders);
    translate([0, BARYLen, 0]) mirror([0, 1, 0]) Bed_Holders(skipDims, newRodHolders);
  }
  if(!skipDims) {
    color("Black") {
    }
  }
}

module Bed_Table_sizes(center=true) {
  sx = center ? -BARXLen/2 : 0;
  sy = center ? -BARYLen/2 : 0;
  sz = 0;
  translate([sx, sy, sz]) {
    Bed_v2(false);
  }
}

module Z_Motor_Half(skipDims=!ShowDims, withMotor=true, withRods=true, newRodHolders=true, rodHolderBottom=false, drawMotor=true, transparentBars=false, shortRodHolders=false) {
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

module Bottom_Frame(skipDims=!ShowDims, withMotor=true, withRods=true, newRodHolders=true, rodHolderBottom=false, drawMotor=false, transparentBars=false, shortRodHolders=false) {
  if (ShowProfiles) {
    h_frame_2020(skipDims, transparentBars);
  }
  if (ShowZ) {
    Z_Motor_Half(skipDims, withMotor, withRods, newRodHolders, rodHolderBottom, drawMotor, transparentBars, shortRodHolders);
    translate([0, BARYLen, 0]) mirror([0, 1, 0]) Z_Motor_Half(skipDims, withMotor, withRods, newRodHolders, rodHolderBottom, drawMotor, transparentBars, shortRodHolders);
  }
}

// Z frame w/new holders
module Bottom_Frame_sizes(center=true) {
  sx = center ? -BARXLen/2 : 0;
  sy = center ? -BARYLen/2 : 0;
  sz = 0;
  translate([sx, sy, sz]) {
      Bottom_Frame(false, drawMotor=false, withRods=false);
  }
}

module Z_Endstop_Term() {
  cd=20;
  cz=4;
  translate([0, 0, BARCZ/2-3]) {
    difference() {
      union() {
        hull() {
          translate([0, 0, -11+cz]) rotate([0, 0, 30]) cylinder(d=cd, h=cz, $fn=24);
          translate([-cd/2, 9, -11+cz]) cube([cd, 2, cz]);
        }
        hull() {
          translate([0, 0, 13-cz]) rotate([0, 0, 30]) cylinder(d=cd, h=cz, $fn=24);
          translate([-cd/2, 9, 13-cz]) cube([cd, 2, cz]);
        }
        translate([10, 6, 13]) rotate([0, 0, 90]) rotate([0, 90, 0]) chamfer_cube([20, 20, 5], d=5, $fn=9);
      }
      color("Red") {
        translate([0, 0, -20]) cylinder(d=3, h=40);
        translate([20, 6, 13]) rotate([0, 0, -90]) rotate([0, 90, 0]) {
          translate([10, -20, -20]) cylinder(d=5.2, h=50);
          translate([10, -20, -2]) cylinder(d=9.4, h=5);
          //translate([10, -40+7, -20]) cylinder(d=4.2, h=50);
        }
      }
    }
    color("Black") translate([0, 0, -8]) cylinder(d=3, h=80);
  }
}

module Top_Frame(skipDims=!ShowDims, transparentBars=false) {
  if (ShowProfiles) {
    translate([0, 0, TOPFrameZ-BARCZ]) h_frame_2020(true);
  }
  translate([0, 0, TOPFrameZ]) Bottom_Frame(skipDims=true, withMotor=false, withRods=false, newRodHolders=true, shortRodHolders=true);
 
  if (false) {
    translate([0, 0, TOPFrameZ]) {
      translate([60, 0, 0.5]) rotate([0, 0, 90]) rotate([0, 90, 0]) Y_EndStop_Mount();
    }
    translate([92, 20.5, BEDZ-BARCZ]) Z_Endstop_Term();
  }
}

// Z frame w/old holders
module Top_Frame_sizes(center=true) {
  sx = center ? -BARXLen/2 : 0;
  sy = center ? -BARYLen/2 : 0;
  sz = 0;
  translate([sx, sy, sz]) {
    Bottom_Frame(skipDims=false, withMotor=false, withRods=false, newRodHolders=true, shortRodHolders=true);
  }
}

module Belt_6(itsY=false) {
  BPs=[N17Width/2, N17Width/2, 0];
  translate([0, 0, TOPFrameZ+BARCZ+28.9]) {
    Xl=-6.1;
    Yl=BARYLen-8;
    Xl2=-1.4;
    Yl2=BARYLen-3.6;
    Xr2=BARXLen-55;
    Yr2=BARYLen-19.2;
    Xr=Xr2+5.8 + (itsY ? 3.2 : 0);
    Yr=Yr2-5;
    translate(BPs+[0.2, 0, 0]) cylinder(d=22, h=15, $fn=16);
    hull() {
      translate(BPs+[BARXLen/2.5, BARYLen/2-22.45, 0]) cylinder(d=2, h=6);
      translate(BPs+[Xl+16, BARYLen/2-22.45, 0]) cylinder(d=2, h=6);
    }
    hull() {
      translate(BPs+[Xl+9.5, BARYLen/2-27.85, 0]) cylinder(d=2, h=6);
      translate(BPs+[Xl+9.5, -5, 0]) cylinder(d=2, h=6);
    }
    hull() {
      translate(BPs+[Xl+2, -5, 0]) cylinder(d=2, h=6);
      translate(BPs+[Xl+2, Yl, 0]) cylinder(d=2, h=6);
    }
    hull() {
      translate(BPs+[Xl2, Yl2, 0]) cylinder(d=2, h=6);
      translate(BPs+[Xr2, Yr2, 0]) cylinder(d=2, h=6);
    }
    hull() {
      translate(BPs+[Xr, Yr, 0]) cylinder(d=2, h=6);
      translate(BPs+[Xr, BARYLen/2-14, 0]) cylinder(d=2, h=6);
    }
    hull() {
      translate(BPs+[Xr-4, BARYLen/2-19.5, 0]) cylinder(d=2, h=6);
      translate(BPs+[Xr-BARXLen/2.5, BARYLen/2-19.5, 0]) cylinder(d=2, h=6);
    }
  }
}

// Assembly
module SovietXY_Asm(carx=0, cary=0, skipDims=false, withE3D=true, center=true) {
  sx = center ? -BARXLen/2 : 0;
  sy = center ? -BARYLen/2 : 0;
  sz = 0;
  translate([sx, sy, sz]) {
    if (ShowZ) {
      Bottom_Frame(rodHolderBottom=false, drawMotor=true);
    }
    Top_Frame(transparentBars=true);
    if (ShowCoreXY) {
      %translate([0, 0, TOPFrameZ+BARCZ]) CoreXY_Full(withE3D=withE3D, showXAxis=ShowXAxis, showCarriage=ShowXCar);
    }
    Bed_v2();
    if (true) {
      // X Belt
      %color("Blue", 0.7) Belt_6($fn=3);
      // Y Belt
      %color("Red", 0.7) translate([BARXLen, 0, 7]) mirror([1, 0, 0]) Belt_6(itsY=true, $fn=3);
    }
    if (!skipDims) {
      color("Black") {
      }
    }
  }
}

if (ShowAll) {
  SovietXY_Asm();
}
else if (ShowTableSize) {
  Bed_Table_sizes();
}
else if (ShowZFrameSize) {
  Bottom_Frame_sizes();
}
else if (ShowTopFrameSize) {
  Top_Frame_sizes();
}
else {
}
