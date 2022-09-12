/*
Cover for the Mean Well NES-350 power supplies
https://www.thingiverse.com/thing:2814343/

2018-03-15

Designed for use with pmeyer's brace/psu mount for the Prusa i3 MK3
  https://www.thingiverse.com/thing:2783871/
but you could use it in your own projects or just stand alone,
assuming you can find the right switch and power inlet. Or edit those out.

Highly recommend a version of OpenSCAD with the customizer. You might have
to enable the feature in prefs and then unhide it from the view menu.

Changelog:
  2018-03-04: Initial release.
  2018-03-15: Corrected square nut slot location. Added cutout for side vents.

*/

/* [Which Object?] */
render_psu = true; // for debugging
render_base = true;
render_bottom = true;
$fn=15;

/* [PSU Measurements] */
psu_length = 215;
psu_width  = 115;
psu_height = 50;
psu_connector_depth = 12; // from spec sheet
psu_connector_width = 89;
psu_connector_inset_from_left = 22;
psu_connector_inset_from_top = 26;
fan_from_top = 47.5; // from spec sheet
fan_from_left = 36.5; // from spec sheet
fan_radius = 30;
face_vent_from_edge = 21; // approx measured
face_vent_width = 26; // approx measured
face_vent_top = 80; // approx measured
side_vent_from_edge = 12.5; // approx from spec sheet
side_vent_bottom = 5; // measured from spec sheet
side_vent_height = 18; // measured from spec sheet, added 1 because it was a bit small once printed
back_holes = [//[10  ,27.5,3], [10  ,  205,3], [105  ,27.5,3], [105,205,3],
              [32.5,32.5,4], [32.5,182.5,4], [ 82.5,32.5,4], [ 82.5,182.5,4]];
left_holes = [[12.5,32.5,4], [12.5, 182.5,4]];
right_holes = [[12.5,32.5,4], [12.5, 182.5,4], [37.5, 32.5, 4], [37.5, 182.5, 4]];
/* [Mount Measurements] */
wall_thickness = 2.5;
wiring_area_height = 30; // matches prusa mount
psu_overlap_rear = 37;
psu_overlap_front = 9;
ledge_thickness_left = 3;
ledge_thickness_right = 3;
inlet_x = 72;
switch_x = 26;
switch_z = 7;

/* [Switch Measurements] */
switch_height = 20;
switch_width = 12.5;

/* [Inlet Measurements] */
inlet_width = 27.25;
inlet_height = 32;
inlet_screw_offset_x = 5;
inlet_screw_offset_z = 16.5;
inlet_screw_dia = 3.1;

/* [Wire Exit] */
wire_exit_width = 10;
wire_exit_height = 6.5;
wire_exit_x = 20;

/* [Base Measurements] */
base_end_tab_length = 30;
base_side_tab_length = 15;
base_tab_thickness = 5;
base_tab_height = 11;
base_side_tab_x = 50;
bottom_thickness = 2;
base_screw_dia = 3.1;

/* [Nuts and Bolts] */
hole_3mm_bolt = 3.1;
hole_3mm_bolt_r = hole_3mm_bolt/2;

// 3mm countersunk dimensions

bolt3_cs_wide_r   = 3;
bolt3_cs_narrow_r = 1.5;
bolt3_cs_height   = 2;

// square 3mm nut for tabs
square_nut3_width  = 5.55;
square_nut3_t       = 1.75;

module hole(v) {
  translate([v[0],v[1],0])
    circle(r=(v[2]+.1)/2);
}

module roundrect(x, y, r=3) {
  translate([r, r]) minkowski() {
    square([x-2*r, y-2*r]);
    circle(r);
  }
}

module psu() {
  color("skyblue")
    cube([psu_width,psu_height,psu_length]);

  // connectors
  color("blue")
    translate([psu_connector_inset_from_left,psu_connector_inset_from_top,-psu_connector_depth])
      cube([psu_connector_width,10, psu_connector_depth]);


  // vents
  color("red") {
    // face
    rotate([90,0,0]) {
      // fan
      translate([fan_from_left, psu_length - fan_from_top, 0]) //xzy
        circle(fan_radius);

      // lower front vents
      translate([face_vent_from_edge, 10,0]) //xzy
        square([face_vent_width, face_vent_top]);
      translate([psu_width - face_vent_from_edge - face_vent_width, 10, 0]) //xzy
        square([face_vent_width, face_vent_top]);

    }
  }

  // holes
  psu_holes();
}

