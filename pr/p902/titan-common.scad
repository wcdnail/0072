CarCX=43;
CarCY=90;
CarCZ=21.6;
CarThick=5.4;
IntCX=18;
IntCY=48;
InlCX=36;
InlCY=IntCY/2;

module E3D_Titan_Base(clr="DeepSkyBlue", cla=undef) {
  color(clr, cla) {
    translate([39, 50, 64]) rotate([0, 0, 180]) rotate([0, 90, 0]) import("../parts/titan-mihatomi/e3d_Titan_extruder_-_e3d_extruder-1.STL");
  }
}

module E3D_v6_175(clr="DarkSlateGray", cla=undef) {
  color(clr, cla) translate([5.2, -2.5, 0]) rotate([0, 0, 0]) import("../parts/E3D_v6_1.75mm_Universal.stl");
}

module X_Car_Draft(clr="LightSlateGray", cla=undef) {
  color(clr, cla) difference() {
    cube([CarCX, CarCY, CarCZ], center=true);
    translate([0, 0, -CarThick/2]) cube([CarCX*2, 50, CarCZ], center=true);
    translate([0, 0, 5]) cube([IntCX, IntCY, 50], center=true);
    translate([0, InlCY/2, 5]) cube([InlCX, InlCY, 50], center=true);
  }
}

module Aero_Titan_Adapter(clr="MediumSeaGreen", cla=undef) {
  color(clr, cla) {
    rotate([0, 0, 180]) import("titan-aero-3/flyingbear_titan_aero_adapter.stl");
  }
}

module Aero_Titan_FanDuct(clr="MediumSpringGreen", cla=undef) {
  color(clr, cla) {
    rotate([90, 0, 0]) import("titan-aero-3/FB_DuctFan.STL");
  }
}

module Tevo_Titan_Adapter(clr="MediumSeaGreen", cla=undef) {
  color(clr, cla) {
    rotate([0, 0, -90]) import("titan-tevo-2/Titan_MOUNT_v2.STL");
  }
}

module Tevo_Titan_FanDuct(clr="MediumSpringGreen", cla=undef) {
  color(clr, cla) {
    rotate([0, 0, 180]) import("titan-tevo-2/Blower_Fan_DUCT_SHORT.STL");
  }
}
