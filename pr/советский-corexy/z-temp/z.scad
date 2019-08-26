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

module Belt_GT2_6(cx, cy, oz, sx=0, sy=0, clr=undef, pulleyAlpha=0.4, Yaxis=false, skipDims=true) {
  GT2H=1.5;
  GT2Z=6;
  // Pulley inner diameter & radius
  pid=11.8;
  pir=pid/2;
  // Mottor inner diameter & radius
  MotorInnerPulleyDiam=12;
  mid=MotorInnerPulleyDiam;
  mir=mid/2;
  // Pulley outter diameter
  pod=18;
  // Base points
  adjx=(Yaxis ? 3.5 : 0);
  adjt=(Yaxis ? 4 : 0);
  szd=3.2; // tail bend diam
  P0=[sx+adjt-35, sy-szd-2.3, oz];
  P1=[-cx/2+31.7+adjx, sy-9, oz];
  P2=[-cx/2+22.15, cy/2+10, oz];
  P3=[cx/2-35.35, cy/2-5.5, oz];
  P4=[cx/2-35.2+adjx, sy+9, oz];
  P5=[sx+adjt+31, sy-szd+2.3, oz];
  MP=[-(cx-N17Width)/2, -(cy-N17Width)/2, oz];
  // Belt
  pgt2r=pir+GT2H/2;  // pulley with GT2 radius
  mgt2r=mir+GT2H/2;  // motor with GT2 radius
  tcx=15;            // belt tail
  bccx=cx/2-66-sx;   // distance from carriage to 1st pulley
  bccy=cy/2-30-sy;   // distance to motor
  bpcy=cy-10;        // distance from motor to 2nd pulley
  bpcx=cx-56;        // distance from 2nd pulley to 3dr pulley
  bppy=bccy+16;      // distance from 3dr pulley to 4th
  bppx=bccx;         // distance from 4th pulley to carriage
  color(clr) {
    // Хвостик
    translate(P0-[tcx, szd+0.7, 0]) cube([tcx, GT2H, GT2Z]);
    translate(P0) linear_extrude(GT2Z) arc(270, 450, szd, GT2H);
    // От каретки к первой шпуле
    translate([P1[0], P1[1]+pir, P1[2]])
      linear_extrude(GT2Z) polygon(points=[[0, 0], [bccx, 0], [bccx, GT2H], [0, GT2H]]);
    translate(P1) linear_extrude(GT2Z) arc(90, 180, pgt2r, GT2H);
    // От первой шпули до мотора
    translate([P1[0]-(pir+GT2H), P1[1]-1, P1[2]])
      linear_extrude(GT2Z) polygon(points=[[0, 1], [mir/2-0.3-adjx, -bccy], [mir/2+GT2H-0.3-adjx, -bccy], [GT2H, 1]]);
    translate(MP) linear_extrude(GT2Z) arc(180, 360, mgt2r, GT2H);
    // От мотора до второй шпули 
    translate([P1[0]-(pir+GT2H)*2-GT2H/2-adjx, MP[1]-1, MP[2]])
      linear_extrude(GT2Z) polygon(points=[[-mir/2+0.35, 0], [-mir/2+GT2H+0.07, bpcy], [-mir/2+GT2H*2+0.07, bpcy], [-mir/2+GT2H+0.35, 0]]);
    translate(P2) linear_extrude(GT2Z) arc(90, 180, pgt2r, GT2H);
    // От второй шпули до третьей
    translate([P1[0]-pid+1-adjx, P2[1]+pir-GT2H, P2[2]]) 
      linear_extrude(GT2Z) polygon(points=[[0.3, GT2H], [bpcx, -14], [bpcx, -14+GT2H], [0.3, GT2H+GT2H]]);
    translate(P3) linear_extrude(GT2Z) arc(0, 90, pgt2r, GT2H);
    // От третьей до последней
    translate([P3[0]+pir, P3[1], P3[2]]) 
      linear_extrude(GT2Z) polygon(points=[[0, 0], [adjx+0.15, -bppy], [adjx+0.15+GT2H, -bppy], [GT2H, 0]]);
    translate(P4) linear_extrude(GT2Z) arc(270, 360, pgt2r, GT2H);
    // От последней до каретки 
    translate([P4[0], P4[1]-pir-GT2H, P4[2]]) 
      linear_extrude(GT2Z) polygon(points=[[0, 0], [-bppx, 0], [-bppx, GT2H], [0, GT2H]]);
    // Хвостик
    translate(P5-[0, szd+0.7, 0]) cube([tcx, GT2H, GT2Z]);
    translate(P5) linear_extrude(GT2Z) arc(90, 270, szd, GT2H);
  }
  if (!skipDims) {
    color("Black") {
      // От каретки к первой шпуле
      x_dim_abs(bccx, 0, oz, -100, 10, 10, P1[0]-1);
      y_dim_abs(0, (3.1415926/2)*pgt2r, oz, -50, 0, 0, ox=P1[1], oy=-P1[0]-pir-GT2H, textLoc=DIM_OUTSIDE);
      // От первой шпули до мотора
      y_dim_abs(0, bccy, oz, -60, 20, 20, ox=MP[1]-1, oy=-P1[0]-pir-GT2H);
      x_dim_abs((3.1415926)*(MotorInnerPulleyDiam/2), 0, oz, 50, 0, 0, MP[0]-MotorInnerPulleyDiam+2, -cy/2+20, textLoc=DIM_OUTSIDE);
      // От мотора до второй шпули 
      y_dim_abs(0, bpcy, oz, -80, 20, 20, ox=MP[1]-1, oy=-P2[0]-pir-GT2H);
      x_dim_abs((3.1415926/2)*pgt2r, 0, oz, -50, 0, 0, P2[0]-pgt2r+1, cy/2+20, textLoc=DIM_OUTSIDE);
      // От второй шпули до третьей
      x_dim_abs(bpcx, 0, oz, -60, 10, 10, P2[0], P3[1]);
      x_dim_abs((3.1415926/2)*pgt2r, 0, oz, -50, 0, 0, P3[0]-pgt2r+1, cy/2+20, textLoc=DIM_OUTSIDE);
      // От третьей до последней
      y_dim_abs(0, bppy, oz, 80, 20, 20, ox=P4[1]-1, oy=-P4[0]-pir-GT2H);
      y_dim_abs(0, (3.1415926/2)*pgt2r, oz, 50, 0, 0, ox=P4[1]-pir-GT2H, oy=-P4[0]-pir, textLoc=DIM_OUTSIDE);
      // От последней до каретки
      x_dim_abs(bppx, 0, oz, -100, 10, 10, ox=P4[1]+pir);
      // Размеры ремней
      beltLen=tcx*2 + (3.1415926)*(szd/2) +
      // От каретки к первой шпуле
      + bccx
      + (3.1415926/2)*pgt2r
      // От первой шпули до мотора
      + bccy
      + (3.1415926)*(MotorInnerPulleyDiam/2)
      // От мотора до второй шпули 
      + bpcy
      + (3.1415926/2)*pgt2r
      // От второй шпули до третьей
      + bpcx
      + (3.1415926/2)*pgt2r
      // От третьей до последней
      + bppy
      + (3.1415926/2)*pgt2r
      // От последней до каретки
      + bppx;

      translate([-cx/2+70, -cy/2+120, 0]) rotate([0, 0, 0]) scale(2) drawtext(str("1x GT2 belt length : ", beltLen, "mm"));
      translate([-cx/2+70, -cy/2+90, 0]) rotate([0, 0, 0]) scale(2) drawtext(str("2x GT2 belt length : ", beltLen*2, "mm"));
    }
  }
  // Pulleys & motor
  %color(clr, pulleyAlpha) {
    translate(P1) cylinder(d=pid, h=6);
    translate(P2) cylinder(d=pid, h=6);
    translate(P3) cylinder(d=pid, h=6);
    translate(P4) cylinder(d=pid, h=6);
    translate(MP) cylinder(d=mid, h=6);
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
    if (!skipDims) {
      color("Black") {
      }
    }
  }
  if (true) {
    beltZ=0;
    translate([0, 0, TOPFrameZ+BARCZ+28.9]) {
      Belt_GT2_6(BARXLen, BARYLen, 0, 0, 0, "Blue", skipDims=false);
      mirror([1, 0, 0]) Belt_GT2_6(BARXLen, BARYLen, 7, 0, 0, "Red", Yaxis=true);
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
