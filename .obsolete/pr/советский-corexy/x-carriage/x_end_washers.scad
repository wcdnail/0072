include <../z-temp/z-config.scad>

ShowWashers=false;

if (ShowWashers) {
  translate([-15, 0, 0]) L_Pulley_Washer();
  translate([15, 0, 0]) R_Pulley_Washer();
  translate([-45, 8, -14.21]) L_Idler_Pulley_Washer();
  translate([45, 8, -14.21]) R_Idler_Pulley_Washer();
}
else {
  translate([-15, 0, 0]) L_Pulley_Nut();
  translate([15, 0, 0]) R_Pulley_Nut();
  translate([-45, 8, -14.21]) rotate([0, 0, 0]) L_Idler_Pulley_Nut();
  translate([45, 8, -14.21]) rotate([0, 0, 0]) R_Idler_Pulley_Nut();
}