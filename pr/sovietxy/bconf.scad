// OpenSCAD params...
$fn=64;

// Размеры линейных подшипников
LM8UUOutterDiam=16.2;
LM8UULen=25;

// Размеры держателей линейных подшипников
LM8UUHolderOD=4.8;
LM8UUCenterOffset=0.5;

// Длины профилей (2020, 4040)
BARXLen=490;
BARYLen=450;

// Длины гладких направляющих 
RODXLen=420;
RODYLen=405;

// Параметры каретки X
OrigCARLen=76;                  // Оригинальная длина (X)
OrigCARWidth=76;                // Оригинальная ширина (Y)
OrigCARHeightWOHolder=6;        // Оригинальная высота (Z)

carXEdge=3;                     // Длина передней стенки 
carCX=OrigCARLen/2.7+carXEdge;  // Новая длина каретки
carBaseXOffset=-carXEdge;       // Смещение каретки по X

carYShrink=23;                  // Декремент ширины каретки
carCY=OrigCARWidth-carYShrink;

e3dBaseXOffset=12;              // Смещение E3D от центра по X
e3dBaseYOffset=15;              // Смещение E3D от центра по Y
e3dNutsYOffset=3;

hnut_m="M3";            // Размер горизонтальных гаек
hbolt_d=3.2;            // Диаметр горизонтальных отв.
hbolt_dhead=7;          // Диаметр шляпки горизонтальных винтов
hnut_sf=15;             // Масштаб горизонтальных гаек
hnut_hh=8.2;            // Смещение по Z горизонтальных гаек

vnut_m="M4";            // Размер вертикальных гаек
vbolt_d=4.2;
vhole_ofs=-6;

carBaseZOffset=0;       // Смещение базы каретки по Z 

module x_rods(rod_d, bx, cx, by, cy, px = 0, py = 0) {
    xe_px=bx/2 + px;
    xe_py=by/2 + py;
    translate([(bx-cx)/2, xe_py - 25, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=rod_d);
    translate([(bx-cx)/2, xe_py - 25 + 50, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=rod_d);
}

module z_motor() {
    translate([0, 0, 0]) rotate([0, 0, 0]) import("printedparts/2xCoreXY_Z_Motor.stl");
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
    translate([0, OrigCARWidth, 0]) rotate([180, 0, 0]) import("printedparts/1xCoreXY_Direct_Drive.stl");
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
