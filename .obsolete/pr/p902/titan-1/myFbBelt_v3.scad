// how many teeth on each side
teeth = 8;

// width of the belt in mm incl clearance (use 6.25 for typical GT2 belt)
belt_width = 7.5;

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
      
    cube([40,4,18]);
 
    translate([5.5,1,3])
    rotate([90,0,0])
    cylinder(r=1.66, h=10, center=true);
    
    translate([32.5,1,3])
    rotate([90,0,0])
    cylinder(r=1.66, h=10, center=true);

    translate([10,0,0])
    cube([15.5,6,15]);
        
         translate([0,-5.0,8.5])
          cube([40,6.5,7.0]); 
   
    }
}

module clipBottom()
{
     difference()
    {
        union()
        {
    translate([0,-2.5,15])  //back wall    
    cube([40,7,3]); 
    translate([0,0.8,7]) //bottom      
    cube([40,3.7,8]);
    
    translate([20,-3,12])
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
  

    translate([10,-2,0]) //bottom hole
    cube([15.5,3,15]);
}
}

clipTop();
translate([0,5,0])
clipBottom();