module psu_holes(extrude_l=0) {
  color("purple") {
    // back
    rotate([90,0,180]) translate([-psu_width,0,+psu_height]){
      for(a = back_holes) {
        if(extrude_l > 0) {
          linear_extrude(height=extrude_l) hole(a);
        } else {
          hole(a);
        }
      }
    }

    translate([0,psu_height,0]) rotate([90,0,-90]) {
      for(a = left_holes) {
        if(extrude_l > 0) {
          linear_extrude(height=extrude_l) hole(a);
        } else {
          hole(a);
        }
      }
    }

    translate([psu_width,0,0]) rotate([90,0,90]) {
      for(a = right_holes) {
        if(extrude_l > 0) {
          linear_extrude(height=extrude_l) hole(a);
        } else {
          hole(a);
        }
      }
    }
  }
  color("red") {
    // left
    translate([0,psu_height,0]) rotate([90,0,-90]) {
      translate([side_vent_from_edge, side_vent_bottom, 0]) {
        if(extrude_l > 0) {
          linear_extrude(height=extrude_l) roundrect(x = psu_height - 2*side_vent_from_edge, y = side_vent_height, r=1.5);
        } else {
          roundrect(x = psu_height - 2*side_vent_from_edge, y = side_vent_height, r=1.5);
        }
      }
    }
    // right
    translate([psu_width,0,0]) rotate([90,0,90]) {
      translate([side_vent_from_edge, side_vent_bottom, 0]) {
        if(extrude_l > 0) {
          linear_extrude(height=extrude_l) roundrect(x = psu_height - 2*side_vent_from_edge, y = side_vent_height, r=1.5); //square([psu_height - 2*side_vent_from_edge, side_vent_height]);
        } else {
          roundrect(x = psu_height - 2*side_vent_from_edge, y = side_vent_height, r=1.5); //square([psu_height - 2*side_vent_from_edge, side_vent_height]);
        }
      }
    }
  }
}

module base() {
  difference() {
    translate([-wall_thickness, -wall_thickness, -wiring_area_height-psu_connector_depth])
      cube([psu_width + 2*wall_thickness, psu_height + 2*wall_thickness, wiring_area_height+psu_connector_depth+psu_overlap_rear]);

    translate([0,-wall_thickness-.5,0]) polyhedron(
      points = [
        [face_vent_from_edge,             0,              psu_overlap_front], // 0: bottom front left
        [psu_width - face_vent_from_edge, 0,              psu_overlap_front], // 1: bottom front right
        [psu_width - face_vent_from_edge, wall_thickness+1, psu_overlap_front], // 2: bottom rear right
        [face_vent_from_edge,             wall_thickness+1, psu_overlap_front], // 3: bottom rear left
        [0,                               0,              psu_overlap_rear], // 4: top front left
        [psu_width,                       0,              psu_overlap_rear], // 5: top front right
        [psu_width,                       wall_thickness+1, psu_overlap_rear], // 6: top rear right
        [0,                               wall_thickness+1, psu_overlap_rear]  // 7: top rear left
      ],
      faces = [
        [0,1,2,3],  // bottom
        [4,5,1,0],  // front
        [7,6,5,4],  // top
        [5,6,2,1],  // right
        [6,7,3,2],  // back
        [7,4,0,3] // left
      ]
    );

    cube([psu_width, psu_height, psu_length]);

    translate([ledge_thickness_left, 0, -wiring_area_height-psu_connector_depth-.5])
      cube([psu_width - ledge_thickness_right - ledge_thickness_left, psu_height, wiring_area_height+1+psu_connector_depth]);

    // mount holes
    psu_holes(wall_thickness+1);

    // inlet
    translate([inlet_x, -wall_thickness-.5, -wiring_area_height-psu_connector_depth])
      cube([inlet_width, wall_thickness+1, inlet_height]);
    translate([inlet_x - inlet_screw_offset_x, -wall_thickness-.5, -wiring_area_height-psu_connector_depth+inlet_screw_offset_z])
        rotate([-90,0,0])
          cylinder(r=inlet_screw_dia/2, h=wall_thickness+1);
    translate([inlet_x + inlet_width + inlet_screw_offset_x, -wall_thickness-.5, -wiring_area_height-psu_connector_depth+inlet_screw_offset_z])
        rotate([-90,0,0])
          cylinder(r=inlet_screw_dia/2, h=wall_thickness+1);

    // switch
    translate([switch_x, -wall_thickness-.5, -wiring_area_height-psu_connector_depth+switch_z])
      cube([switch_width, wall_thickness+1, switch_height]);

    // wire exit
    translate([wire_exit_x, psu_height-.5, -wiring_area_height-psu_connector_depth+wire_exit_height/2-.05])
      rotate([-90,0,0])
        hull() {
          cylinder(r=wire_exit_height/2, h=wall_thickness+1);
          translate([wire_exit_width,0,0])
            cylinder(r=wire_exit_height/2, h=wall_thickness+1);
        }

    // bottom tabs
    translate([-wall_thickness, -wall_thickness, -wiring_area_height - bottom_thickness - psu_connector_depth])
    bottom_tabs(play=1);
  }


}

