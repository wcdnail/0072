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

module SKR13_SM(clr=undef, lift=SKR13TopLift, sxy=0.6, sz=3) {
  color(clr) 
    translate([65, 56, lift-12]) 
      rotate([0, 0, 0]) 
        scale([sxy, sxy, sz]) 
          import("../sm.stl");
}

module SKR13_Top_Cover(clr=undef, lift=SKR13TopLift) {
  color(clr) render() difference() {
    translate([0, 0, lift]) 
      rotate([0, 0, 0]) 
        import("SKR_MKSGen_LTop.stl");
    SKR13_SM("Red", lift);
  }
}

//SKR13_Bottom_Cover("Yellow");
SKR13_Top_Cover("Red");
//SKR13_SM("Yellow", SKR13TopLift+10, 0.59, 0.6);
color("Yellow") translate([65, 56, SKR13TopLift-2])
  Hammer(0.59, 0.59, 4);