include <../../../openscad/libs/nutsnbolts/cyl_head_bolt.scad>
include <../../../openscad/libs/nutsnbolts/materials.scad>
include <../../../openscad/libs/dim1/dimlines.scad>
include <../../../openscad/arc.scad>
use <../../../openscad/nema17.scad>
use <../../parts/chamfers.scad>

// OpenSCAD params...
$fn=64;

// Параметры отображения размеров
DIM_LINE_WIDTH=1;
DIM_FONTSCALE=1;

// Размеры линейных подшипников
LM8UUOutterDiam=16.15;
LM8UULen=25;

// Параметры стола
BEDProfLen=400;
BEDCX=330;
BEDCY=330;
BEDCZ=3;
BEDSpringMinH=20;
BEDSpringMaxH=25;

// Размеры держателей линейных подшипников
LM8UUHolderOD=4.8;
LM8UUCenterOffset=0.5;

// Базовые размеры профилей
BARCX=20;
BARCY=20;
BARCZ=20;

// Длины профилей
BARXLen=490;
BARYLen=450;

// Размеры гладких направляющих 
RODXYDiam=8;
RODZDiam=8;
XRODSDiff=50;

RODXLen=420;
RODYLen=405;
RODZLen=373;
RODZUp=-3;
TOPFrameZ=370;

// Размеры винтовой передачи 
ZScrewDiam=8;
ZScrewLen=310;
ZScrewHolderCX=60;

// Размеры "кровати"
BEDYProfOffs=13;
BEDPlateCX=BEDProfLen;
BEDPlateCY=BEDProfLen-BEDYProfOffs;
BEDProfileCY=BEDPlateCY-BARCY*2;
BEDPlateCZ=3;

// Параметры каретки X
CARCX=76;
CARCY=76;
CARBaseCZ=3;
CARFullCZ=15.5;

// Смещение по Z относительно STL модели E3D
CARZE3DOffs=-19.5;             

CARXE=2.5;                      // Длина передней стенки 
CAR2CX=CARCX+CARXE*2;           // Новая длина каретки

CARTopZOffs=3.5;
CARVBoltHoleCenterOffs=-6;

CARTopZBeg=21.5;
CARTopBaseCZ=6.7;
CARTopE3DHoleDia=16;

// Параметры X терминала
XENDCX=50;
XENDCY=70;
XENDFullCZ=21.5;

ZmotorCX=84.6;
ZmotorCY=42.3;
ZmotorHeight=20;

// Z carriage
ZaxisML8UUCX=64;
ZaxisML8UUCY=21.2;
ZaxisML8UUCZ=57;
ZaxisM5HoleCX=49;

// Z axis holders
ZrodHolderCX=62.24;
ZrodHolderCY=21.15;
ZrodHolderCZ=20;
ZrodHolderClampCX=34;

ZrodHolder2CX=60;
ZrodHolder2CY=50;
ZrodHolder2CZ=20;
ZrodHolder2ClampCX=49;

N17Height=40;
N17Width=42;
N17ShaftDiameter=5;
N17ShaftLength=28;
N17FixingHolesInteraxis=31;

E3DnoLiftDown=true;
ZMin=80;
ZMax=E3DnoLiftDown ? 306 : 320;

ZmotorXC=BARXLen/2;
ZrodHolderCenterOffset=25;
ZrodHolderDistToCenter=ZrodHolderCenterOffset+ZmotorCX/2+ZrodHolderCX/2;

// ---------------------------------------------------------------------------------------------------------------------
// E3Dv5

E3Dv5RadDiam=25;

zE3Dv5HolderOffset=22;
E3Dv5STDZOffset=-34.8;
E3Dv5ZOffset=E3Dv5STDZOffset-17;

module E3D_v5_cylinders(enlarger=0, innerEnlarger=0.2, drawOnlyHolder=false, lchDia=0) {
    bz=19.3+enlarger;
    largeDia=E3Dv5RadDiam+enlarger;
    largeH=31.8;
    thrH=8;
    thrDia=9;
    hldDia=12+enlarger;
    hldrBottomH=6.8;
    hldrOutterDia=16+enlarger;
    hldrInnerH=9;
    hldrInnerDia=12+enlarger+innerEnlarger;
    hldrTopH=3.7;
    translate([0, 0, 0]) union() {
        if(!drawOnlyHolder) {
            translate([0, 0, bz]) cylinder(h=largeH, d=largeDia);
            translate([0, 0, bz+largeH-1]) cylinder(h=thrH, d=thrDia);
        }
        translate([0, 0, bz+largeH+2.2-enlarger*2]) cylinder(h=hldrBottomH+enlarger*2, d=lchDia == 0 ? hldrOutterDia : lchDia);
        translate([0, 0, bz+largeH-1+hldrBottomH]) cylinder(h=hldrInnerH, d=hldrInnerDia);
        translate([0, 0, bz+largeH-1+hldrBottomH+hldrInnerH-0.2-enlarger*2]) cylinder(h=hldrTopH+enlarger*2, d=hldrOutterDia);
    }
}

module E3D_v5_stl() {
    translate([-12.5, -12.5, 0]) import("../../parts/E3D_v5_Hot_end.stl");
}

module E3D_v5_std_clamp() {
        difference() {
                translate([-16, 10, 26.85]) rotate([90]) import("../vulcanus-v1/CoreXY_Direct_Drive_Hotend_Clamp.stl");
                color("Red") {
                        cylinder(d=4, h=500);
                        translate([0, 0, -33]) E3D_v5_cylinders(0.2, 0.4);
                }
        }
}

