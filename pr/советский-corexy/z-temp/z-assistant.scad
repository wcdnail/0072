module Z_Parts_Mount_Assistant() {
  cz=115;
  cy=8;
  cya=4.4;
  cxi=6;
  difference() {
    union() {
      translate([0, 0, cz/2]) cube([20, cy, cz], center=true);
      translate([0, 0, cz/2]) cube([cxi, cy+cya, cz], center=true);
    }
    color("Red") {
      //translate([0, 14, cz/2-2]) cube([20-(4*2), 24, cz+10], center=true);
      translate([0, 30, cz/6]) rotate([90]) cylinder(d=5.4, h=60);
      translate([0, 30, cz/2]) rotate([90]) cylinder(d=5.4, h=60);
      translate([0, 30, cz-cz/6]) rotate([90]) cylinder(d=5.4, h=60);
    }
  }
  %translate([0, 10, cz/2]) rotate([90]) cylinder(d=5.2, h=19.5);
}

Z_Parts_Mount_Assistant($fn=64);