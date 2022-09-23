use <../../parts/sm.scad>

module FGSM_SM(shrink=0, clr=undef, sxy=0.4, sz=3) {
  color(clr) translate([28, -20, -5]) 
    scale([sxy, sxy, sz]) rotate([0, 0, -45]) 
      mirror([1, 0, 0]) HammerAndSickle(shrink);
}

module Top_Blank_V11(clr=undef) {
  color(clr) translate([0, 0, -289.2]) import("Top-Blank_V1.1.stl");
}

//render() 
difference() {
  rotate([0, -1.5, 0]) Top_Blank_V11();
  FGSM_SM(0, "Red");
}
