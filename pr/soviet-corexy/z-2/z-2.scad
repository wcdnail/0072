include <../z-temp/z-config.scad>

module Z_MotorMount_2() {
  translate([47.01, 87.1, -23.1]) rotate([0, 48, 0]) import("Z-Axis_Bottom_X2.stl");
}

module Z_TableMount_2() {
  color("Green") translate([56.34, 102.35, 31.5]) mirror([0, 0, 1]) rotate([0, -44, 0]) import("Z_axis_Mount.stl");
}

module Z_Motor_Half2(withMotor=true, withRods=true, drawMotor=true) {
  // Motor
  if (withMotor) {
    translate([BARXLen/2, 21, 0]) rotate([0, 0, -90]) Z_MotorMount_2();
    if (drawMotor) {
      translate([ZmotorXC, BARCY+1.15, -N17Height/2+22.2]) Nema17(N17Height, N17Width, N17ShaftDiameter, N17ShaftLength, N17FixingHolesInteraxis);
    }
  }
  // Rods
  if (withRods) {
    %color("White", 0.7) {
      translate([BARXLen/2-35.9, 7, RODZUp]) cylinder(d=8, h=RODZLen);
      translate([BARXLen/2+35.9, 7, RODZUp]) cylinder(d=8, h=RODZLen);
    }
    // Z screw
    color("DimGray") {
      translate([BARXLen/2, 21, 42.6]) cylinder(d=8, h=ZScrewLen);
    }
  }
}

module Bottom_Frame_2(withMotor=true, withRods=true, drawMotor=true, transparentBars=true) {
  if (true) {
    h_frame_2020(true, transparentBars);
  }
  if (true) {
    translate([0, 0.5, -3.1]) Z_Motor_Half2(withMotor, withRods, drawMotor);
    //translate([0, BARYLen-0.5, -3.1]) mirror([0, 1, 0]) Z_Motor_Half2(withMotor, withRods, drawMotor);
  }
}

module Top_Frame_2() {
  if (true) {
    translate([0, 0, TOPFrameZ-BARCZ]) h_frame_2020(true, transparentBars=true);
  }
  translate([0, 0, TOPFrameZ]) Bottom_Frame_2(withMotor=false, withRods=false, transparentBars=true);
}


Bottom_Frame_2();
Top_Frame_2();
//translate([BARXLen/2, -7, 30]) rotate([0, 0, 90]) Z_TableMount_2();
