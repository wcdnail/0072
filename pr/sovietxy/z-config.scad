include <../../openscad/libs/nutsnbolts/cyl_head_bolt.scad>
include <../../openscad/libs/nutsnbolts/materials.scad>
include <../../openscad/libs/dim1/dimlines.scad>

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
ZScrewLen=330;
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

// Параметры X терминала
XENDCX=50;
XENDCY=70;
XENDFullCZ=21.5;

CARTopZOffs=3.5;
CARVBoltHoleCenterOffs=-6;

/*
carBaseXOffset=-CARXE;          // Смещение каретки по X
carYShrink=23;                  // Декремент ширины каретки
carCY=origCARWidth-carYShrink;
e3dBaseXOffset=12;              // Смещение E3D от центра по X
e3dBaseYOffset=15;              // Смещение E3D от центра по Y
e3dNutsYOffset=3;
carHNutSizeName="M3";           // Размер горизонтальных гаек
carHBoltHoleDiam=3.2;           // Диаметр горизонтальных отв.
carHBoltHeadDiam=7;             // Диаметр шляпки горизонтальных винтов
carHNutXScale=15;               // Масштаб горизонтальных гаек
carHBoltHeight=8.2;             // Смещение по Z горизонтальных гаек
carVNutSizeName="M4";           // Размер вертикальных гаек
carVBoltHoleDiam=4.2;

carBaseZOffset=0;               // Смещение базы каретки по Z 
*/

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

ZMin=ZaxisML8UUCZ+BARCZ*2;
ZMax=330;

ZmotorXC=BARXLen/2;
ZrodHolderCenterOffset=25;
ZrodHolderDistToCenter=ZrodHolderCenterOffset+ZmotorCX/2+ZrodHolderCX/2;

// ---------------------------------------------------------------------------------------------------------------------
// E3Dv5

E3Dv5RadDiam=25;

module e3d_v5_rad(enlarger=0, innerEnlarger=0.2) {
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
        translate([0, 0, bz]) cylinder(h=largeH, d=largeDia);
        translate([0, 0, bz+largeH-1]) cylinder(h=thrH, d=thrDia);
        translate([0, 0, bz+largeH+2.2-enlarger*2]) cylinder(h=hldrBottomH+enlarger*2, d=hldrOutterDia);
        translate([0, 0, bz+largeH-1+hldrBottomH]) cylinder(h=hldrInnerH, d=hldrInnerDia);
        translate([0, 0, bz+largeH-1+hldrBottomH+hldrInnerH-0.2-enlarger*2]) cylinder(h=hldrTopH+enlarger*2, d=hldrOutterDia);
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
    translate([-10, -4.2, 0]) rotate([0, 0, 90]) rotate([90]) import("../parts/optical_endstop_1.STL");
}

module x_rods(rod_d, bx, cx, by, cy, px = 0, py = 0) {
    xe_px=bx/2 + px;
    xe_py=by/2 + py;
    translate([(bx-cx)/2, xe_py - 25, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=rod_d);
    translate([(bx-cx)/2, xe_py - 25 + 50, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=rod_d);
}

module optical_endstop() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("../parts/optical_endstop_1.stl");
}

module x_carriage_v5() {
    translate([-CARCX/2, -CARCY/2, 0]) rotate([0, 0, 0]) import("printedparts/CoreXY_X-Carriage_E3D-V5.stl");
}

module x_belt_clamp() {
    translate([-2.5, -19, 0]) rotate([0, 0, 90]) rotate([90]) import("printedparts/1xCoreXY_Belt_tensioner.stl");
}

module x_carriage_direct_drive() {
    translate([0, origCARWidth, 0]) rotate([180, 0, 0]) import("printedparts/1xCoreXY_Direct_Drive.stl");
}

module e3d_v6_175() {
    translate([5.2, -2.5, 0]) rotate([0, 0, 0]) import("../parts/E3D_v6_1.75mm_Universal.stl");
}

module l_x_end_top() {
    translate([0, 70, 11.1]) rotate([180, 0, 0]) import("printedparts/2xCoreXY_X-End_Bolt.stl");
}

module l_x_end_bottom() {
    translate([0, 0, -10.2]) rotate([0, 0, 0]) import("printedparts/2xCoreXY_X-End_Nut.stl");
}

module l_x_end() {
    l_x_end_bottom();
    l_x_end_top();
}

module x_carriage_1s_stl() {
    import("x_carriage-16x25lm8uu.stl");
}

module x_carriage_1s_cutted_stl() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("x_carriage-16x25lm8uu.stl");
}

