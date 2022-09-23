// Remix the cable chain http://www.thingiverse.com/thing:11978 to
// remove the fixed bar across the top and replace it with holes where
// short pieces of 1.75mm filament can be glued to provide a cable
// chain where individual cables can be removed and added at will.

// Extract one end piece from the stl and translate to origin.
//
// The top bar is 11.38mm up, 1.89mm high
//             is 10.34mm to 13.52mm in Y direction (3.18mm thick)
//             is 4.78mm to 17.65mm in X direction (12.87mm long)
//
module end1() {
   translate([23.78, 17.85, -0.01])
      difference() {
         import("CableChainEnds_fixed.stl");
         translate([0,-250,-1])
            cube([500,500,500]);
      }
}

// Extract other end piece from the stl.
//
// The top bar is 11.38mm up, 1.89mm high
//             is 12.75mm to 15.93mm in Y direction (3.18mm thick)
//             is 4.78mm to 17.65mm in X direction (12.87mm long)
//
module end2() {
   translate([22.43, 38.81, 0])
      rotate([0,0,180])
         translate([-1.35, 19.41, 0])
            difference() {
               import("CableChainEnds_fixed.stl");
               translate([-500,-250,-1])
                  cube([500,500,500]);
            }
}

// Translate one chain link to origin. The bar in this is at same position
// relative to origin as the bar in end1().
//
module chain() {
   translate([11.22, 13.13, 0])
      import("CableChain.stl");
}

// end1() with the top bar removed and holes for 1.75mm filament added
//
module nobar_end1() {
   difference() {
      end1();
      translate([4.78, 10.34-1, 8])
         cube([12.87,5.18,50]);
      translate([-1,11.93,11.495])
         rotate([0,90,0])
            cylinder(h=50,r=1.75/2,$fn=32);
   }
}

// end2() with the top bar removed and holes for 1.75mm filament added
//
module nobar_end2() {
   difference() {
      end2();
      translate([4.78, 12.75-1, 8])
         cube([12.87,5.18,50]);
      translate([-1,14.34,11.495])
         rotate([0,90,0])
            cylinder(h=50,r=1.75/2,$fn=32);
   }
}

// chain() with the top bar removed and holes for 1.75mm filament added
//
module nobar_chain() {
   difference() {
      chain();
      translate([4.78, 10.34-1, 8])
         cube([12.87,5.18,50]);
      translate([-1,11.93,11.495])
         rotate([0,90,0])
            cylinder(h=50,r=1.75/2,$fn=32);
   }
}

// Print 4 chain pieces rotated in 4 different directions
//
module nobar_four() {
   translate([26.76, 26.76, 0])
      union() {
         translate([0.5,0.5,0])
            nobar_chain();
         rotate([0,0,90])
            translate([0.5,0.5,0])
               nobar_chain();
         rotate([0,0,180])
            translate([0.5,0.5,0])
               nobar_chain();
         rotate([0,0,270])
            translate([0.5,0.5,0])
               nobar_chain();
      }
}

// Print 16 chain pieces
//
module nobar_sixteen() {
   union() {
      translate([0.5,0.5,0])
         nobar_four();
      rotate([0,0,90])
         translate([0.5,0.5,0])
            nobar_four();
      rotate([0,0,180])
         translate([0.5,0.5,0])
            nobar_four();
      rotate([0,0,270])
         translate([0.5,0.5,0])
            nobar_four();
   }
}

// Print both end pieces
//
module end_two() {
   union() {
      translate([0.5,0,0])
         nobar_end1();
      translate([0,38.81,0])
         rotate([0,0,180])
            translate([0.5,0.5,0])
               nobar_end2();
   }
}
