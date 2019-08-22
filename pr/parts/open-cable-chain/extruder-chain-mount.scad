// This part is highly specific to my Solidoodle 2.
//
// Complicated remix of the filament guide from the mk5 jigsaw replacement.
// Add elaborate infrastructure to mount a cable chain up in the air so
// it can operate above the top of the case.

chain_end_height=22.43; // height when it is mounted on its side, that is.
chain_end_x=13.27;      // thickness in X direction as mounted on carriage
chain_end_y=36.41;      // length in Y direction as mounted on carriage
chain_hinge_y=9.36;     // length of hinge piece on end of Y direction

chain_end_hole_dia=3.4; // diameter of holes for mounting chain end
chain_end_hole_sep=10;  // center to center distance between holes
chain_end_hole_y=20.98; // distance to first hole from hinge end
chain_end_hole_z=11.22; // distance above mount to hole centers

extruder_to_case=18.33-6.10; // top of motor to top of case
case_to_chain=29.5-(chain_end_height/2); // height of back clip that works OK

cable_end_height=case_to_chain+extruder_to_case;

filament_guide_bolt=31.50; // X distance where bolt holder starts on guide

// X,Y location of center of filament hole and diameter of hole.
filament_hole_x=25.62;
filament_hole_y=-3.95;
filament_hole_dia=4;

// Size of M3 nut for nut trap (plus a bit of slop)
//
m3_width=5.47+0.2;      // flat to flat width of M3 nut
m3_thick=2.22+0.2;      // thickness of M3 nut

// Dimensions of the microswitch (in pixels at 600DPI)
//
ptmm = 0.04233333;
switch_z=204;
switch_y=286;
switch_hight=476*ptmm;
switch_depth=244*ptmm;
lever_below_switch=46*ptmm;

bot_hole_w=59;
bot_hole_h=60;
top_hole_w=61;
top_hole_h=63;
switch_avg_hole=((top_hole_w+top_hole_h+bot_hole_w+bot_hole_h)/4);
switch_avg_rad=switch_avg_hole/2;

top_hole_z=switch_hight-((295+switch_avg_rad-switch_z)*ptmm);
top_hole_y=switch_depth-((438+switch_avg_rad-switch_y)*ptmm);
bot_hole_z=switch_hight-((520+switch_avg_rad-switch_z)*ptmm);
bot_hole_y=switch_depth-((438+switch_avg_rad-switch_y)*ptmm);
switch_thick=6.48;

// Approx distance in front of switch where roller and lever will trigger
// the switch.
//
switch_engage_distance=0.5+(144*ptmm);

// back is mounted in 4th hole down from top.

// Make a slot shaped object h heigh, r radius ends, w width slot
//
module make_slot(h,r,w) {
   union() {
      translate([-r, -w/2, 0])
         cube([2*r, w, h]);
      translate([0,-w/2,0])
         cylinder(h=h, r=r, $fn=64);
      translate([0,w/2,0])
         cylinder(h=h, r=r, $fn=64);
   }
}

// Model the entire switch so I can look at it to see if it looks right,
// but union in the holes so I can subtract them from mount once I position
// the switch.
module switch_model() {
   translate([0,0,lever_below_switch])
   union() {
      cube([switch_thick, switch_depth, switch_hight]);

      // Small slots for the screws in the mounting to allow position
      // adjustment
      translate([-25,top_hole_y,top_hole_z])
         rotate([0,90,0])
            make_slot(switch_thick+50, switch_avg_rad*ptmm, 2);
      translate([-25,bot_hole_y,bot_hole_z])
         rotate([0,90,0])
            make_slot(switch_thick+50, switch_avg_rad*ptmm, 2);

      // Large slots to allow screwdriver access
      translate([0,top_hole_y,top_hole_z])
         rotate([0,90,0])
            make_slot(switch_thick+50, 3, 2);
      translate([0,bot_hole_y,bot_hole_z])
         rotate([0,90,0])
            make_slot(switch_thick+50, 3, 2);
   }
}

// Position original filament guide for easy alignment with parts
// I'll be adding to it.
//
module bottom_filament_guide() {
   translate([-59.24, -(66.60+16.80-6.3), -10])
      import("mk5_extruder_filament_guide_fixed.stl");
}

// A module to produce a rounded corner for unioning on inside corners and
// differencing on outside corners...
//
// Give it 0.1mm of extended faces on the square side so it will properly
// merge with the model when unioned into position.
//
module corner_round(h,r) {
   difference() {
      translate([0,-0.1,-0.1])
         cube([h,r+0.1,r+0.1]);
      translate([-1,r,r])
         rotate([0,90,0])
            cylinder(h=h+2,r=r,$fn=64);
   }
}

