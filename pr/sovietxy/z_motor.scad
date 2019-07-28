include <bconf.scad>

z_motor();
color("red") translate([0, 0, -20]) cube([42.3, 42.3, 5]);
color("blue") translate([-21.15, 0, -10]) cube([42.3+21.15*2, 42.3, 5]);
color("red") translate([42.3/2, 42.3/2, -20]) cylinder(d=24, h=40);