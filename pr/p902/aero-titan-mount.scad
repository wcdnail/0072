include <titan-common.scad>

module Aero_Titan_Assembly() {
  translate([26, 30, 11]) Aero_Titan_Adapter(cla=.5);
  translate([-33.3, 35, -24]) Aero_Titan_FanDuct(cla=.5);
  translate([-11.1, -10, 35.6]) E3D_Titan_Base(cla=.5);
  translate([0, -11, 9.12]) E3D_v6_175();
}

X_Car_Draft(cla=.5);
Aero_Titan_Assembly();