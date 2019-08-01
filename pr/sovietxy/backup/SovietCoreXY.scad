include <z-config.scad>

printer_height=600;

z_rod_height=373;
z_car_height=54;
z_hold_height=20;

y_axis_die=1.4;

module table(tx, ty) {
    ex = tx % 100;
    ey = ty % 100;
    color("Grey") cube([tx, ty, 4]);
    translate([ex/2, ey/2, 4]) color("White") cube([tx-ex, ty-ey, 3]);
}

module z_carriage() {
    color("DarkSlateGray") translate([10.57, -17, 0]) rotate([0, -90, 0]) {
        translate([0, 34, 21.3]) rotate([180, 0, 0]) import("printedparts/4xCoreXY_Z_Axis_LM8UU_Bolt.stl");
        translate([0, 0, 0]) rotate([0, 0, 0]) import("printedparts/4xCoreXY_Z_Axis_LM8UU_Nut.stl");
    }
}

module z_carriage_rod(zp = 0) {
    translate([0, 0, (z_rod_height-z_car_height-z_hold_height)-zp]) z_carriage();
    z_holder_new();
    translate([0, 0, z_rod_height-z_hold_height]) z_holder_new();
    color("White") cylinder(d=8, h=z_rod_height);
}

module x_carriage() {
    translate([-37.5, 37.5, 15.2]) rotate([180, 0, 0]) import("printedparts/1xCoreXY_X-Carriage.stl");
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

module r_x_end() {
    mirror([1, 0, 0]) l_x_end();
}

module r_idler() {
    translate([0, 0, 0]) rotate([0, 0, 180]) import("printedparts/1xCoreXY_Idler.stl");
}

module r_motor() {
    translate([0, 0, 25]) rotate([180, 0, 180]) import("printedparts/1xCoreXY_Motor.stl");
}

module r_y_axis(by, cy, xe_pos) {
    color("DarkSlateGray") {
        translate([0, 0, 0]) r_motor();
        translate([0, by + BARCX, 0]) r_idler();
        translate([-3.5, xe_pos - 35, 14.5]) r_x_end();
    }
    translate([-21, cy + 43, 15]) rotate([90, 0, 0]) color("White") cylinder(h=cy, d=8);
}

module l_y_axis(by, cy, xe_pos) {
    mirror([1, 0, 0]) r_y_axis(by, cy, xe_pos);
}

module r_y_axis_tr(by, cy, xe_pos) {
    translate([0, 0, 0]) %r_motor();
    translate([0, by + BARCX, 0]) %r_idler();
    translate([-3.5, xe_pos - 35, 14.5]) %r_x_end();
    translate([-21, cy + 43, 15]) rotate([90, 0, 0]) color("White") cylinder(h=cy, d=8);
}

module l_y_axis_tr(by, cy, xe_pos) {
    mirror([1, 0, 0]) r_y_axis_tr(by, cy, xe_pos);
}

module core_xy(bx, cx, by, cy, px = 0, py = 0) {
    xe_px=bx/2 + px;
    xe_py=by/2 + py;
    translate([bx, 0, 0]) r_y_axis(by, cy, xe_py);
    translate([-0, 0, 0]) l_y_axis(by, cy, xe_py);
    color("White") {
        translate([(bx-cx)/2, xe_py - 25, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=8);
        translate([(bx-cx)/2, xe_py - 25 + 50, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=8);
    }
    translate([xe_px, xe_py, BARCX - 10]) color("Crimson") x_carriage();
}

module core_xy_tr(bx, cx, by, cy, px = 0, py = 0) {
    xe_px=bx/2 + px;
    xe_py=by/2 + py;
    translate([bx, 0, 0]) r_y_axis_tr(by, cy, xe_py);
    translate([-0, 0, 0]) l_y_axis_tr(by, cy, xe_py);
    color("White") {
        translate([(bx-cx)/2, xe_py - 25, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=8);
        translate([(bx-cx)/2, xe_py - 25 + 50, 14.8]) rotate([0, 90, 0]) cylinder(h=cx, d=8);
    }
    translate([xe_px, xe_py, BARCX - 10]) %x_carriage();
}


module frame_cst(bx, by, hgt = BARCX) {
    color("SeaGreen") {
        translate([bx, 0, -hgt]) cube([BARCX, by, hgt]);
        translate([-BARCX, 0, -hgt]) cube([BARCX, by, hgt]);
    }
    color("Purple") {
        translate([0, -BARCX, -hgt]) cube([bx, BARCX, hgt]);
        translate([0, by, -hgt]) cube([bx, BARCX, hgt]);
    }
}

module frame_ytx(bx, by, hgt = BARCX) {
    color("SeaGreen") {
        translate([bx, 0, -hgt]) cube([BARCX, by, hgt]);
        translate([-BARCX, 0, -hgt]) cube([BARCX, by, hgt]);
    }
    color("Purple") {
        translate([0, 0, -hgt]) cube([bx, BARCX, hgt]);
        translate([0, by-BARCX, -hgt]) cube([bx, BARCX, hgt]);
    }
}


module core_xy_t220(bx, cx, by, cy, px = 0, py = 0, table_y_offset = 0) {
    tx=220;
    ty=220;
    core_xy(bx, cx, by, cy, px, py, table_y_offset); 
    translate([(bx-tx)/2, table_y_offset+(by-ty)/2, -20]) table(tx, ty);
}

module core_xy_t330(bx, cx, by, cy, px = 0, py = 0, table_y_offset = 0) {
    tx=330;
    ty=330;
    core_xy(bx, cx, by, cy, px, py, table_y_offset); 
    translate([(bx-tx)/2, table_y_offset+(by-tx)/2, -20]) table(tx, tx);
}

module frame_vert(bx, by) {
    translate([-BARCX, -BARCX, -printer_height]) cube([BARCX, BARCX, printer_height]);
    translate([-BARCX, by, -printer_height]) cube([BARCX, BARCX, printer_height]);
    translate([bx, by, -printer_height]) cube([BARCX, BARCX, printer_height]);
    translate([bx, -BARCX, -printer_height]) cube([BARCX, BARCX, printer_height]);
}

module frame_full(bx, by) {
    core_xy_h=20;
    bottom_h=20;
    frame_cst(bx, by, core_xy_h);
    translate([0, 0, -(prinetr_height-bottom_h-core_xy_h-BARCX*2)]) frame_cst(bx, by, bottom_h);
}

module curr_v() {
    x_rodh_orig=330;
    y_rodh_orig=347;
    x_barh_orig=400;
    y_barh_orig=400;

    min_x=-108;
    min_y=-110;
    max_x=108;
    max_y=140;
    
    frame_full(x_barh_orig, y_barh_orig);
    core_xy_t220(x_barh_orig, x_rodh_orig, y_barh_orig, y_rodh_orig, min_x, min_y, 0);
}

module new_frame_full(bx, by) {
    core_xy_h=40;
    bottom_h=40;
    core_xy_z_offs=100;
    translate([0, 0, core_xy_z_offs]) frame_vert(bx, by);
    translate([0, 0, core_xy_z_offs]) frame_cst(bx, by, BARCX);
    frame_cst(bx, by, core_xy_h);
    translate([0, 0, -(printer_height-bottom_h-core_xy_z_offs-87)]) frame_cst(bx, by, BARCX);
    translate([0, 0, -(printer_height-bottom_h-core_xy_z_offs)]) frame_cst(bx, by, bottom_h);
    /*
    tfcx=400;
    tfcy=400;
    tfho=300;
    tfeh=200;
    translate([(bx-tfcx)/2, (by-tfcy)/2, tfho]) frame_cst(tfcx, tfcy, BARCX);
    translate([(bx-tfcx)/2-BARCX, (by-tfcy)/2-BARCX*2, tfho-tfeh]) 
        rotate([-5.7, 0, 0]) cube([BARCX, BARCX, tfeh]);
    */
}

module newestVariant() {
    RODXLen=420;
    RODYLen=405;
    BARXLen=490;
    BARYLen=450;
    
    tx=330;
    ty=330;
    ty_offset=14;

    min_x=-150;
    min_y=-135;
    max_x=150;
    max_y=165;
    min_z=0;
    max_z=275;
    
    zpos =0;
    ztab =7;
    tab_cx=387;
    tab_cy=400;
    
    // Frame
    new_frame_full(BARXLen, BARYLen);
    
    // Soviet CoreXY
    core_xy(BARXLen, RODXLen, BARYLen, RODYLen, 0, 0);
    
    // Table
    translate([(BARXLen-tx)/2, ty_offset+(BARYLen-tx)/2, -(z_hold_height*2+zpos)+ztab]) table(tx, tx);
    
    // Z rods
    translate([21.2, ty_offset+95, -(z_rod_height + z_hold_height)]) z_carriage_rod(zpos);
    translate([21.2, ty_offset+BARXLen-135, -(z_rod_height + z_hold_height)]) z_carriage_rod(zpos);
    translate([BARYLen + 40, 0, 0]) mirror([1, 0, 0]) {
        translate([21.2, ty_offset+95, -(z_rod_height + z_hold_height)]) z_carriage_rod(zpos);
        translate([21.2, ty_offset+BARXLen-135, -(z_rod_height + z_hold_height)]) z_carriage_rod(zpos);
    }
    translate([(BARXLen-tab_cx)/2, ty_offset + (BARYLen-tab_cy)/2, -(z_hold_height*2+zpos)]) frame_ytx(tab_cx, tab_cy, BARCX);
}

newestVariant();

RODXLen=420;
RODYLen=405;
BARXLen=490;
BARYLen=450;

tx=330;
ty=330;
ty_offset=14;

//core_xy_tr(BARXLen, RODXLen, BARYLen, RODYLen, 0, 0);
//translate([21, BARYLen-0.5, 15]) rotate([90, 0, 0]) color("red") cylinder(h=y_axis_die, d=8);
