include <bconf.scad>

//translate([0, 0, 0]) rotate([0, 0, 0])

module z_frame_long_asm(skipDims=false) {
    ZmotorXC=BARXLen/2;
    translate([ZmotorXC, BARCY+1.15, 0]) z_motor_c1(skipDims);
    translate([ZmotorXC, BARYLen+BARCY+1.15-ZmotorCY, 0]) rotate([0, 0, 180]) z_motor_c1(true);
    h_frame_2020(skipDims);
    if(!skipDims) {
        color("Black") {
            x_dim_abs(ZmotorXC, 0, BARCZ, 130);
            x_dim_abs(BARXLen-ZmotorXC, 0, BARCZ, 130, ox=ZmotorXC);
            x_dim_abs(ZmotorXC-ZmotorCX/2, 0, BARCZ, 110);
            x_dim_abs(BARXLen-ZmotorXC-ZmotorCX/2, 0, BARCZ, 110, ox=ZmotorXC+ZmotorCX/2);
        }
    }
}

//z_frame_long_asm();

ZaxisML8UUCX=64;
ZaxisML8UUCY=21.2;
ZaxisML8UUCZ=57;

module z_lmu88_stls(modelColor="SlateGray", skipDims=false) {
    boffs=0.05;
    color(modelColor) render() {
        translate([-17, -ZaxisML8UUCY/2-boffs, 3]) rotate([0, 0, -90]) rotate([0, -90, 0]) import("printedparts/4xCoreXY_Z_Axis_LM8UU_Bolt.stl");
        translate([17, ZaxisML8UUCY/2+boffs, 3]) rotate([0, 0, 90]) rotate([0, -90, 0]) import("printedparts/4xCoreXY_Z_Axis_LM8UU_Nut.stl");
    }
    if(!skipDims) {
        color("Black") {
            x_dim(ZaxisML8UUCX, 0, ZaxisML8UUCZ-10, 20);
        }
    }
}

module z_lmu88_holder() {
    z_lmu88_stls();
}

z_lmu88_holder();
//%import("printedparts/4xCoreXY_Z_Axis_LM8UU_Bolt.stl");
//scale(0.0394) import("1112.3mf");
