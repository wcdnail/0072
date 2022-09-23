include <../z-temp/z-config.scad>
use <../z-temp/z.scad>

module E3D_v5_liftdown_adapter(withNut=true, clr="Yellow", halfSlice=false) {
  masterDiam=CARCentralHoleDiam-0.8;
  zBottom=53.5;
  vbx=CARCentralHoleDiam+6;
  vby=CARCentralHoleDiam/3;
  vbz=12;
  xfd=2.4;
  ybd=-CARCentralHoleDiam/3.7;
  ynd=8;
  zbd=59.5;
  //render()
  translate([0, 0, -CARTopBaseCZ/2]) difference() {
    color(clr) union() {
      translate([0, 0, E3Dv5ZOffset+56.7]) cylinder(h=zE3Dv5HolderOffset, d=masterDiam);
      translate([0, 0, E3Dv5ZOffset+zBottom]) cylinder(h=vbz, d=vbx);
      // v5 holder
      translate([0, 0, E3Dv5ZOffset-CARTopZOffs+zE3Dv5HolderOffset+3.4]) 
          E3D_v5_cylinders(drawOnlyHolder=true, lchDia=masterDiam);
    }
    color("Red") {
      // Central inner hole
      translate([0, 0, E3Dv5ZOffset+64]) cylinder(h=zE3Dv5HolderOffset-7.5, d=16);
      // Central hole
      translate([0, 0, E3Dv5ZOffset+64]) cylinder(h=zE3Dv5HolderOffset+100, d=4.2);
      // Side slice
      if (halfSlice) {
        translate([-CARCentralHoleDiam, 0, E3Dv5ZOffset+43.9]) cube([CARCentralHoleDiam*2, CARCentralHoleDiam, 300]);
      }
      else {
        translate([-CARCentralHoleDiam, 0, E3Dv5ZOffset+43.9]) cube([CARCentralHoleDiam*2, CARCentralHoleDiam, zE3Dv5HolderOffset+8]);
      }
      // Bolt holes
      translate([ CARCentralHoleDiam/xfd, CARCentralHoleDiam, E3Dv5ZOffset+zbd]) rotate([90]) cylinder(d=3.05, h=CARCentralHoleDiam*2);
      translate([-CARCentralHoleDiam/xfd, CARCentralHoleDiam, E3Dv5ZOffset+zbd]) rotate([90]) cylinder(d=3.05, h=CARCentralHoleDiam*2);
      if (withNut) {
        translate([ CARCentralHoleDiam/xfd, ybd-ynd+1, E3Dv5ZOffset+zbd]) rotate([90]) scale([1, 1, 2]) nut("M3");
        translate([-CARCentralHoleDiam/xfd, ybd-ynd+1, E3Dv5ZOffset+zbd]) rotate([90]) scale([1, 1, 2]) nut("M3");
      }
      else {
        translate([ CARCentralHoleDiam/xfd, ybd-3, E3Dv5ZOffset+zbd]) rotate([90]) cylinder(d=6.1, h=7);
        translate([-CARCentralHoleDiam/xfd, ybd-3, E3Dv5ZOffset+zbd]) rotate([90]) cylinder(d=6.1, h=7);
      }
    }
    color("Blue") translate([0, 0, E3Dv5ZOffset-CARTopZOffs]) 
      E3D_v5_cylinders(0.1, 0.4);
  }
}

module E3D_v5_liftdown_clamp(clr="MediumSeaGreen") {
  translate([0, 0.4, 0]) color(clr) render() difference() {
    rotate([0, 0, 180]) E3D_v5_liftdown_adapter(false, clr);
    translate([-CARCentralHoleDiam, -CARCentralHoleDiam, E3Dv5ZOffset+73.6-CARTopBaseCZ/2]) 
      cube([CARCentralHoleDiam*2, CARCentralHoleDiam*2, zE3Dv5HolderOffset*2]);
  }
}

E3D_v5_liftdown_adapter(halfSlice=true);
//E3D_v5_liftdown_clamp();
E3D_v5_temp(notTransparent=false, fitting=true);
//E3D_v5_std_clamp();