// Cut the bits off the filament guide we don't need on the top part.
//
module top_filament_guide() {
   difference() {
      union() {
         bottom_filament_guide();
         // fill in the cylinder segment on  the bottom - the top guide
         // doesn't need to avoid hitting the stepper motor.
         translate([0,0,-10])
            cube([filament_guide_bolt, 6.3, 10]);
      }

      // Clip off the end where the bolt head is held.
      translate([filament_guide_bolt, -250, -250])
         cube([500,500,500]);

      // Clip off the other end to fit within vertical wall
      translate([-1,-250,-250])
         cube([1+chain_end_x,500,500]);

      // round front outer corner
      translate([31.50,-10.5,1])
         rotate([0,0,90])
            rotate([0,90,0])
               corner_round(12,4);

      // round back outer corner
      translate([31.50,6.3,1])
         rotate([0,0,180])
            rotate([0,90,0])
               corner_round(12,4);
   }
}

// Handy hexnut shape
//
module hexnut(nutwidth, nutthick) {
   intersection() {
      translate([-nutwidth,-(nutwidth/2),0])
         cube([nutwidth*2,nutwidth,nutthick]);

      rotate([0,0,60])
         translate([-nutwidth,-(nutwidth/2),0])
            cube([nutwidth*2,nutwidth,nutthick]);

      rotate([0,0,120])
         translate([-nutwidth,-(nutwidth/2),0])
            cube([nutwidth*2,nutwidth,nutthick]);
   }
}

// A pair of holes with hexnut traps for M3 nuts positioned 10mm apart
// to match mounting holes in the chain end piece.
//
module mounting_holes() {
   union() {
      translate([0,0,-50])
         hexnut(m3_width, m3_thick+50);
      cylinder(h=50,r=chain_end_hole_dia/2, $fn=16);
      translate([0,10,0])
         union() {
            translate([0,0,-50])
               hexnut(m3_width, m3_thick+50);
            cylinder(h=50,r=chain_end_hole_dia/2, $fn=16);
         }
   }
}

module ziptie_bar() {
   translate([0,2.5+(9+2)/2,0])
   difference() {
      translate([-9/2,-(6+2),0])
         cube([9,25,2]);
      translate([0,0,-1])
         make_slot(5,3,3);
      translate([0,9+2,-1])
         make_slot(5,3,3);
   }
}

difference() {
   // Put together all the structure for the mount
   union() {
      // Start with original mk5 filament guide
      bottom_filament_guide();

      // add in a big vertical wall that squares off and raises the end
      translate([0,0,-10])
         difference() {
            cube([10,6.3,cable_end_height+10]);
            // make a hole in the vertical wall so the original screw holes
            // won't be blocked up.
            translate([5,-1,5])
               rotate([-90,0,0])
                  cylinder(h=10,r=4,$fn=16);
         }

      // Add in the platform the chain end will rest on
      translate([0,0,0])
         cube([13.27+5,chain_end_y-chain_hinge_y,cable_end_height]);

      // Add in the wall the back of the chain end will be bolted to
      translate([13.27,0,0])
         cube([5,chain_end_y-chain_hinge_y,cable_end_height+chain_end_height]);

      // Add the top filament guide raised to very top of mount so filament
      // won't get caught on some random place on the mount
      translate([0,0,cable_end_height+chain_end_height])
         top_filament_guide();

      // Add wall for mounting microswitch
      translate([filament_hole_x+switch_thick/2,0,0])
         cube([3.6, switch_depth+7, switch_hight+lever_below_switch+2]);
      translate([10,0,0])
         cube([20, switch_depth+7, 2]);

      // Add bar for holding zip ties
      ziptie_bar();

      // And a vertical one as well
      translate([0,2,0])
         rotate([90,0,0])
            ziptie_bar();

      // And what the heck, another around back
      translate([13.27+5,chain_end_y-chain_hinge_y,0])
         rotate([0,0,90])
            translate([0,2,0])
               rotate([90,0,0])
                  ziptie_bar();

   }

   // Subtract off the holes and nut traps for mounting the chain end
   translate([5+13.27,
              chain_end_hole_y-chain_hinge_y,
              cable_end_height+chain_end_hole_z])
      rotate([0,-90,0])
         mounting_holes();

   // Subtract off switch mounting holes
   translate([filament_hole_x+(switch_thick/2),
               (switch_depth+filament_hole_y)+((1.75/2)+switch_engage_distance),
               2])
      rotate([0,0,180])
         switch_model();
}

// TODO - Measure actual height I need it to be (extruder below case frame,
// case frame up to level of back end cable end).
