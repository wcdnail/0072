// Newhaven Display NHD-1.69-160128UGC3
//
// Copyright (c) 2018 Leandro Barajas
//
// The MIT License (MIT)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do
// so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
// NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
/*Customizer Variables*/
Pins_enabled = 1;//[0:1]
Pins_up = 0;//[0:1]

// Other Variables

// Units in mm
PCBWidth    = 45;
PCBHeight   = 52;
PCBThickness= 1.0;

LCDWidth    = 35;
LCDHeight   = 28;
LCDBzWidth  = 40.9;
LCDBzHeight = 35;
Pitch       = 2.54;
$fn         = 36;

module Pins(Pins_number,Pitch)
{
	translate([0,-Pitch*Pins_number/2,0])
	for(a=[0:1:Pins_number-1])
	{
		color("Goldenrod")
			translate([0,Pitch*a,-3])
				cube([0.6,0.6,10],center=true);
		
		color("Silver")
			translate([0,Pitch*a,-1.5])
				cylinder(r1=0,r2=1,h=1);
		
		color("Silver")
			translate([0,Pitch*a,0.5])
				cylinder(r1=1,r2=0,h=1);
		
		color("Black")
			translate([0,Pitch*a,-2])
				Component(2,2,1.25);
	}
}

module Pins_holes(Pins_number,Pitch,Diameter)
{
	translate([0,-Pitch*Pins_number/2,0])
	for(a=[0:1:Pins_number-1])
	{
		color("Goldenrod")
			translate([0,Pitch*a,-3])
				cylinder(r=Diameter/2,h=10,center=true);
	}
}

module Pins_copper_rings(Pins_number,Pitch,Diameter)
{
	translate([0,-Pitch*Pins_number/2,0])
	for(a=[0:1:Pins_number-1])
	{
		color("Goldenrod")
			translate([0,Pitch*a,0])
				cylinder(r=Diameter/2,h=PCBThickness+0.1,center=true);
	}
}

module Component(X,Y,Z)
{
	hull()
	{
		translate([X/2,Y/2,0])
			sphere(r=0.25,$fn=18);
		translate([-X/2,Y/2,0])
			sphere(r=0.25,$fn=18);
		translate([X/2,-Y/2,0])
			sphere(r=0.25,$fn=18);
		translate([-X/2,-Y/2,0])
			sphere(r=0.25,$fn=18);

		translate([X/2,Y/2,Z-0.25])
			sphere(r=0.25,$fn=18);
		translate([-X/2,Y/2,Z-0.25])
			sphere(r=0.25,$fn=18);
		translate([X/2,-Y/2,Z-0.25])
			sphere(r=0.25,$fn=18);
		translate([-X/2,-Y/2,Z-0.25])
			sphere(r=0.25,$fn=18);
	}
}


