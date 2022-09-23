$fn=32;

module CNC_Shield_Top_Base() {
  color("White", 0.5) 
    translate([60.06, -54, -4]) 
      import("CNCSHEILD_TopW40mmFan_Final.stl");
}

module CNC_Shield_Top_Thin() {
  cx=70.5;
  cy=57.4;
  cz=38;
  ed=6.55;
  hd1=3.4;
  tsd=ed;
  translate([0.15, -0.63, 0]) {
    difference() {
      union() {
        translate([0, 0, cz-3.28]) 
          hull() {
            translate([cx/2, cy/2, 0]) sphere(d=tsd);
            translate([-cx/2, cy/2, 0]) sphere(d=tsd);
            translate([-cx/2, -cy/2, 0]) sphere(d=tsd);
            translate([cx/2, -cy/2, 0]) sphere(d=tsd);
          }
        translate([cx/2, cy/2, 0]) cylinder(d=ed, h=cz-3);
        translate([-cx/2, cy/2, 0]) cylinder(d=ed, h=cz-3);
        translate([-cx/2, -cy/2, 0]) cylinder(d=ed, h=cz-3);
        translate([cx/2, -cy/2, 0]) cylinder(d=ed, h=cz-3);
      }
      // holes
      color("Red") {
        translate([cx/2, cy/2, -2]) cylinder(d=hd1, h=cz+3);
        translate([-cx/2, cy/2, -2]) cylinder(d=hd1, h=cz+3);
        translate([-cx/2, -cy/2, -2]) cylinder(d=hd1, h=cz+3);
        translate([cx/2, -cy/2, -2]) cylinder(d=hd1, h=cz+3);
      }
    }
  }
}

%CNC_Shield_Top_Base();

//color("DarkOrchid", 0.5)
CNC_Shield_Top_Thin();
