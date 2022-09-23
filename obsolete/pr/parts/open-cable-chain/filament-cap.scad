// A cap to fit on the top filament guide to prevent the filament from being
// dragged out of the slot.

center_x = 7.5;
center_y = -4;
dia=4;
tordia=3;
capheight=13;

// Just the interesting bits of the top filament guide.
module top_bits() {
   translate([-(13.27+5),0,0])
      difference() {
         translate([0,0,-(52.96-10)])
            import("extruder-chain-mount.stl");
         translate([-250,-250,-500])
            cube([500,500,500]);
      }
}

// Make a nice smooth torus opening for the filament
module guide_cap() {
   translate([0,0,capheight-tordia/2])
   union() {
      // Nice smooth torus shape for filament opening
      rotate_extrude(convexity=10, $fn=64)
         translate([dia/2 + tordia/2,0,0])
            circle(r=tordia/2, $fn=64);
      // Cylinder so we just get the inner half of the torus.
      difference() {
         translate([0,0,-capheight+tordia/2])
            cylinder(h=capheight,r=(dia+2*tordia)/2,$fn=64);
         cylinder(h=tordia/2,r=(dia+tordia)/2,$fn=64);
      }
   }
}

// A slightly larger than life filament guide with the filament opening
// filled in.
module minus_bits() {
   scale([1.05,1.05,1.00])
      difference() {
         union() {
            render() translate([-center_x, -center_y, 0])
               top_bits();
            cylinder(h=10,r=5.7,$fn=64);
            translate([-6.3,0,0])
               cube([3,6,10]);
         }
         translate([-(50+7.4),-50,-1])
            cube([50,100,50]);
      }
}

// A much larger than life filament guide we'll subtract minus_bits from to
// leave a filament guide shaped hole.
module plus_bits() {
   scale([1.3,1.25,1.2])
      difference() {
         union() {
            render() translate([-center_x, -center_y, 0])
               top_bits();
            cylinder(h=10,r=5.7,$fn=64);
            translate([-6.3,0,0])
               cube([3,6,10]);
         }
         translate([-(50+6.2),-50,-1])
            cube([50,100,50]);
      }
}

// Take plus bits, subtract off a cyliner to leave room for guide_cap,
// add in guide cap, subtract off minus_bits and extra space for the
// bar the filament guide is mounted on.
module filament_cap() {
   rotate([0,180,0])
      difference() {
         union() {
            difference() {
               plus_bits();
               cylinder(h=capheight,r=((dia+2*tordia)/2)-0.1,$fn=64);
            }
            translate([0,0,-1])
               guide_cap();
         }
         union() {
            minus_bits();
            // project the bar sticking out long enough to intersect plus_bits
            // even after it is scaled up.
            translate([1,0,0])
            rotate([0,-90,0])
            translate([0,0,7])
            linear_extrude(h=20)
            projection(cut=true)
            translate([0,0,-7])
            rotate([0,90,0])
            minus_bits();
         }
         // subtract off junk sticking out of bottom
         translate([-50,-50,-99.9])
            cube([100,100,100]);
         // subtract off hole for filament
         translate([0,0,-1])
            cylinder(h=50,r=dia/2,$fn=64);
         // subtract off new slot on other side
         translate([0,-1,-1])
            cube([20,2,20]);
      }
}

// Not much space available on left side, so trim down the cap piece to fit
difference() {
   filament_cap();
   translate([7.66,-25,-25])
      cube([50,50,50]);
}