module OLED_169_160_128(Pins_enabled,Pins_up)
{
	rotate([0,0,-90])
	difference()
	{
		union()
		{
			// PCB
			color("Royalblue")
				cube([PCBHeight,PCBWidth,PCBThickness]);

			// Copper Rings

			// Pin 1 square pad
			translate([Pitch,11.07,PCBThickness/2])
				rotate([0,180,0])
					color("Goldenrod") 
						cube([1.8,1.8,PCBThickness+0.1],center=true);

			translate([Pitch,PCBWidth/2+Pitch/2,PCBThickness/2])
				rotate([0,180,0])
					Pins_copper_rings(10,Pitch,1.8);

			translate([2*Pitch,PCBWidth/2+Pitch/2,PCBThickness/2])
				rotate([0,180,0])
					Pins_copper_rings(10,Pitch,1.8);	

			// Mounting Holes Pads
			color("silver")
				translate([3.5,3.5,-0.05])
					rotate([0,0,0])
						cylinder(d=2.5+0.5,h=PCBThickness+0.1);
			
			color("silver")
				translate([3.5,PCBWidth-3.5,-0.05])
					rotate([0,0,0])
						cylinder(d=2.5+0.5,h=PCBThickness+0.1);
			
			color("silver")
				translate([PCBHeight-3,3.5,-0.05])
					rotate([0,0,0])
						cylinder(d=2.5+0.5,h=PCBThickness+0.1);
			
			color("silver")
				translate([PCBHeight-3,PCBWidth-3.5,-0.05])
					rotate([0,0,0])
						cylinder(d=2.5+0.5,h=PCBThickness+0.1);

			// LCD Bezel
			difference()
			{
				color("Gray")
					translate([LCDBzHeight/2+52-(35+8.5),LCDBzWidth/2+2.05,PCBThickness+2.1])
						rotate([0,180,90])
							Component(LCDBzWidth,LCDBzHeight,2.1);
				
				// LCD Bezel Inset
				color("Gray")
					translate([PCBHeight-LCDHeight/2-13.5,LCDWidth/2+5,PCBThickness+2.1*2])
						rotate([0,180,90])
							Component(LCDWidth,LCDHeight,3);
			}
			// LCD
			color("Black")
				translate([PCBHeight-LCDHeight/2-13.5,LCDWidth/2+5,PCBThickness+2.1-1/2])
					rotate([0,180,90])
						Component(LCDWidth,LCDHeight,2);
		}

		// Pin Holes
		translate([Pitch,PCBWidth/2+Pitch/2,0.5])
			rotate([0,180,0])
				Pins_holes(10,Pitch,1.0);
		
		translate([2*Pitch,PCBWidth/2+Pitch/2,0.5])
			rotate([0,180,0])
				Pins_holes(10,Pitch,1.0);

		// LCD Text
		color("white")
			translate([20,12,PCBThickness*2])
				rotate([0,0,90])
					linear_extrude(1)
						text("OLED 1.69\"",size=3);
		
		color("white")
			translate([30,13+2,PCBThickness*2])
				rotate([0,0,90])
					linear_extrude(1)
						text("160x128",size=3);

		// PCB Text
		color("white")
			translate([PCBHeight-5,14,PCBThickness-0.005])
				rotate([0,0,90])
					linear_extrude(1)
						text("Newhaven Display",size=1.5);

		color("white")
			translate([PCBHeight-2,9,PCBThickness-0.005])
				rotate([0,0,90])
					linear_extrude(1)
						text("NHD-1.69-160128UGC3",size=1.5);
		
		// Mounting Holes
		color("silver")
			translate([3.5,3.5,-1])
				rotate([0,0,0])
					cylinder(d=2.5,h=10);
		color("silver")
			translate([3.5,PCBWidth-3.5,-1])
				rotate([0,0,0])
					cylinder(d=2.5,h=10);
		
		color("silver")
			translate([PCBHeight-3,3.5,-1])
				rotate([0,0,0])
					cylinder(d=2.5,h=10);
		
		color("silver")
			translate([PCBHeight-3,PCBWidth-3.5,-1])
				rotate([0,0,0])
					cylinder(d=2.5,h=10);
	}

	if(Pins_enabled==1 && Pins_up==0)
	{
		rotate([0,0,-90])
			translate([Pitch,PCBWidth/2+Pitch/2,PCBThickness/2])
				Pins(10,Pitch);
			
		rotate([0,0,-90])
			translate([2*Pitch,PCBWidth/2+Pitch/2,PCBThickness/2])
				Pins(10,Pitch);
	}
	
	if(Pins_enabled==1 && Pins_up==1)
	{
		rotate([0,180,-90])
			translate([-Pitch,PCBWidth/2+Pitch/2,-PCBThickness/2])
				Pins(10,Pitch);
		
		rotate([0,180,-90])
			translate([-2*Pitch,PCBWidth/2+Pitch/2,-PCBThickness/2])
				Pins(10,Pitch);
	}

}

OLED_169_160_128(Pins_enabled,Pins_up);