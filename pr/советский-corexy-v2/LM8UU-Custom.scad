include <Rods-Custom.scad>

// Размеры линейных подшипников
LM8UUOutterDiam=16.15;
LM8UULen=25;

module LM8UU_Custom() {
  translate([-LM8UULen/2, 0, 0]) union() {
    color("Khaki") rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam, h=LM8UULen);
    color("Silver") translate([-LM8UULen/2, 0, 0]) rotate([0, 90, 0]) cylinder(d=RODXYDiam*1.3, h=LM8UULen*2);
  }
}
