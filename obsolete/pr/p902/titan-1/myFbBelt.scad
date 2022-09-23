// how many teeth on each side
teeth = 8;

// width of the belt in mm incl clearance (use 6.25 for typical GT2 belt)
belt_width = 6.5;

// thickness of the belt in mm (use 1.5 for GT2 belt)
belt_thickness = 1.5;

// belt pitch in mm (use 2.0 for GT2 belt)
pitch = 2.0;

// this controls the strength of the bracket 
shell = 1.5;

/* [Hidden] */
cutout_width = 6 + belt_thickness + shell;
len = 2*teeth*pitch + cutout_width;
round_corner_epsilon = 1;
epsilon = 0.01;


module clipTop()
{
    difference()
    {
      translate([-4,0,0])
    cube([44,3,18]);
 
    translate([5.5,1,3])
    rotate([90,0,0])
    cylinder(r=1.66, h=10, center=true);
    
    translate([32.5,1,3])
    rotate([90,0,0])
    cylinder(r=1.66, h=10, center=true);

    translate([10,0,0])
    cube([17.5,3,10]);
    }
}

module clipBottom()
{
     difference()
    {
        union()
        {
    translate([-4,-2.5,15])      
    cube([44,6,3]); 
    translate([-4,-0.5,7])       
    cube([44,4,8]);
    
    translate([20,-3,11])
    // belt teeth
	for(i=[1:1:teeth]) {

		// left side
		color([1,0, 0])
		translate([len/2 + pitch/4 - i*pitch, shell + belt_thickness/2, 0])
			cube([pitch/2, belt_thickness + epsilon, belt_width], center=true);

		// right side 
		color([1,0, 0])
		translate([-len/2 - pitch/4 + i*pitch, shell + belt_thickness/2, 0])
			cube([pitch/2, belt_thickness + epsilon, belt_width], center=true);
	};
}
  

  //  translate([10,0,0])
 //   cube([15.5,3,15]);
}
}

clipTop();
translate([0,5,0])
clipBottom();