module x_carriage() {
    translate([-37.5, 37.5, 15.2])
        rotate([180, 0, 0])
            color("Red")
                import("../printedparts/1xCoreXY_X-Carriage.stl");
}

module x_carriage_v5() {
    translate([0, 0, 0]) 
        rotate([0, 0, 0]) 
            import("../printedparts3/CoreXY_X-Carriage_E3D-V5.stl");
}


translate([0, 0, 30]) x_carriage();
