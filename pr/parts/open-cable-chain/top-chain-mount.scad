// This part is pretty specific to my Solidoode 2
//
// It uses the filament guide from http://www.thingiverse.com/thing:111213
//
// Modification of my caseclip part (for foamboard case) to clip to the
// top of the case and provide a place to attach a cable chain and run the
// wires over the top of the case and down the back. (The names of lots of things
// in here are leftover from the foamboard code I copied).

include <new-chain.scad>

// Outside diameter of the flexible conduit I want to use in some vertical
// pieces.
//
conduitOD=20;

// From the front edge of the sheet metal to the back of the solidoodle
// looks real close to 45.5mm (ACK! For some reason, I came out 28mm too
// long, so until I can find my error, just take 28 off sheetmetal).
//
sheetmetal=38.26;

// The clip, shoved all the way on to the sheetmetal will go 17.14 mm
// into the clip before the edge of the metal hits the back of the clip.
//
clipback=17.14;

// The space required to mount a chain end sitting on it's side.
//
chain_end_width=13.28;

// bars is the thickness of the other bars making up the clip.
//
bars = 3;

// leadingtooth is the gap between the middle bar and the leading tooth
// that sticks down from the top bar. Was 0.4
//
leadingtooth = 0.2;

// trailingtooth is the gap between the middle bar and the innermost
// tooth that sticks down from the top bar. Was 0.85, then 0.5
//
trailingtooth = 0.35;

// channel is the width of the channel the steel case runs through.
channel=2.25;

// middlebar is the thickness of the middle bar which determines how far off
// the steel frame the foamboard will be held. This should be large enough
// to clear the end of any rods, bolt heads, rivets, etc which stick out of
// the frame.
//
middlebar = 4;

// longedge is the longest edge that clips to the side of the frame.
//
longedge = 20.75;

// shortedge is the shortest bar that holds the edge of the foamboard.
//
shortedge = 15;

// exactfoam is the exact thickness of the foamboard which determine the space
// allowed to make a press fit for small strips of foamboard to fit under on the
// corners.
//
exactfoam = 5.2;

// Thickness of the foamboard for things that should not be a tight fit.
//
foamboard=exactfoam+1;

// clipheight is the height of the clip (too big and there are places it won't
// fit on the frame). I made the bottom, left, and right clips 20mm high
// and the short clips 10mm high.
//
clipheight = 31.75;

cornerad=bars;

toothyinc = (trailingtooth - leadingtooth) / 6.0;
toothxinc = (channel + 0.25);

firstoothy = (bars+foamboard+middlebar+channel+(channel/2.0))-(channel-trailingtooth);
firstoothx = (bars/2.0);

extra=sheetmetal+conduitOD+chain_end_width;
chain_end_height=22.43; // height when it is mounted on its side, that is.
case_to_chain=29.5-(chain_end_height/2); // height of back clip that works OK

// Bit of corner to subtract from square shaped clip to round edges.
//
module cornerclip() {
   intersection() {
      difference() {
         translate([-cornerad, -cornerad,0])
            cube([cornerad*2,cornerad*2,clipheight+2]);
         translate([0,0,-2])
            cylinder(h=clipheight+4,r=(cornerad),$fn=20);
      }
      translate([0,0,-3])
         cube([cornerad*2,cornerad*2,clipheight+6]);
   }
}

// A squared off clip
//
module squareclip()
{
   difference() {
      union() {
         // thick middle bar rests on outside of case
         translate([0,foamboard+bars,0])
            cube([longedge,middlebar,clipheight]);
         // bar on inside of case that "teeth" are attached to
         translate([0,bars+foamboard+middlebar+channel,0])
            cube([longedge,bars,clipheight]);
         // top bar
         translate([shortedge,bars+foamboard,0])
            cube([longedge-shortedge,middlebar+bars+channel,clipheight]);
         // cylinders for the teeth (should make this a for loop)
         translate([firstoothx,firstoothy,0])
            cylinder(h=clipheight,r=(channel/2.0));
         translate([firstoothx+toothxinc,firstoothy+toothyinc,0])
            cylinder(h=clipheight,r=(channel/2.0));
         translate([firstoothx+2*toothxinc,firstoothy+2*toothyinc,0])
            cylinder(h=clipheight,r=(channel/2.0));
         translate([firstoothx+3*toothxinc,firstoothy+3*toothyinc,0])
            cylinder(h=clipheight,r=(channel/2.0));
         translate([firstoothx+4*toothxinc,firstoothy+4*toothyinc,0])
            cylinder(h=clipheight,r=(channel/2.0));
         translate([firstoothx+5*toothxinc,firstoothy+5*toothyinc,0])
            cylinder(h=clipheight,r=(channel/2.0));
      }
      // hole at top of channel to make it more flexible
      translate([shortedge+0.75,bars+foamboard+middlebar+(channel/2.0),-1])
         cylinder(h=clipheight+2,r=(bars+0.75)/2.0, $fn=20);
   }
}

// Clip with rounded corners
//
module roundclip() {
   translate([0,-(foamboard+bars),0])
      difference() {
         squareclip();
         translate([longedge-(cornerad),bars+foamboard+middlebar+channel,-1])
            cornerclip();
         translate([longedge-(cornerad),bars+foamboard+cornerad-0.01,-1])
            rotate([0,0,-90])
               cornerclip();
      }
}

difference() {
   union() {
      // Start with the basic short clip for grabbing sheet metal
      roundclip();

      // Extend the top to go all the way across the sheet metal in the
      // back of the case flush with the back outside (I can't for the life
      // of me figure out why I need the -0.34 here to make the ends line up,
      // obviously I can't spot where my arithmetic goes bad :-).
      translate([-(extra-clipback-0.34),0,0])
         difference() {
            cube([(extra-clipback)+1,middlebar,clipheight]);
            // Punch some big holes that will later be filled in with smaller
            // holes when I add in the projection of the end piece
            translate([7,25,13]) rotate([90,0,0]) cylinder(h=50,r=3,$fn=16);
            translate([7,25,23]) rotate([90,0,0]) cylinder(h=50,r=3,$fn=16);
         }

      // Add in a projection of the side of the cable end to get the cable
      // end up to the desired height.
      translate([-(extra-clipback),middlebar,0])
         rotate([90,0,0])
            linear_extrude(height=case_to_chain)
               projection(cut=true)
                  translate([0,-(38.81-28.42),0.1])
                     rotate([0,90,0])
                        end2();
   }

   translate([-((sheetmetal-clipback) + conduitOD/2),-1,clipheight/2])
      rotate([-90,0,0])
         cylinder(h=10,r=conduitOD/2,$fn=64);
}
