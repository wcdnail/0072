
//  SKR 1.3 PCB  Holder for 2020 extrusion
// 
//  Creative Commons - Attribution - No Derivatives license.
//  Edward Braiman
//
//  Created 5/18/2019
//  modified by TBD

// Variables Begin
length = 109.7;
width = 83.4;
HoleSpace = 3.5;
xWall = 5;
HR = 30;
M3 = 3.0;
M3BT = 8;
M4 = 4.2;
xLW = 20.5;
// Expansions
widthExtra=10;

// Variables End

// Main Begin
SKR_1_3();

// Main End
module SKR_1_3(sovietVerion=true) {
    difference() {
        union() {
            translate([-10,-10,0])
                minkowski() {
                    translate([-widthExtra/2, 0, 0]) cube([width+20+widthExtra,length+20,xWall/2]);
                    cylinder(d=2,h=xWall/2,$fn=HR);
                }
           // rail 
           translate([width,xLW+length,0])
                rotate([0,0,180])
                    rail_edge();
            // Standoff Begin
            Standoff(width-HoleSpace,length-HoleSpace,xWall);
            Standoff(HoleSpace,length-HoleSpace,xWall);
            Standoff(width-HoleSpace,HoleSpace,xWall);         
            Standoff(HoleSpace,HoleSpace,xWall);            
            // Standoff End
        }
        // Secure holes Begin
        // Bottom Right
        translate([width-HoleSpace,length-HoleSpace,0]) cylinder(d=M3,h=xWall,$fn=HR);
        // Top Right
        translate([HoleSpace,length-HoleSpace,0]) cylinder(d=M3,h=xWall,$fn=HR); 
         // Bottom Left
        translate([width-HoleSpace,HoleSpace,0]) cylinder(d=M3,h=xWall,$fn=HR);
        // Top Left
        translate([HoleSpace,HoleSpace,0]) cylinder(d=M3,h=xWall,$fn=HR);
         // Secure holes End   
        
        // Remove Material Begin
        if (sovietVerion) {
            color("Red") translate([width/2-2, length/2+2, -30]) scale([0.7, 0.7, 10]) mirror([1, 1, 0]) import("../sm.stl");
        }
        else {
            translate([width/2,length/2,-4]) cylinder(d=width*.55,h=xWall+10,$fn=HR);
        }
        translate([width*.20,length*.15,-4]) cylinder(d=width*.25,h=xWall+10,$fn=HR);
        translate([width*.20,length*.85,-4]) cylinder(d=width*.25,h=xWall+10,$fn=HR);
        translate([width*.8,length*.15,-4]) cylinder(d=width*.25,h=xWall+10,$fn=HR);
        translate([width*.8,length*.85,-4]) cylinder(d=width*.25,h=xWall+10,$fn=HR);        
        // Remove Material End
   
        // Auxiliary part holder holes Begin
        translate([width+4,length*.75,-4]) cylinder(d=M3,h=xWall+10,$fn=HR);
        translate([width+4,length*.50,-4]) cylinder(d=M3,h=xWall+10,$fn=HR);
        translate([width+4,length*.25,-4]) cylinder(d=M3,h=xWall+10,$fn=HR);        
        translate([-4,length*.75,-4]) cylinder(d=M3,h=xWall+10,$fn=HR);
        translate([-4,length*.50,-4]) cylinder(d=M3,h=xWall+10,$fn=HR);
        translate([-4,length*.25,-4]) cylinder(d=M3,h=xWall+10,$fn=HR);        
        // Auxiliary part holder holes End        
    }
}

module rail_edge() {
    difference() {
        union() {
            cube([width,xLW,xLW]);
            translate([0,0,xLW/2]) rotate([0,90,0]) cylinder(d=7,h=width,$fn=HR);
        }
        hull() {
            translate([0,15,xLW]) rotate([0,90,0]) cylinder(d=xLW,h=width,$fn=HR);
            translate([0,15,15]) rotate([0,90,0]) cylinder(d=xLW,h=width,$fn=HR);
            translate([0,20,15]) rotate([0,90,0]) cylinder(d=xLW,h=width,$fn=HR);
        }
        // Remove secure holes Begin
        translate([width*.25,-(7/2),xLW/2]) rotate([270,0,0]) cylinder(d=M4,h=10,$fn=HR);
        translate([width*.25,2,xLW/2]) rotate([270,0,0]) cylinder(d=M3BT,h=10,$fn=HR);
        translate([width*.25-13/2,-7,0]) cube([13,7,xLW]); 
        translate([width*.75,-(7/2),xLW/2]) rotate([270,0,0]) cylinder(d=M4,h=10,$fn=HR);
        translate([width*.75,2,xLW/2]) rotate([270,0,0]) cylinder(d=M3BT,h=10,$fn=HR); translate([width*.75-13/2,-7,0]) cube([13,7,xLW]);
    }
}

module Standoff(x,y,z)
{
    difference() {
        translate([x,y,z]) cylinder(d=xWall+2,h=xWall+1,$fn=HR);
        translate([x,y,z]) cylinder(d=M3,h=xWall+1,$fn=HR);
    }
}

%rotate([0, 0, 90]) translate([0, 0.5, 15]) import("120mm_skr13_mount_2.stl");