module bottom() {
  translate([-wall_thickness, -wall_thickness, -wiring_area_height - bottom_thickness - psu_connector_depth]) union() {
    cube([psu_width + 2*wall_thickness, psu_height + 2*wall_thickness, bottom_thickness]);

    bottom_tabs();
  }
}

module bolt_hole_3mm(depth, center = false, chamfer = false){
  cylinder(h=depth, r=hole_3mm_bolt_r, centered = center);

  if(chamfer){
    // chamfer on outside edge
    cylinder(h=bolt3_cs_height, r1=bolt3_cs_wide_r, r2=bolt3_cs_narrow_r);
  }
}
module bottom_tabs(play=0) {
  translate([wall_thickness, wall_thickness + (psu_height - base_end_tab_length - play)/2, bottom_thickness])
    cube([base_tab_thickness, base_end_tab_length+play, base_tab_height+play/2]);

  translate([wall_thickness + psu_width - base_tab_thickness, wall_thickness + (psu_height - base_end_tab_length - play)/2, bottom_thickness])
    cube([base_tab_thickness, base_end_tab_length+play, base_tab_height+play/2]);

  translate([wall_thickness + base_side_tab_x - base_side_tab_length/2, wall_thickness, bottom_thickness])
    cube([base_side_tab_length, base_tab_thickness, base_tab_height]);


  translate([wall_thickness + base_side_tab_x - base_side_tab_length/2, wall_thickness + psu_height - base_tab_thickness, bottom_thickness])
    cube([base_side_tab_length, base_tab_thickness, base_tab_height]);
}

module bottom_holes() {
  translate([0, 0, -wiring_area_height - psu_connector_depth + base_tab_height/2]) {
    translate([base_side_tab_x, 0,0]) {
      translate([0,-wall_thickness-.01, 0])
        rotate([-90,0,0])
          bolt_hole_3mm(wall_thickness + base_tab_thickness+.5, chamfer=true);
      translate([-square_nut3_width/2, (base_tab_thickness-square_nut3_t)/2, -.01-bottom_thickness - base_tab_height/2])
        cube([square_nut3_width, square_nut3_t, (base_tab_height + square_nut3_width)/2 + bottom_thickness+.01]);

      translate([0,psu_height+wall_thickness+.01,0]) rotate([90,0,0])
        bolt_hole_3mm(wall_thickness + base_tab_thickness+.5, chamfer=true);
      translate([-square_nut3_width/2,psu_height-(base_tab_thickness+square_nut3_t)/2, -.01-bottom_thickness - base_tab_height/2])
        cube([square_nut3_width, square_nut3_t, (base_tab_height + square_nut3_width)/2 + bottom_thickness+.01]);

    }

    translate([0, psu_height/2,0]) {
      translate([-wall_thickness-.01, 0, 0])
        rotate([-90,0,-90]) bolt_hole_3mm(wall_thickness + base_tab_thickness + .5, chamfer=true);

      translate([(base_tab_thickness - square_nut3_t)/2, -square_nut3_width/2, -.01-bottom_thickness - base_tab_height/2])
        cube([square_nut3_t, square_nut3_width, (base_tab_height + square_nut3_width)/2 + bottom_thickness + .01]);

      translate([psu_width+wall_thickness+.01, 0, 0])
        rotate([-90,0,90]) bolt_hole_3mm(wall_thickness + base_tab_thickness + .5, chamfer=true);

      translate([psu_width -(base_tab_thickness+square_nut3_t)/2, -square_nut3_width/2, -.01-bottom_thickness - base_tab_height/2])
        cube([square_nut3_t, square_nut3_width, (base_tab_height + square_nut3_width)/2 + bottom_thickness + .01]);
    }
  }
}

if(render_psu) psu();
difference() {
  union() {
    if(render_base) color("darkgreen") base();
    if(render_bottom) color("hotpink") bottom();
  }
  bottom_holes();
}