module x_carriage_h1_boltholes_stl() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("x_carriage-16x25lm8uu_holes.stl");
}

// ---------------------------------------------------------------------------------------------------------------------
// Ось Z

module z_motor_c1(skipDims=false, modelColor="SlateGray") {
    color(modelColor) render() {
        difference() {
            translate([ZmotorCX/4, -ZmotorCX/4, 20]) rotate([0, 0, 180]) rotate([180, 0, 0]) import("printedparts/2xCoreXY_Z_Motor.stl");
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
        translate([-17, -ZaxisML8UUCY/2-middleOffs, 3]) rotate([0, 0, -90]) rotate([0, -90, 0]) import("printedparts/4xCoreXY_Z_Axis_LM8UU_Bolt.stl");
        translate([17, ZaxisML8UUCY/2+middleOffs, 3]) rotate([0, 0, 90]) rotate([0, -90, 0]) import("printedparts/4xCoreXY_Z_Axis_LM8UU_Nut.stl");
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
        translate([ZrodHolderCX/2-9.85, ZrodHolderCY/2, 0]) rotate([0, 0, 180]) import("printedparts/4xCoreXY_Z-Rodholder.stl");
        translate([ZrodHolderClampCX/2, -ZrodHolderCY+middleOffs, 0]) rotate([0, 0, 180]) rotate([90, 0, 0]) import("printedparts/4xCoreXY_Z-Rodclamp.stl");
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
        color("Yellow") render() import("printedparts/Z-Achsen Halter Oben.stl");
        color("Green") render() import("printedparts/Z-Axis Clamp.stl");
    }
    if(!skipDims) {
        color("Black") {
        }
    }
}

module z_rod_holder_short_new(skipDims=true) {
    translate([ZrodHolder2CX/2, -41, -80]) rotate([90, 0, 0]) {
        color("Yellow") render() import("printedparts/Z-Axis Holder.stl");
        color("Green") render() import("printedparts/Z-Axis Clamp.stl");
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
    color(modelColor) render() translate([0, 10.5, 0]) rotate([0, 0, 180]) rotate([0, 90, 0]) import("printedparts/TR8_Mutter.stl");
    if(!skipDims) {
        color("Black") {
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
    if (transparentBars) {
        %profile_2020_raw(h);
    }
    else {
        color(profClr) profile_2020_raw(h);
    }
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
    h_frame_half(skipDims, profClr, transparentBars);
    translate([BARXLen, BARYLen, 0]) rotate([0, 0, 180]) h_frame_half(true, profClr, transparentBars);
}

module h_frame_2040(skipDims=false, profClr="Gainsboro") {
    h_frame_2020(skipDims, profClr);
    translate([0, 0, BARCZ]) h_frame_2020(skipDims, profClr);
}

// ---------------------------------------------------------------------------------------------------------------------
// Core XY

module l_x_end_top() {
    translate([0, 70, 11.1]) rotate([180, 0, 0]) import("printedparts/2xCoreXY_X-End_Bolt.stl");
}

module l_x_end_bottom() {
    translate([0, 0, -10.2]) rotate([0, 0, 0]) import("printedparts/2xCoreXY_X-End_Nut.stl");
}

module l_x_end_top_new() {
    translate([0, 0, 0.1]) rotate([0, 0, 0]) import("x_end-bolts-16x25lm8uu.stl");
}

module l_x_end_bottom_new() {
    translate([0, 0, -0.1]) rotate([0, 0, 0]) import("x_end-nuts-16x25lm8uu.stl");
}

module l_x_end() {
    //render() {
        l_x_end_bottom_new();
        l_x_end_top_new();
    //}
}

module r_x_end() {
    mirror([1, 0, 0]) l_x_end();
}

module r_idler() {
    translate([0, 0, 0]) rotate([0, 0, 180]) import("printedparts/1xCoreXY_Idler.stl");
}

module r_motor() {
    translate([0, 0, 25]) rotate([180, 0, 180]) import("printedparts/1xCoreXY_Motor.stl");
}

module r_y_axis(by, cy, xe_pos, partClr="SlateGray", rodClr="White") {
    color(partClr) {
        translate([0, 0, 0]) r_motor();
        translate([0, by + BARCX, 0]) r_idler();
        translate([-3.5, xe_pos - XENDCY/2, 14.5]) r_x_end();
    }
    translate([-21, cy + 43, 15]) rotate([90, 0, 0]) color(rodClr) cylinder(h=cy, d=8);
}

module l_y_axis(by, cy, xe_pos, partClr="SlateGray", rodClr="White") {
    mirror([1, 0, 0]) r_y_axis(by, cy, xe_pos, partClr, rodClr);
}

module x_carriage() {
    translate([-37.5, 37.5, 15.2]) rotate([180, 0, 0]) import("printedparts/1xCoreXY_X-Carriage.stl");
}

module x_carriage_v5_std(carClr) {
    color(carClr) {
        rotate([180, 0, 0]) translate([-CARCX/2, -CARCY/2, -25]) import("printedparts/CoreXY_X-Carriage_E3D-V5.stl");
        rotate([0, 0, 0]) translate([-CARCX/2, -CARCY/2, 25]) import("printedparts/1xCoreXY_Direct_Drive.stl");
    }
    %translate([0, 0, 16.5]) rotate([0, 0, 90]) e3d_v6_175();
}

module e3d_v5_stl() {
    translate([-12.5, -12.5, 0]) import("../parts/E3D_v5_Hot_end.stl");
}

module x_end_rods_check() {
    translate([-120, -XENDCY/2, 10]) l_x_end();
    translate([-90,  XRODSDiff/2, XENDFullCZ/2]) rotate([0, 90, 0]) cylinder(d=RODXYDiam, h=RODXLen);
    translate([-90, -XRODSDiff/2, XENDFullCZ/2]) rotate([0, 90, 0]) cylinder(d=RODXYDiam, h=RODXLen);
}

CARCentralHoleDiam=E3Dv5RadDiam+1;

module car_base_holes() {
    color("Red") {
        translate([0, 0, XENDFullCZ-200]) cylinder(h=400, d=CARCentralHoleDiam);
        translate([-CARCX/2+13, 0, XENDFullCZ-200]) cylinder(h=400, d=4.5);
        translate([ CARCX/2-13, 0, XENDFullCZ-200]) cylinder(h=400, d=4.5);
        translate([-8,  CARCY/2-13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([ 8,  CARCY/2-13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([-8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([ 8, -CARCY/2+13, XENDFullCZ-200]) cylinder(h=400, d=3.2);
        translate([ 0,  CARCY/2-20, XENDFullCZ-200]) cylinder(h=400, d=8);
        translate([ 0,  CARCY/2-25, XENDFullCZ-100]) cube([8, 10, 300], center=true);
        translate([-CARCX/2+13, 0, XENDFullCZ-4]) scale([1, 1, 2]) nut("M4");
        translate([ CARCX/2-13, 0, XENDFullCZ-4]) scale([1, 1, 2]) nut("M4");
    }
}

module car_base(drawE3D=true, clr="Yellow") {
	if (drawE3D) {
		%translate([0, 0, -51.8-CARTopZOffs]) rotate([0, 0, 90]) e3d_v5_stl();
	}
    color(clr) translate([-CAR2CX/2, -CARCY/2, XENDFullCZ-CARBaseCZ]) cube([CAR2CX, CARCY, CARBaseCZ]);
}

module car_lmu88_holder1(clr="Yellow") {
    sz=XENDFullCZ;
    bhy=CARCY/2.8;
    bhz=LM8UUOutterDiam-3.5;
    bslicez=14.6;
    wsz=5;
    wz=6.7;
    difference() {
        // Bearing holder
        color(clr) union() {
            translate([CARCX/2-LM8UULen-CARXE, CARCY/2-bhy, sz]) rotate([0, 90, 0])
                linear_extrude(height=LM8UULen+CARXE*2) polygon(points=[[0, 0],[CARBaseCZ, 0],[CARBaseCZ+bhz, bhy/6],[CARBaseCZ+bhz, bhy-bhy/7],[CARBaseCZ, bhy], [0, bhy]]);
            translate([-0.1, -0.1, sz-wsz]) cube([CARCX/4, CARCY/2-CARXE*2, wsz]);
            translate([16, -0.1, sz-wz]) cube([18, CARCY/4, wz]);
        }
        // Linear bearing
        color("Blue") {
            translate([CARCX/2-LM8UULen, XRODSDiff/2, sz/2]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam, h=LM8UULen);
            translate([CARCX/2-LM8UULen*1.5, XRODSDiff/2, sz/2]) rotate([0, 90, 0]) cylinder(d=RODXYDiam*1.3, h=LM8UULen*2);
            translate([CARCX/2-LM8UULen/2, XRODSDiff/2, 0]) scale([1, 1, 0.7]) rotate([45, 0, 0]) cube([LM8UULen*2, LM8UULen, LM8UULen], center=true);
            cube([CARCX*2, CARCY*2, bslicez], center=true);
        }
    }
}

module car_lmu88_holder2(clr="Yellow") {
    translate([0, 0, -0.35]) car_lmu88_holder1(clr);
    translate([0, 0, -0.35]) mirror([0, 1, 0]) car_lmu88_holder1(clr);
}

module car_lmu88_holders_all(clr="Yellow") {
    car_lmu88_holder2(clr);
    mirror([1, 0, 0]) car_lmu88_holder2(clr);
}

module carriage_v12(skipDims=false, carClr="Yellow", drawE3D=true) {
    color(carClr) render() difference() {
        union() {
            car_base(drawE3D);
            car_lmu88_holders_all();
        }
        color("Magenta") car_base_holes();
    }
    if(!skipDims) {
        color("black") {
            translate([0, 0, XENDFullCZ]) x_dim(CAR2CX, 0, 0, 100);
            translate([0, 0, XENDFullCZ]) y_dim(0, CARCY, 0, 100);
            translate([0, 0, XENDFullCZ-XENDFullCZ/2]) y_dim(0, XRODSDiff, 0, 80);
        }
    }
}

module carriage_v12_direct(modelClr="Crimson") {
    color(modelClr) translate([0, 0, -CARTopZOffs]) rotate([0, 0, 180]) translate([-CARCX/2, -CARCY/2, 25]) import("printedparts/1xCoreXY_Direct_Drive.stl");
}

module core_xy_frame(bx=BARXLen, cx=RODXLen, by=BARYLen, cy=RODYLen, px=0, py=0, partClr="SlateGray", rodClr="White", carClr="Crimson", withE3D=true, rAxis=true, lAxis=true, e3dClr="White", newCar=false) {
    xe_px=bx/2 + px;
    xe_py=by/2 + py;
    if (rAxis) {
        translate([bx, 0, 0]) r_y_axis(by, cy, xe_py, partClr, rodClr);
    }
    if (lAxis) {
        translate([-0, 0, 0]) l_y_axis(by, cy, xe_py, partClr, rodClr);
    }
    color(rodClr) {
        translate([(bx-cx)/2, xe_py - 25, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=8);
        translate([(bx-cx)/2, xe_py - 25 + 50, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=8);
    }
    if (newCar) {
        translate([xe_px, xe_py, BARCZ+RODXYDiam/1.5]) x_carriage_new(carClr, withE3D, e3dClr);
    }
    else {
        translate([xe_px, xe_py, 0]) carriage_v12(true, carClr, false);
    }
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

module z_plane_holes_half(newRodHolders=true) { 
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

module z_plane_holes_sizes(newRodHolders=true, h=5) { 
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


module z_plane(h=4, skipDims=false, newRodHolders=true, planeClr="Cyan") {
    difference() {
        color(planeClr) h_plane(h);
        z_plane_holes_half(newRodHolders);
        translate([0, BARYLen, 0]) mirror([0, 1, 0]) z_plane_holes_half(newRodHolders);
    }
    if(!skipDims) {
        dimz = h + 1;
        z_plane_holes_sizes(newRodHolders, h);
        translate([BARXLen, BARYLen, 0]) rotate([0, 0, 180]) z_plane_holes_sizes(newRodHolders, h);
        color("Black") {
            // Sides
            x_dim_abs(BARXLen+BARCX*2, 0, dimz, 200, ox=-BARCX);
            y_dim_abs(0, BARYLen+BARCY*2, dimz, -70, ox=-BARCX);
        }
    }
}