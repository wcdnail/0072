$fn=32;

boltX = 12;
boltY = 12;
boltDia = 3.4;

cx = 30;
cy = 30;
cz = 5.6;

mcx = cx/1.4;
mcy = cy/1.4;
mcz = 9;

fascX = 2;
fascY = 2;
fascZ = 2;

sliceX = 0;
sliceY = 0;
sliceDia = 38;

difference() {
  union() {
    cube([cx, cy, cz]);
    cube([mcx, mcy, mcz]);
  }
  color("Blue") {
      translate([fascX, fascY, fascZ]) cube([cx, cy, cz*2]);
  }
  color("Red") {
    translate([boltX, boltY, -10]) cylinder(d=boltDia, h=50);
    translate([cx + sliceX, cy + sliceY, -cz]) cylinder(d=sliceDia, h=cz*3, $fn=20);
  }
}