module E3D_v5_temp(skipDims=true, notTransparent=false, clr="Gray", fitting=false) {
    if (notTransparent) {
        color(clr) translate([0, 0, E3Dv5ZOffset-CARTopZOffs-CARTopBaseCZ/2]) rotate([0, 0, 90]) E3D_v5_stl();
                if (fitting) {
                        color("White") translate([0, 0, 5]) import("../../parts/PC4-M10.stl");
                }
    }
    else {
        %translate([0, 0, E3Dv5ZOffset-CARTopZOffs-CARTopBaseCZ/2]) rotate([0, 0, 90]) E3D_v5_stl();
                if (fitting) {
                        %translate([0, 0, 5]) import("../../parts/PC4-M10.stl");
                }
    }
    if (!skipDims) {
        color("Black") {
            z_dim_abs(0, 0, 69, 60, ox=38);
            z_dim_abs(0, 0, 50, 40, ox=19);
        }
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// E3Dv6 

E3Dv6RadDiam=22.45;

module e3d_v6_rad() {
  E3DsradDiam=16;
  E3DradZBeg=18.74;
  E3DradCZ=26.01;
  E3DfullCZ=62.5;
  E3DsradCZ=7.05;
  E3DhldrCZ=5.85;
  E3DhldrDiam=12;
  translate([0, 0, E3DradZBeg]) cylinder(h=E3DradCZ, d=E3Dv6RadDiam);
  translate([0, 0, E3DradZBeg+E3DradCZ]) cylinder(h=E3DsradCZ, d=E3DsradDiam);
  translate([0, 0, E3DradZBeg+E3DradCZ+E3DsradCZ]) cylinder(h=E3DhldrCZ, d=E3DhldrDiam);
  translate([0, 0, E3DradZBeg+E3DradCZ+E3DsradCZ+E3DhldrCZ]) cylinder(h=E3DsradCZ/2+0.25, d=E3DsradDiam);
}

// ---------------------------------------------------------------------------------------------------------------------
// Размеры 

module x_dim_abs(cx, cy, cz, offs=20, lh=6, rh=6, ox=0, oy=0, oz=0, textLoc=DIM_CENTER) {
  translate([ox, oy-offs, oz+cz]) dimensions(cx, loc=textLoc);
  lly=offs<0 ? oy-(offs-2) : oy+lh-2;
  rly=offs<0 ? oy-(offs-2) : oy+rh-2;
  lrh=abs(offs);
  translate([ox, lly, oz+cz]) rotate([0, 0, -90]) line(lrh+lh);
  translate([ox+cx, rly, oz+cz]) rotate([0, 0, -90]) line(lrh+rh);
}

module x_dim(cx, cy, cz, offs=20, lh=6, rh=6, textLoc=DIM_CENTER) {
    x_dim_abs(cx, cy, cz, offs, lh, rh, -cx/2, -cy/2, 0, textLoc);
}

module y_dim(cx, cy, cz, offs=20, lh=6, rh=6, textLoc=DIM_CENTER) {
    rotate([0, 0, 90]) x_dim(cy, cx, cz, offs, lh, rh, textLoc);
}

module z_dim(cx, cy, cz, offs=20, lh=6, rh=6, textLoc=DIM_CENTER) {
    translate([0, 0, cz/2]) rotate([0, 90, 0]) x_dim(cz, cy, cx/2, offs, lh, rh, textLoc);
}

module y_dim_abs(cx, cy, cz, offs=20, lh=6, rh=6, ox=0, oy=0, oz=0, textLoc=DIM_CENTER) {
    rotate([0, 0, 90]) x_dim_abs(cy, cx, cz, offs, lh, rh, ox, oy, oz, textLoc);
}

module z_dim_abs(cx, cy, cz, offs=20, lh=6, rh=6, ox=0, oy=0, oz=0, textLoc=DIM_CENTER) {
    translate([0, 0, cz]) rotate([0, 90, 0]) x_dim_abs(cz, cy, cx/2, offs, lh, rh, ox, oy, oz, textLoc);
}

// ---------------------------------------------------------------------------------------------------------------------

module opt_endstop() {
    translate([-10, -4.2, 0]) rotate([0, 0, 90]) rotate([90]) import("../../parts/optical_endstop_1.STL");
}

module x_rods(rod_d, bx, cx, by, cy, px = 0, py = 0) {
    xe_px=bx/2 + px;
    xe_py=by/2 + py;
    translate([(bx-cx)/2, xe_py - 25, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=rod_d);
    translate([(bx-cx)/2, xe_py - 25 + 50, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=rod_d);
}

module optical_endstop() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("../../parts/optical_endstop_1.stl");
}

module x_carriage_v5() {
    translate([-CARCX/2, -CARCY/2, 0]) rotate([0, 0, 0]) import("../vulcanus-v1/CoreXY_X-Carriage_E3D-V5.stl");
}

module x_belt_clamp() {
    translate([-2.5, -19, 0]) rotate([0, 0, 90]) rotate([90]) import("../vulcanus-v1/1xCoreXY_Belt_tensioner.stl");
}

module x_carriage_direct_drive() {
    translate([0, origCARWidth, 0]) rotate([180, 0, 0]) import("../vulcanus-v1/1xCoreXY_Direct_Drive.stl");
}

module e3d_v6_175() {
    translate([5.2, -2.5, 0]) rotate([0, 0, 0]) import("../../parts/E3D_v6_1.75mm_Universal.stl");
}

module l_x_end_top() {
    translate([0, 70, 11.1]) rotate([180, 0, 0]) import("../vulcanus-v1/2xCoreXY_X-End_Bolt.stl");
}

module l_x_end_bottom() {
    translate([0, 0, -10.2]) rotate([0, 0, 0]) import("../vulcanus-v1/2xCoreXY_X-End_Nut.stl");
}

module l_x_end() {
    l_x_end_bottom();
    l_x_end_top();
}

module x_carriage_1s_stl() {
    import("../x-carriage/x_carriage-16x25lm8uu.stl");
}

module x_carriage_1s_cutted_stl() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("../x-carriage/x_carriage-16x25lm8uu.stl");
}

module x_carriage_h1_boltholes_stl() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("../x-carriage/x_carriage-16x25lm8uu_holes.stl");
}

// ---------------------------------------------------------------------------------------------------------------------
// Ось Z

module z_motor_c1(skipDims=false, modelColor="SlateGray") {
    color(modelColor) render() {
        difference() {
            translate([ZmotorCX/4, -ZmotorCX/4, 20]) rotate([0, 0, 180]) rotate([180, 0, 0]) import("../vulcanus-v1/2xCoreXY_Z_Motor.stl");
            translate([0, -ZmotorCX/3, -9.9]) cube([ZmotorCX+20, ZmotorCY+20, 20], center=true);
        }
    }
    if(!skipDims) {
        color("black") {
            translate([ZmotorCX/4, 0, 0]) x_dim(ZmotorCX/2, ZmotorCY, ZmotorHeight, 15, ZmotorCX/2+3);
            translate([-ZmotorCX/4+2, -ZmotorCY/4, 0]) y_dim(ZmotorCX/2, ZmotorCY/2, ZmotorHeight, -65, textLoc=DIM_OUTSIDE);
            x_dim(ZmotorCX, ZmotorCY, ZmotorHeight, -ZmotorCY*1.5);
            y_dim(ZmotorCX, ZmotorCY, ZmotorHeight, 25, rh=ZmotorCX/2+3);
            z_dim(ZmotorCX, ZmotorCY, ZmotorHeight, 10);
        }
    }
}

module z_lmu88_holder(skipDims=false, middleOffs=0.05, modelColor="SlateGray") {
    color(modelColor) render() {
        translate([-17, -ZaxisML8UUCY/2-middleOffs, 3]) rotate([0, 0, -90]) rotate([0, -90, 0]) import("../vulcanus-v1/4xCoreXY_Z_Axis_LM8UU_Bolt.stl");
        translate([17, ZaxisML8UUCY/2+middleOffs, 3]) rotate([0, 0, 90]) rotate([0, -90, 0]) import("../vulcanus-v1/4xCoreXY_Z_Axis_LM8UU_Nut.stl");
    }
    if(!skipDims) {
        color("Black") {
            x_dim(ZaxisM5HoleCX, 0, ZaxisML8UUCZ+0.5, -25);
            x_dim(ZaxisML8UUCX, 0, ZaxisML8UUCZ-10, 30);
            x_dim_abs(ZaxisML8UUCX/2, 0, ZaxisML8UUCZ+0.5, 20);
            y_dim(ZaxisML8UUCX, ZaxisML8UUCY, ZaxisML8UUCZ, -(ZaxisML8UUCX+10), textLoc=DIM_OUTSIDE);
            y_dim_abs(ZaxisML8UUCX, ZaxisML8UUCY/2, ZaxisML8UUCZ, 45, textLoc=DIM_OUTSIDE);
            z_dim(ZaxisML8UUCX, 0, ZaxisML8UUCZ, 30);
            z_dim_abs(ZaxisML8UUCX, 0, ZaxisML8UUCZ-10, 20);
        }
    }
    /*
    // M5 bolts
    color("red") {
        translate([-ZaxisM5HoleCX/2, 0, ZaxisML8UUCZ-10]) rotate([90, 0, 0]) cylinder(d=5, h=30);
        translate([ ZaxisM5HoleCX/2, 0, ZaxisML8UUCZ-10]) rotate([90, 0, 0]) cylinder(d=5, h=30);
    }
    */
}

module z_rod_holder(skipDims=false, middleOffs=2.5, modelColor="SlateGray") {
    color(modelColor) render() {
        translate([ZrodHolderCX/2-9.85, ZrodHolderCY/2, 0]) rotate([0, 0, 180]) import("../vulcanus-v1/4xCoreXY_Z-Rodholder.stl");
        translate([ZrodHolderClampCX/2, -ZrodHolderCY+middleOffs, 0]) rotate([0, 0, 180]) rotate([90, 0, 0]) import("../vulcanus-v1/4xCoreXY_Z-Rodclamp.stl");
    }
    if(!skipDims) {
        color("Black") {
            x_dim(ZrodHolderCX, ZrodHolderCY, ZrodHolderCZ, 20);
            y_dim(ZrodHolderCX, ZrodHolderCY, ZrodHolderCZ, 20, lh=ZrodHolderCX, textLoc=DIM_OUTSIDE);
            z_dim(ZrodHolderCX, ZrodHolderCY, ZrodHolderCZ, 20);
        }
    }
}

module z_rod_holder_new(skipDims=false) {
    translate([ZrodHolder2CX/2, -41, -80]) rotate([90, 0, 0]) {
        color("Yellow") render() import("../vulcanus-v1/Z-Achsen Halter Oben.stl");
        color("Green") render() import("../vulcanus-v1/Z-Axis Clamp.stl");
    }
    if(!skipDims) {
        color("Black") {
        }
    }
}

module z_rod_holder_short_new(skipDims=true) {
    translate([ZrodHolder2CX/2, -41, -80]) rotate([90, 0, 0]) {
        color("Yellow") render() import("../vulcanus-v1/Z-Axis Holder.stl");
        color("Green") render() import("../vulcanus-v1/Z-Axis Clamp.stl");
                //color("Black") model_name("'Z-Axis Holder.stl' & 'Z-Axis Clamp.stl'");
    }
    if(!skipDims) {
        color("Black") {
            x_dim(ZrodHolder2CX, ZrodHolder2CY, ZrodHolder2CZ, 10);
            y_dim_abs(ZrodHolder2CX, ZrodHolder2CY/2+6, ZrodHolder2CZ, 50, ox=-ZrodHolder2CY/2+4, lh=ZrodHolder2CX/2+5, textLoc=DIM_OUTSIDE);
            z_dim(ZrodHolder2CX, ZrodHolder2CY, ZrodHolder2CZ, 10, lh=ZrodHolderCX, textLoc=DIM_OUTSIDE);
        }
    }
}

module z_transm_v2(skipDims=false, modelColor="SlateGray") {
    color(modelColor) render() translate([0, 10.5, 0]) rotate([0, 0, 180]) rotate([0, 90, 0]) import("../vulcanus-v1/TR8_Mutter.stl");
    if(!skipDims) {
        color("Black") {
        }
    }
}

module Z_LM8UU_Holder_16() {
    zhcx=50;
    zhcy=22.7;
    zhcz=48;
    translate([50+zhcx/2, 38.65+zhcy/2, zhcz]) rotate([0, 0, 180]) rotate([-90]) import("../vulcanus-v1/Z-Axis LM8uu Halter.stl");
}

module Z_LM8UU_hld(clr="Yellow") {
    sx=0;
    sy=0;
    sz=XENDFullCZ;
    ex=2.5;
    cx=LM8UULen+ex*2;
    bhy=CARCY/2.8;
    cy=bhy;
    bhz=LM8UUOutterDiam-3.5;
    bslicez=14.6;
    wsz=5;
    wz=6.7;
    rotate([0, 0, 90]) {
        translate([-(cx-ex*2)/2+0.69, -cy/2, cx]) rotate([0, 90, 0]) {
            color(clr) difference() {
                // Bearing holder
                color(clr) union() {
                    translate([0, -11.44, 12.2]) ChamferCyl(cx, 50, 10, 10);
                    translate([sx, sy, sz+0.6]) rotate([0, 90, 0])
                        linear_extrude(height=cx) polygon(points=[
                             [0, 0]
                            ,[CARBaseCZ, 0]
                            ,[CARBaseCZ+bhz, bhy/6]
                            ,[CARBaseCZ+bhz, bhy-bhy/7]
                            ,[CARBaseCZ, bhy]
                            ,[0, bhy]]);
                }
                // Linear bearing
                color("Red") {
                    translate([sx-LM8UULen+cx-ex, sy+cy/2, sz/2]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam, h=LM8UULen);
                    translate([sx-LM8UULen*1.5+cx-ex, sy+cy/2, sz/2]) rotate([0, 90, 0]) cylinder(d=RODXYDiam*1.3, h=LM8UULen*2);
                    translate([sx-LM8UULen/2+cx-ex, sy+cy/2, 0]) scale([1, 1, 0.7]) rotate([45, 0, 0]) cube([LM8UULen*2, LM8UULen, LM8UULen], center=true);
                }
                color("Blue") cube([CARCX*2, CARCY*2, bslicez], center=true);
                // Bolts
                color("Red") {
                    translate([10, -3.43, 0]) cylinder(h=30, d=6);
                    translate([10, 30.57, 0]) cylinder(h=30, d=6);
                    // Heads
                    translate([10, -3.43, 0]) cylinder(h=17, d=10);
                    translate([10, 30.57, 0]) cylinder(h=17, d=10);
                }
            }
            %translate([sx-LM8UULen+cx-ex, sy+cy/2, sz/2]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam, h=LM8UULen);
        }
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// Рама

module profile2020_quarter(h) {
    linear_extrude(height=h)
        polygon(points=[
             [-10, -10]
            ,[ -3, -10]
            ,[ -3,  -8]
            ,[ -6,  -8]
            ,[ -6,  -7]
            ,[ -3,  -4]
            ,[  0,  -4]
            ,[  0,   0]
            ,[ -4,   0]
            ,[ -4,  -3]
            ,[ -7,  -6]
            ,[ -8,  -6]
            ,[ -8,  -3]
            ,[-10,  -3]
            ]);
}

module profile_2020_raw(h) {
    render() {
        difference() {
            union() {
                rotate([0, 0,   0]) profile2020_quarter(h);
                rotate([0, 0,  90]) profile2020_quarter(h);
                rotate([0, 0, 180]) profile2020_quarter(h);
                rotate([0, 0, 270]) profile2020_quarter(h);
            }
            translate([0, 0, -2]) cylinder(d=5, h=h*1.4);
        }
    }
}

module profile_2020(h, transparentBars=false, profClr="Gainsboro") {
  color(profClr, transparentBars ? 0.5 : 1) profile_2020_raw(h);
}

module h_frame_half(skipDims=false, transparentBars=false, profClr="Gainsboro") {
    translate([-BARCX/2, 0, BARCZ/2]) rotate([-90, 0, 0]) profile_2020(BARYLen, transparentBars, profClr);
    translate([0, -BARCX/2, BARCZ/2]) rotate([0, 90, 0]) profile_2020(BARXLen, transparentBars, profClr);
    if(!skipDims) {
        color("black") {
            x_dim_abs(BARXLen, BARYLen, BARCZ, 300);
            y_dim_abs(BARXLen, BARYLen, BARCZ, -300);
        }
    }
}

module h_frame_2020(skipDims=false, transparentBars=false, profClr="Gainsboro") {
    h_frame_half(skipDims, transparentBars, profClr);
    translate([BARXLen, BARYLen, 0]) rotate([0, 0, 180]) h_frame_half(true, transparentBars, profClr);
}

module h_frame_2040(skipDims=false, profClr="Gainsboro") {
    h_frame_2020(skipDims, profClr);
    translate([0, 0, BARCZ]) h_frame_2020(skipDims, profClr);
}

// ---------------------------------------------------------------------------------------------------------------------
// Core XY

module l_x_end_top() {
    translate([0, 70, 11.1]) rotate([180, 0, 0]) import("../vulcanus-v1/2xCoreXY_X-End_Bolt.stl");
}

module l_x_end_bottom() {
    translate([0, 0, -10.2]) rotate([0, 0, 0]) import("../vulcanus-v1/2xCoreXY_X-End_Nut.stl");
}

module l_x_end_top_new(clr=undef, clra=undef) {
  color(clr, clra) translate([0, 0, 0.1]) rotate([0, 0, 0]) import("../x-carriage/x_end-bolts-16x25lm8uu.stl");
}

module l_x_end_bottom_new(clr=undef, clra=undef) {
  color(clr, clra) translate([0, 0, -11]) rotate([0, 0, 0]) import("../x-carriage/x_end-nuts-16x25lm8uu.stl");
}

module XY_Pulley(clra=0.5, pz=0, bz=40, noBoltHead=false) {
  // Bolt
  %translate([0, 0, -bz+pz+21]) color("DimGray", 0.99) {
    translate([31.7, 26, 0]) cylinder(h=bz, d=3.9);
        if (!noBoltHead) {
          translate([31.7, 26, bz]) cylinder(h=4, d=6.9);
        }
  }
  %color("Gainsboro", clra) translate([31.7, 26, 12 + pz]) {
    render() union() {
      cylinder(h=0.7, d=18);
          translate([0, 0, 0]) cylinder(h=8.4, d=12.6);
          translate([0, 0, 8.4-0.7]) cylinder(h=0.7, d=18);
        }
  }
}

module L_Pulley_Washer() {
  hdia=20;
  hcz=1.9;
  translate([0, 0, 10.8]) color("Red", 0.99) {
    difference() {
      union() {
        hull() {
          translate([31.7, 26, 0]) cylinder(h=hcz, d=hdia);
          translate([31.7, 26+18, 0]) cylinder(h=hcz, d=hdia);
        }
            translate([31.7, 26+18, 0]) cylinder(h=6, d1=19, d2=16);
            translate([31.7, 26+18, 5.99]) cylinder(h=2.9, d1=12, d2=10);
      }
          translate([31.7, 26, -1]) cylinder(h=20, d=4.2);
          translate([31.7, 26+18, -1]) cylinder(h=20, d=4.2);
        }
  }
}

module R_Pulley_Washer() {
  translate([0, XENDCY, 0]) rotate([0, 0, 180]) L_Pulley_Washer();
}

XYNutExtDiam=16.99;
XYNutBoltDiam=4.1;
XYNutTextXYScale=0.3;
XYNutTextScale=[XYNutTextXYScale, XYNutTextXYScale, 5];

module L_Pulley_Nut() {
  hdia=XYNutExtDiam;
  hcz=1.9;
  htop=hcz+6.9;
  translate([0, 0, 10.8]) {
    color("Lime", 0.7) difference() {
      union() {
            translate([31.7, 26, 0]) cylinder(h=hcz, d=hdia, $fn=6);
            translate([31.7, 26+18, 0]) cylinder(h=htop, d=hdia, $fn=6);
      }
          translate([31.7, 26, -1]) cylinder(h=20, d=XYNutBoltDiam);
          translate([31.7, 26+18, -1]) cylinder(h=20, d=XYNutBoltDiam);
          translate([31.7, 26+18, hcz+3.5]) scale([1.03, 1.03, 2]) rotate([180]) nut("M4");
      color("Black") {
        translate([28, 26, hcz-0.4]) rotate([0, 0, 60]) scale(XYNutTextScale) drawtext("E");
                translate([27.2, 26.5+18, htop-0.4]) rotate([0, 0, 60]) scale(XYNutTextScale) drawtext("E");
      }
        }
  }
}

module R_Pulley_Nut() {
  translate([0, XENDCY, 0]) rotate([0, 0, 180]) L_Pulley_Nut();
}

module R_Idler_Pulley_Nut(leftSide=false) {
  hdia=XYNutExtDiam;
  hcz=2.6;
  bncz=hcz + 6.99;
  h1=leftSide ? bncz : hcz;
  h2=leftSide ? hcz : bncz;
  translate([31.7, 26, 25.01]) color("Lime", 0.7) {
    difference() {
      union() {
                translate([-67.05, -51.5, 0]) cylinder(h=h1, d=hdia, $fn=6);
                translate([-53.85, -36, 0]) cylinder(h=h2, d=hdia, $fn=6);
      }
          translate([-67.05, -51.5, -1]) cylinder(h=20, d=XYNutBoltDiam);
          translate([-53.85, -36, -1]) cylinder(h=20, d=XYNutBoltDiam);
          if (leftSide) {
            translate([-67.05, -51.5, bncz-3.5]) scale([1.03, 1.03, 2]) rotate([180]) nut("M4");
          }
          else {
            translate([-53.85, -36, bncz-3.5]) scale([1.03, 1.03, 2]) rotate([180]) nut("M4");
          }
        }
  }
}

module L_Idler_Pulley_Nut() {
  translate([0, 0, 0]) mirror([1, 0, 0]) R_Idler_Pulley_Nut(leftSide=true);
}

module R_Idler_Pulley_Washer(leftSide=false) {
  hdia=20;
  hcz=2.6;
  translate([31.7, 26, 25.01]) color("Red", 0.99) {
    difference() {
      union() {
        hull() {
          translate([-67.05, -51.5, 0]) cylinder(h=hcz, d=hdia/2);
          translate([-53.85, -36, 0]) cylinder(h=hcz, d=hdia);
        }
                if (leftSide) {
                  translate([-67.05, -51.5, 0]) cylinder(h=6+3.6, d1=hdia/2, d2=hdia/2-0.5);
                }
                else {
                  translate([-53.85, -36, 0]) cylinder(h=6, d1=19, d2=16);
                  translate([-53.85, -36, 5.99]) cylinder(h=3.6, d1=12, d2=10);
                }
      }
          translate([-67.05, -51.5, -1]) cylinder(h=20, d=4.2);
          translate([-53.85, -36, -1]) cylinder(h=20, d=4.2);
        }
  }
}

module L_Idler_Pulley_Washer() {
  translate([0, 0, 0]) mirror([1, 0, 0]) R_Idler_Pulley_Washer(leftSide=true);
}

module l_x_end(clr=undef, clra=0.5, togglePulleys=false, showPulleys=true) {
  if (showPulleys) {
    shortBolt=33;
    longBolt=40;
    pulleyZOffs=0.72;
    pz1=togglePulleys?pulleyZOffs+7:pulleyZOffs;
    pz2=togglePulleys?pulleyZOffs:pulleyZOffs+7;
    bz1=togglePulleys ? longBolt : shortBolt;
    bz2=togglePulleys ? shortBolt : longBolt;
    XY_Pulley(clra, pz1, bz1);
    translate([0, 18, 0]) XY_Pulley(clra, pz2, bz2);
  }
  l_x_end_bottom_new(clr, clra);
  l_x_end_top_new(clr, clra);
}

module r_x_end(clr=undef, clra=0.5, showPulleys=true) {
  mirror([1, 0, 0]) l_x_end(clr, clra, togglePulleys=true, showPulleys=showPulleys);
}

module r_idler(clr=undef, clra=0.5, togglePulleys=false, showPulleys=true) {
  if (showPulleys) {
    shortBolt=21.5;
    longBolt=28.5;
    pulleyZOffs=15.72;
    pz1=togglePulleys?pulleyZOffs+7:pulleyZOffs;
    pz2=togglePulleys?pulleyZOffs:pulleyZOffs+7;
    bz1=togglePulleys ? longBolt : shortBolt;
    bz2=togglePulleys ? shortBolt : longBolt;
    translate([-67.05, -51.5, 0]) XY_Pulley(clra, pz1, bz1);
    translate([-53.85, -36, 0]) XY_Pulley(clra, pz2, bz2);
  }
  color(clr, clra) translate([0, 0, 0]) rotate([0, 0, 180]) import("../vulcanus-v1/1xCoreXY_Idler.stl");
}

module l_idler(clr=undef, clra=0.5, showPulleys=true) {
  translate([0, 0, 0]) mirror([1, 0, 0]) r_idler(clr, clra, true, showPulleys);
}

module r_motor(clr=undef, clra=undef) {
  color(clr, clra) translate([0, 0, 25]) rotate([180, 0, 180]) import("../vulcanus-v1/1xCoreXY_Motor.stl");
}
module l_motor(clr=undef, clra=undef) {
  mirror([1, 0, 0]) r_motor(clr, clra);
}

module CoreXY_Right_Y(by, cy, xe_pos, clr=undef, rodClr="White", cla=0.7) {
  translate([0, 0, 0]) r_motor(clr, cla);
  translate([0, by + BARCX, 0]) r_idler(clr, cla);
  translate([-3.5, xe_pos - XENDCY/2, 15]) r_x_end(clr, cla);
  translate([-21, cy + 43, 15]) rotate([90, 0, 0]) color(rodClr) cylinder(h=cy, d=8);
}

module CoreXY_Left_Y(by, cy, xe_pos, partClr=undef, rodClr="White", cla=0.7) {
  mirror([1, 0, 0]) {
    translate([0, 0, 0]) r_motor(partClr, cla);
    translate([-21, cy + 43, 15]) rotate([90, 0, 0]) color(rodClr) cylinder(h=cy, d=8);
  }
  translate([3.5, xe_pos - XENDCY/2, 15]) l_x_end(partClr, cla);
  translate([0, by + BARCX, 0]) l_idler(partClr, cla);
}

module x_carriage() {
    translate([-37.5, 37.5, 15.2]) rotate([180, 0, 0]) import("../vulcanus-v1/1xCoreXY_X-Carriage.stl");
}

module x_carriage_v5_std(carClr) {
    color(carClr) {
        rotate([180, 0, 0]) translate([-CARCX/2, -CARCY/2, -25]) import("../vulcanus-v1/CoreXY_X-Carriage_E3D-V5.stl");
        rotate([0, 0, 0]) translate([-CARCX/2, -CARCY/2, 25]) import("../vulcanus-v1/1xCoreXY_Direct_Drive.stl");
    }
    %translate([0, 0, 16.5]) rotate([0, 0, 90]) e3d_v6_175();
}

module x_end_rods_check(cx=RODXLen, clr=undef, cla=0.5, showPulleys=true) {
    translate([-120, -XENDCY/2, 10]) l_x_end(clr, cla, showPulleys=showPulleys);
    translate([-90,  XRODSDiff/2, XENDFullCZ/2-1]) rotate([0, 90, 0]) cylinder(d=RODXYDiam, h=cx);
    translate([-90, -XRODSDiff/2, XENDFullCZ/2-1]) rotate([0, 90, 0]) cylinder(d=RODXYDiam, h=cx);
}

CARCentralHoleDiam=E3Dv5RadDiam+1;

module XCar_Base_holes(centralHoles=true) {
    color("Red") {
                if (centralHoles) {
                        // E3D hole
                        translate([0, 0, XENDFullCZ-200]) cylinder(h=400, d=CARCentralHoleDiam);
                        // Wires holes
                        translate([ 0,  CARCY/2-20, XENDFullCZ-200]) cylinder(h=400, d=8);
                        translate([ 0,  CARCY/2-25, XENDFullCZ-100]) cube([8, 10, 300], center=true);
                }
        // M4 holes 
        translate([-CARCX/2+13, 0, XENDFullCZ-200]) cylinder(h=400, d=4.5);
        translate([ CARCX/2-13, 0, XENDFullCZ-200]) cylinder(h=400, d=4.5);
        // M4 nuts 
        translate([-CARCX/2+13, 0, XENDFullCZ-4]) scale([1, 1, 2]) nut("M4");
        translate([ CARCX/2-13, 0, XENDFullCZ-4]) scale([1, 1, 2]) nut("M4");
        // M3 holes
        translate([-8,  CARCY/2-13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([ 8,  CARCY/2-13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([-8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([ 8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        // M3 nuts
        translate([-8,  CARCY/2-13, XENDFullCZ-3.5]) scale([1.05, 1.05, 2]) rotate([0, 0, 30]) nut("M3");
        translate([ 8,  CARCY/2-13, XENDFullCZ-3.5]) scale([1.05, 1.05, 2]) rotate([0, 0, 30]) nut("M3");
        translate([-8, -CARCY/2+13, XENDFullCZ-3.5]) scale([1.05, 1.05, 2]) rotate([0, 0, 30]) nut("M3");
        translate([ 8, -CARCY/2+13, XENDFullCZ-3.5]) scale([1.05, 1.05, 2]) rotate([0, 0, 30]) nut("M3");
    }
}

module XCar_Base(clr="Yellow", drawE3D=true) {
        if (drawE3D) {
                %translate([0, 0, -1.85-CARTopZOffs]) rotate([0, 0, 90]) E3D_v5_temp();
        }
    color(clr) translate([-CAR2CX/2, -CARCY/2, XENDFullCZ-CARBaseCZ]) cube([CAR2CX, CARCY, CARBaseCZ]);
}

module XCar_LM8UU_Mnt(sz=XENDFullCZ) {
    bhy=CARCY/2.8;
    bhz=LM8UUOutterDiam-3.5;
    wsz=5;
    wz=wsz+2; //6.7;
    union() {
        translate([CARCX/2-LM8UULen-CARXE, CARCY/2-bhy, sz]) rotate([0, 90, 0])
            linear_extrude(height=LM8UULen+CARXE*2) polygon(points=[[0, 0],[CARBaseCZ, 0],[CARBaseCZ+bhz, bhy/6],[CARBaseCZ+bhz, bhy-bhy/7],[CARBaseCZ, bhy], [0, bhy]]);
        // Central block
        translate([-0.1, -0.1, sz-wsz]) cube([CARCX/4, CARCY/2-CARXE*2, wsz]);
        // Side block
        translate([-CARCX/2+5, -0.1, sz-wz]) cube([CARCX/2-4.9, CARCY/4-2, wz]);
        //translate([14, -0.1, sz-wz]) cube([26.5, CARCY/4, wz]);
    }
}

module XCar_LM8UU_PlaceHolder(sz=XENDFullCZ) {
    bslicez=14.6;
    union() {
        translate([CARCX/2-LM8UULen, XRODSDiff/2, sz/2]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam, h=LM8UULen);
        translate([CARCX/2-LM8UULen*1.5, XRODSDiff/2, sz/2]) rotate([0, 90, 0]) cylinder(d=RODXYDiam*1.3, h=LM8UULen*2);
        // Slice
        translate([CARCX/2-LM8UULen/2, XRODSDiff/2, 0]) scale([1, 1, 0.7]) rotate([45, 0, 0]) cube([LM8UULen*2, LM8UULen, LM8UULen], center=true);
        cube([CARCX*2, CARCY*2, bslicez], center=true);
    }
}

module XCar_LM8UU_Holder1(clr="Yellow") {
    sz=XENDFullCZ;
    color(clr) difference() {
        // Bearing mount
        XCar_LM8UU_Mnt(sz=sz);
        // Bearing place
        XCar_LM8UU_PlaceHolder(sz=sz);
    }
}

module car_lmu88_holder2(clr="Yellow") {
    translate([0, 0, -0.35]) XCar_LM8UU_Holder1(clr);
    translate([0, 0, -0.35]) mirror([0, 1, 0]) XCar_LM8UU_Holder1(clr);
}

module car_lmu88_holders_all(clr="Yellow") {
    car_lmu88_holder2(clr);
    mirror([1, 0, 0]) car_lmu88_holder2(clr);
}

module CoreXY_X_Carriage_v2(skipDims=false, carClr="Green", e3d=true) {
    difference() {
        union() {
            XCar_Base(carClr, e3d);
            car_lmu88_holders_all(carClr);
        }
        color("Magenta") XCar_Base_holes();
    }
    if(!skipDims) {
        color("black") {
            translate([0, 0, XENDFullCZ]) x_dim(CAR2CX, 0, 0, 100);
            translate([0, 0, XENDFullCZ]) y_dim(0, CARCY, 0, 100);
            translate([0, 0, XENDFullCZ-XENDFullCZ/2]) y_dim(0, XRODSDiff, 0, 80);
        }
    }
}

module CoreXY_X_Carriage_Full(skipDims=false, carClr="Green", e3d=true, withMotor=false) {
  CarZOffs=3.6;
  // Каретка с хот-ендом
  translate([0, 0, 21.5+CarZOffs]) rotate([180]) CoreXY_X_Carriage_v3_wLDA(true, "MediumSeaGreen", false);
  translate([0, 0, -2]) E3D_v5_temp(fitting=true);
  translate([0, 0, CarZOffs]) {
    translate([0, 0, 0.1]) CoreXY_Direct_Drive_v2("Yellow", rendStop=true, lendStop=true, renderBase=true, noChainMount=false);
    color("SteelBlue") translate([CARCX/2+2, 2, CARTopZBeg+0.2]) x_belt_clamp();
    if (withMotor) {
          translate([-5.5, -50.2, CARTopZBeg+CARTopBaseCZ+N17Height/2+4.5]) rotate([0, -90, 0]) rotate([-90]) Nema17(N17Height, N17Width, N17ShaftDiameter, N17ShaftLength, N17FixingHolesInteraxis);
    }
        if (false) {
          translate([90, 0, CarZOffs]) X_EndStop_Stand();
      mirror([1, 0, 0]) translate([95, 0, CarZOffs]) X_EndStop_Stand();
        }
    // Fan duct
    rotate([0, 0, 0]) YA_FanDuct_Full(61);
  }
}

module CoreXY_Direct_Drive(modelClr="Crimson") {
    color(modelClr) translate([0, 0, -CARTopZOffs]) rotate([0, 0, 180]) translate([-CARCX/2, -CARCY/2, 25]) import("../vulcanus-v1/1xCoreXY_Direct_Drive.stl");
}

module CoreXY_Full(bx=BARXLen, cx=RODXLen, by=BARYLen, cy=RODYLen, px=0, py=0, partClr="Green", rodClr="White", carClr="Green", withE3D=true, rAxis=true, lAxis=true, e3dClr="White", newCar=false, showXAxis=true, showCarriage=true) {
  xe_px=bx/2 + px;
  xe_py=by/2 + py;
  if (rAxis) {
    translate([bx, 0, 0]) CoreXY_Right_Y(by, cy, xe_py, partClr, rodClr);
  }
  if (lAxis) {
    translate([0, 0, 0]) CoreXY_Left_Y(by, cy, xe_py, partClr, rodClr);
  }
  /**/
  if (showXAxis) {
    color(rodClr) {
      translate([(bx-cx)/2, xe_py - 25, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=8);
      translate([(bx-cx)/2, xe_py - 25 + 50, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=8);
    }
  }
  if (showCarriage) {
    if (newCar) {
          translate([xe_px, xe_py, BARCZ+RODXYDiam/1.5]) x_carriage_new(carClr, withE3D, e3dClr);
    }
    else {
          translate([xe_px, xe_py, 0.6]) rotate([0, 0, 180]) CoreXY_X_Carriage_Full(true, carClr, false);
    }
  }
  /**/
}

module x_carriage_new_check(bx=BARXLen, cx=RODXLen, by=BARYLen, cy=RODYLen, px=0, py=0, rodClr="White", carClr="Crimson", withE3D=true) {
    core_xy_frame(bx, cx, by, cy, px, py, "None", rodClr, carClr, withE3D, false, false);
}

module x_carriage_check(bx=BARXLen, cx=RODXLen, by=BARYLen, cy=RODYLen, px=0, py=0, rodClr="White", carClr="Crimson", withE3D=true) {
    core_xy_frame(bx, cx, by, cy, px, py, "None", rodClr, carClr, withE3D, false, false, newCar=false);
}

// ---------------------------------------------------------------------------------------------------------------------
// Листы-перекрытия

module h_plane(h=3) {
    linear_extrude(height=h)
        polygon(points=[
             [0, -BARCY]
            ,[BARXLen, -BARCY]
            ,[BARXLen, 0]
            ,[BARXLen+BARCX, 0]
            ,[BARXLen+BARCX, BARYLen]
            ,[BARXLen, BARYLen]
            ,[BARXLen, BARYLen+BARCY]
            ,[0, BARYLen+BARCY]
            ,[0, BARYLen]
            ,[-BARCX, BARYLen]
            ,[-BARCX, 0]
            ,[0, 0]
            ]);
}

module Z_Plane_Holes_Half(newRodHolders=true) { 
    hldrCX = (newRodHolders ? ZrodHolder2CX : ZrodHolderCX);
    hldrZO = 0;
    hldrBD = 5.5;
    color("Red") {
        // Motor
        translate([ZmotorXC, ZaxisML8UUCY, -50]) cylinder(d=24, h=100);
        // Rods
        translate([ZmotorXC-ZrodHolderDistToCenter, ZaxisML8UUCY, -50]) cylinder(d=RODXYDiam, h=100);
        translate([ZmotorXC+ZrodHolderDistToCenter, ZaxisML8UUCY, -50]) cylinder(d=RODXYDiam, h=100);
        // Z rod holder bolts
        translate([ZmotorXC-ZrodHolderDistToCenter+17, ZaxisML8UUCY-31.2, -10]) cylinder(d=hldrBD, h=50);
        translate([ZmotorXC-ZrodHolderDistToCenter-17, ZaxisML8UUCY-31.2, -10]) cylinder(d=hldrBD, h=50);
        translate([ZmotorXC+ZrodHolderDistToCenter+17, ZaxisML8UUCY-31.2, -10]) cylinder(d=hldrBD, h=50);
        translate([ZmotorXC+ZrodHolderDistToCenter-17, ZaxisML8UUCY-31.2, -10]) cylinder(d=hldrBD, h=50);
    }
}

module Z_Plane_Holes_Sizes(newRodHolders=true, h=5) { 
    dimz = h + 1;
    hldrCX = (newRodHolders ? ZrodHolder2CX : ZrodHolderCX);
    hldrZO = 0;
    color("Black") {
        // Corner
        x_dim_abs(BARCX, 0, dimz, 40, rh=BARYLen, ox=-BARCX, textLoc=DIM_OUTSIDE);
        y_dim_abs(0, BARCY, dimz, -40, ox=-BARCX, rh=BARXLen, textLoc=DIM_OUTSIDE);
        // Motor
        x_dim_abs(ZmotorXC, 0, dimz, 180, rh=45);
        x_dim_abs(BARXLen-ZmotorXC, 0, dimz, 180, ox=ZmotorXC);
        // Motor CX
        x_dim_abs(ZmotorXC-ZmotorCX/2, 0, dimz, 160);
        x_dim_abs(BARXLen-ZmotorXC-ZmotorCX/2, 0, dimz, 160, ox=ZmotorXC+ZmotorCX/2);
        // Rod holder left
        x_dim_abs(ZmotorXC-ZrodHolderDistToCenter+hldrCX/2, 0, dimz, 140);
        x_dim_abs(ZmotorXC-ZrodHolderDistToCenter, 0, dimz, 100, rh=40);
        x_dim_abs(ZmotorXC-ZrodHolderDistToCenter-hldrCX/2, 0, dimz, 60);
        // Rod holder right
        x_dim_abs(BARXLen-ZmotorXC-ZrodHolderDistToCenter+hldrCX/2, 0, dimz, 140, ox=ZmotorXC+ZrodHolderDistToCenter-hldrCX/2);
        x_dim_abs(BARXLen-ZmotorXC-ZrodHolderDistToCenter, 0, dimz, 100, lh=40, ox=ZmotorXC+ZrodHolderDistToCenter);
        x_dim_abs(BARXLen-ZmotorXC-ZrodHolderDistToCenter-hldrCX/2, 0, dimz, 60, ox=ZmotorXC+ZrodHolderDistToCenter+hldrCX/2);
        // Rod Y middle
        y_dim_abs(0, ZrodHolderCY+BARCY, dimz, BARXLen/2, rh=100, ox=-BARCY, oy=-BARXLen/2.5, textLoc=DIM_OUTSIDE);
        // Bolts
        hlOffs=17;
        x_dim_abs(ZmotorXC-ZrodHolderDistToCenter-hlOffs, 0, dimz, 80, rh=30);
        x_dim_abs(ZmotorXC-ZrodHolderDistToCenter-hlOffs, 0, dimz, 80, lh=30, ox=ZmotorXC+ZrodHolderDistToCenter+hlOffs);
        x_dim_abs(ZmotorXC-ZrodHolderDistToCenter+hlOffs, 0, dimz, 120, rh=30);
        x_dim_abs(ZmotorXC-ZrodHolderDistToCenter+hlOffs, 0, dimz, 120, lh=30, ox=ZmotorXC+ZrodHolderDistToCenter-hlOffs);
        // Holes 
        lhlBegX=ZmotorXC-ZrodHolderDistToCenter-hlOffs;
        rhlEndX=ZmotorXC+ZrodHolderDistToCenter+hlOffs;
        x_dim_abs(rhlEndX-lhlBegX, 0, dimz, -100, ox=lhlBegX);
        x_dim_abs(rhlEndX-lhlBegX-hlOffs*4, 0, dimz, -60, ox=lhlBegX+hlOffs*2);
        // Rods & motor
        lrhBegX=ZmotorXC-ZrodHolderDistToCenter-hldrCX/2;
        rrhEndX=ZmotorXC+ZrodHolderDistToCenter+hldrCX/2;
        x_dim_abs(rrhEndX-lrhBegX-hldrCX, 0, dimz, -80, ox=lrhBegX+hldrCX/2);
    }
}


module Z_Plane(h=4, skipDims=false, newRodHolders=true, planeClr="Cyan") {
    difference() {
        color(planeClr) h_plane(h);
        Z_Plane_Holes_Half(newRodHolders);
        translate([0, BARYLen, 0]) mirror([0, 1, 0]) Z_Plane_Holes_Half(newRodHolders);
    }
    if(!skipDims) {
        dimz = h + 1;
        Z_Plane_Holes_Sizes(newRodHolders, h);
        translate([BARXLen, BARYLen, 0]) rotate([0, 0, 180]) Z_Plane_Holes_Sizes(newRodHolders, h);
        color("Black") {
            // Sides
            x_dim_abs(BARXLen+BARCX*2, 0, dimz, 200, ox=-BARCX);
            y_dim_abs(0, BARYLen+BARCY*2, dimz, -70, ox=-BARCX);
        }
    }
}

// ---------------------------------------------------------------------------------------------------------------------

XEndStopMountCX=5;
NutScaleInc=0.05;

module X_EndStop_Mount(esbx=CARCX/2-3, cx=XEndStopMountCX, clr=undef, clra=undef, noCon=false, flipTB=false) {
  eslbx=-CARCX/2;
  esby=27;
  esbz=CARTopZBeg+14.3;
  color(clr, clra) difference() {
    union() {
      hlcz=flipTB ? CARTopZBeg+6 : CARTopZBeg+22.5;
      hlkz=flipTB ? CARTopZBeg+12.5 : CARTopZBeg;
      hull() {
        //translate([esbx-cx-5, esby-1, hlcz]) rotate([0, 90, 0]) cylinder(d=13.8, h=cx, $fn=17);
        translate([esbx-cx-5, esby-6, hlcz]) cube([cx, 10, 6]);
        translate([esbx-cx-5, esby-8, hlkz]) cube([cx, 14, 20]);
      }
      // Шайбы
      translate([esbx-cx-0.2+1.8, esby-0.89, CARTopZBeg+5.15]) rotate([0, 90, 0]) cylinder(d=7, h=1.8);
      translate([esbx-cx-0.2+1.8, esby-0.89, CARTopZBeg+23.45]) rotate([0, 90, 0]) cylinder(d=7, h=1.8);
      if (!noCon) {
        // Connector
        translate([esbx-cx-5, esby-16, CARTopZBeg]) cube([cx, 22, 13]);
      }
    }
    // Holes
    translate([esbx-20, esby-0.89, CARTopZBeg+5.15]) rotate([0, 90, 0]) cylinder(d=3.2, h=30);
    translate([esbx-20, esby-0.89, CARTopZBeg+23.45]) rotate([0, 90, 0]) cylinder(d=3.2, h=30);
    // Nuts
    translate([esbx-cx-3, esby-0.9, CARTopZBeg+5.2]) scale([3, 1+NutScaleInc, 1+NutScaleInc]) rotate([0, 90]) nut("M3");
    translate([esbx-cx-3, esby-0.9, CARTopZBeg+23.5]) scale([3, 1+NutScaleInc, 1+NutScaleInc]) rotate([0, 90]) nut("M3");
  }
  //%translate([esbx, esby-0.89, esbz]) rotate([-90]) opt_endstop();
}

// ---------------------------------------------------------------------------------------------------------------------

module StandAlone_Fan_Duct_x2_40() {
  translate([97.47, -5.99, -53]) import("../../parts/fanduct-by-unix-remix/z-e3d-v5-fan-duct-40mm.stl");
}
