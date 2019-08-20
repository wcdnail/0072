include <z-config.scad>
use <../../openscad/nema17.scad>
use <z.scad>
use <x_carriage_directdrive_enhanced.scad>
use <e3d_v5_liftdown_adapter.scad>

module Y_EndStop_Motor_Mount(clr=undef, clra=undef) {
  esbx=CARCX/2-3;
  cx=XEndStopMountCX;
  hhd=12;
  hcz=3.4;
  // ---
  translate([-23.5, -95, 5.7]) rotate([0, 0, 90]) X_EndStop_Mount(esbx, cx, clr, clra, true, false);
  difference() {
    // Horizontal
    hull() {
      translate([-36.64, -63.35, 25.2]) cylinder(d=hhd, h=hcz);
      translate([-36.64, -94.35, 25.2]) cylinder(d=hhd, h=hcz);
      translate([-56.5, -70, 25.2]) cube([18, cx, hcz]);
    }
    // Holes
    color("Red") {
      translate([-36.64, -63.35, -15.5]) cylinder(d=3.2, h=100);
      translate([-36.64, -94.35, -15.5]) cylinder(d=3.2, h=100);
    }
  }
}

//%translate([0, 90, 0]) r_idler("MediumSeaGreen", .8);
%translate([-3.5, -XENDCY/2, 15]) r_x_end("DarkSlateGray", .8);
%translate([0, -100, 0]) r_motor("MediumSeaGreen", .8);

Y_EndStop_Motor_Mount();
