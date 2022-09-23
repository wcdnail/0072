use <../sm.scad>

module SKR_13_v1() {
  translate([85.5, 109.1, 8]) 
    rotate([0, 0, 180]) 
      import("../skr13_v1.stl");
}

module MKSGEN_Top_Cover(clr=undef) {
  color(clr) 
    translate([0, 0, 70])
      rotate([0, 0, 0])
        import("SKR_MKSGen_LTop.stl");
}

module SKR13_Bottom_Cover(clr=undef) {
  color(clr)
    translate([0, 0, 0]) 
      rotate([0, 0, 0])
        import("SKR_bottom.stl");
  %SKR_13_v1();
}

SKR13TopLift=60;

module SKR13_SM(shrink=0, clr=undef, lift=SKR13TopLift, sxy=0.6, sz=3) {
  color(clr) translate([69.6, 52.95, lift-2])
    scale([sxy, sxy, sz]) rotate([0, 0, 45]) 
      HammerAndSickle(shrink);
}

module SKR13_Top_Cover(clr=undef, lift=SKR13TopLift) {
  color(clr) render() difference() {
    translate([0, 0, lift]) 
      rotate([0, 0, 0]) 
        import("SKR_MKSGen_LTop.stl");
    SKR13_SM(0, "Red", lift);
  }
}

//SKR13_Bottom_Cover("Yellow");
//SKR13_Top_Cover("Red");
SKR13_SM(1.1, "Yellow", SKR13TopLift+10, 0.6, 0.6);
