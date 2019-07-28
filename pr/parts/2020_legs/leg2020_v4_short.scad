$fn=34;

module legOriginalShort_stl() {
    translate([0, 0, 0]) rotate([0, 0, 0]) 
        import("leg2020_v4_short.stl");
}

module leg2020() {
    difference() {
        legOriginalShort_stl();
        //translate([11.6, 0, -20]) cylinder(d=6, h=50);
        translate([11.6, 0, -14]) cylinder(d=12, h=20);
    }
}

leg2020();