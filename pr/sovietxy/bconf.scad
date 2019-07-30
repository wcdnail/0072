include <../../openscad/libs/nutsnbolts/cyl_head_bolt.scad>
include <../../openscad/libs/nutsnbolts/materials.scad>
include <../../openscad/libs/dim1/dimlines.scad>

// OpenSCAD params...
$fn=64;

// Параметры отображения размеров
DIM_LINE_WIDTH=0.8;
DIM_FONTSCALE=1.2;

// Размеры линейных подшипников
LM8UUOutterDiam=16.2;
LM8UULen=25;

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

// Длины гладких направляющих 
RODXLen=420;
RODYLen=405;
RODZLen=370;

// Параметры каретки X
origCARLen=76;                  // Оригинальная длина (X)
origCARWidth=76;                // Оригинальная ширина (Y)
origCARHeightWOHolder=6;        // Оригинальная высота (Z)

carXEdge=3;                     // Длина передней стенки 
carCX=origCARLen/2.7+carXEdge;  // Новая длина каретки
carBaseXOffset=-carXEdge;       // Смещение каретки по X

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
carVBoltHoleCenterOffs=-6;

carBaseZOffset=0;               // Смещение базы каретки по Z 

ZmotorCX=84.6;
ZmotorCY=42.3;
ZmotorHeight=20;

ZaxisML8UUCX=64;
ZaxisML8UUCY=21.2;
ZaxisML8UUCZ=57;
ZaxisM5HoleCX=49;

ZrodHolderCX=62.24;
ZrodHolderCY=21.15;
ZrodHolderCZ=20;
ZrodHolderClampCX=34;

// ---------------------------------------------------------------------------------------------------------------------
// Размеры 

module x_dim_abs(cx, cy, cz, offs=20, lh=6, rh=6, ox=0, oy=0, oz=0, textLoc=DIM_CENTER) {
    translate([ox, oy-offs, oz+cz]) dimensions(cx, loc=textLoc);
    lly = offs<0 ? oy-offs+lh-2 : oy+lh-2;
    rly = offs<0 ? oy-offs+rh-2 : oy+rh-2;
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

module y_dim_abs(cx, cy, cz, offs=20, lh=6, rh=6, ox=0, oy=0, oz=0, textLoc=DIM_CENTER, textLoc) {
    rotate([0, 0, 90]) x_dim_abs(cy, cx, cz, offs, lh, rh, ox, oy, oz);
}

module z_dim_abs(cx, cy, cz, offs=20, lh=6, rh=6, ox=0, oy=0, oz=0, textLoc=DIM_CENTER, textLoc) {
    translate([0, 0, cz]) rotate([0, 90, 0]) x_dim_abs(cz, cy, cx/2, offs, lh, rh, ox, oy, oz);
}

// ---------------------------------------------------------------------------------------------------------------------

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
    translate([0, 0, 0]) rotate([0, 0, 0]) import("printedparts/1xCoreXY_X-Carriage.stl");
}

module x_belt_clamp() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("belt_tensioner.stl");
}

module x_carriage_direct_drive() {
    translate([0, origCARWidth, 0]) rotate([180, 0, 0]) import("printedparts/1xCoreXY_Direct_Drive.stl");
}

module e3d_v6_175() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("../parts/E3D_v6_1.75mm_Universal.stl");
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
            translate([ZmotorCX/4, -ZmotorCX/4, 20]) 
                rotate([0, 0, 180]) rotate([180, 0, 0]) 
                    import("printedparts/2xCoreXY_Z_Motor.stl");
            translate([0, -ZmotorCX/3, -9.9]) 
                cube([ZmotorCX+20, ZmotorCY+20, 20], center=true);
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

module profile_2020(h, profClr="Gainsboro") {
    color(profClr) render() {
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

module h_frame_half(skipDims=false, profClr="Gainsboro") {
    translate([-BARCX/2, 0, BARCZ/2]) rotate([-90, 0, 0]) profile_2020(BARYLen, profClr);
    translate([0, -BARCX/2, BARCZ/2]) rotate([0, 90, 0]) profile_2020(BARXLen, profClr);
    if(!skipDims) {
        color("black") {
            x_dim_abs(BARXLen, BARYLen, BARCZ, 150);
            y_dim_abs(BARXLen, BARYLen, BARCZ, -150);
        }
    }
}

module h_frame_2020(skipDims=false, profClr="Gainsboro") {
    h_frame_half(skipDims);
    translate([BARXLen, BARYLen, 0]) rotate([0, 0, 180]) h_frame_half(true, profClr);
}

module h_frame_2040(skipDims=false, profClr="Gainsboro") {
    h_frame_2020(skipDims, profClr);
    translate([0, 0, BARCZ]) h_frame_2020(skipDims, profClr);
}
