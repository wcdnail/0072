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

RODXLen=420;
RODYLen=405;
RODZLen=373;
RODZUp=-3;
TOPFrameZ=370;

ZScrewLen=330;

// Параметры каретки X
carZE3DOffs=-19.5;

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
        translate([-3.5, xe_pos - 35, 14.5]) r_x_end();
    }
    translate([-21, cy + 43, 15]) rotate([90, 0, 0]) color(rodClr) cylinder(h=cy, d=8);
}

module l_y_axis(by, cy, xe_pos, partClr="SlateGray", rodClr="White") {
    mirror([1, 0, 0]) r_y_axis(by, cy, xe_pos, partClr, rodClr);
}

module x_carriage() {
    translate([-37.5, 37.5, 15.2]) rotate([180, 0, 0]) import("printedparts/1xCoreXY_X-Carriage.stl");
}

module x_carriage_new(carClr="Crimson", withE3D=true, e3dClr="White") {
    color(carClr) {
        render() {
            translate([carCX-carXEdge, -origCARWidth/2, 0]) rotate([0, 90, 0]) import("x_carriage-16x25lm8uu.stl");
            translate([-(carCX-carXEdge), -origCARWidth/2, 0]) rotate([0, -90, 0]) import("x_carriage-16x25lm8uu_holes.stl");
            translate([0, 0, 0]) rotate([0, 0, 0]) import("x_carriage-top.stl");
        }
    }
    if (withE3D) {
        color(e3dClr) translate([5.3, -2.5, carZE3DOffs]) rotate([0, 0, 0]) e3d_v6_175();
    }
}

module core_xy_frame(bx=BARXLen, cx=RODXLen, by=BARYLen, cy=RODYLen, px=0, py=0, partClr="SlateGray", rodClr="White", carClr="Crimson", withE3D=true, rAxis=true, lAxis=true, e3dClr="White") {
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
    translate([xe_px, xe_py, BARCZ+RODXYDiam/1.5]) x_carriage_new(carClr, withE3D, e3dClr);
}

module x_carriage_new_check(bx=BARXLen, cx=RODXLen, by=BARYLen, cy=RODYLen, px=0, py=0, rodClr="White", carClr="Crimson", withE3D=true) {
    core_xy_frame(bx, cx, by, cy, px, py, "None", rodClr, carClr, withE3D, false, false);
}
