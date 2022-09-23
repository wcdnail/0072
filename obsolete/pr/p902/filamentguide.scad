mount_width=42.4;
mount_height=32.7;
mount_depth=12.5;

filament_hole_offset=15.1;
mounting_hole_offset=mount_width-9.3;

gear_diameter=12;
roller_diameter=13;

tolerance=0.5;

//feeder main body
%translate([0,0,-1])
    difference() {
        cube([mount_width,mount_width,1]);
        translate([mount_width/2,mount_width/2,-1]) 
            cylinder(d=22,h=3);
    }

//feeder body base
%difference() {
    cube([mount_width,mount_width-mount_height,mount_depth]);
    translate([filament_hole_offset, mount_depth+1, mount_depth/2]) rotate([90,0,0]) cylinder(d=6,h=mount_depth+2);
    translate([mounting_hole_offset, mount_depth+1, mount_depth/2]) rotate([90,0,0]) cylinder(d=4,h=mount_depth+2);
}

//driving gear
%translate([mount_width/2,mount_width/2,0]) 
            cylinder(d=gear_diameter,h=mount_depth);

//idle roller
%translate([mount_width/2-roller_diameter/2-gear_diameter/2,mount_width/2,mount_depth/2-2.5]) 
            cylinder(d=roller_diameter,h=5);

//filament
%translate([filament_hole_offset, mount_width+1, mount_depth/2]) rotate([90,0,0]) cylinder(d=2,h=mount_width+2);

translate([mount_width/2-roller_diameter/2-gear_diameter/2,mount_width-mount_height,0])
difference() {
    union() {
        cube([roller_diameter/2+gear_diameter/2, mount_width/2-(mount_width-mount_height), mount_depth]);
        translate([-(mount_width/2-roller_diameter/2-gear_diameter/2),0,0]) cube([mount_width, 1, mount_depth]);
        translate([-(mount_width/2-roller_diameter/2-gear_diameter/2)-1,-4,0]) cube([1, 5, mount_depth]);
        translate([-(mount_width/2-roller_diameter/2-gear_diameter/2)+mount_width,-4,0]) cube([1, 5, mount_depth]);
    }
    //driving gear
    translate([roller_diameter/2+gear_diameter/2,mount_width/2-(mount_width-mount_height),-1]) 
            cylinder(d=gear_diameter+tolerance,h=mount_depth+2,$fs=0.1);

    //idle roller
    translate([0,mount_width/2-(mount_width-mount_height),-1]) 
                cylinder(d=roller_diameter+tolerance,h=mount_depth+2,$fs=0.1);
    
    //filament
    translate([filament_hole_offset-(mount_width/2-roller_diameter/2-gear_diameter/2), mount_width/2-(mount_width-mount_height), mount_depth/2]) rotate([90,0,0]) cylinder(d2=2,d1=2+tolerance,h=mount_width/2-(mount_width-mount_height)+2, $fs=0.1);
    
    //mounting screw/spring screw
    translate([mounting_hole_offset-(mount_width/2-roller_diameter/2-gear_diameter/2), 2, mount_depth/2]) rotate([90,0,0]) cylinder(d=4,h=1+2,$fs=0.1);
    
    //---
    //translate([filament_hole_offset-(mount_width/2-roller_diameter/2-gear_diameter/2), mount_width/2-(mount_width-mount_height)-8, mount_depth/2]) rotate([90,0,0]) cylinder(d=6,h=20, $fn=64);
}
