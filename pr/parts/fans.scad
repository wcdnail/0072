module FanPlane(thickness, fanDiam, hullDiam, xo=0, yo=0, sx=1, sy=1) {
    hull() {
        translate([xo-fanDiam/2+1*sx, yo-fanDiam/2+1*sy, 0]) cylinder(d=hullDiam, h=thickness);
        translate([xo+fanDiam/2-1*sx, yo-fanDiam/2+1*sy, 0]) cylinder(d=hullDiam, h=thickness);
        translate([xo+fanDiam/2-1*sx, yo+fanDiam/2-1*sy, 0]) cylinder(d=hullDiam, h=thickness);
        translate([xo-fanDiam/2+1*sx, yo+fanDiam/2-1*sy, 0]) cylinder(d=hullDiam, h=thickness);
    }
}

module FanMount(radius, thickness=4, edgeHullDiam=4, centralHoleCoef=0.93, boltsDiam=2.8) {
    difference() {
        FanPlane(thickness, radius, edgeHullDiam);
        color("Red") translate([0, 0, -thickness*2]) cylinder(d=centralHoleCoef*radius, h=thickness*4);
        color("OrangeRed") {
            translate([-radius/2+3, -radius/2+3, -thickness]) cylinder(d=boltsDiam, h=thickness*3);
            translate([ radius/2-3, -radius/2+3, -thickness]) cylinder(d=boltsDiam, h=thickness*3);
            translate([ radius/2-3,  radius/2-3, -thickness]) cylinder(d=boltsDiam, h=thickness*3);
            translate([-radius/2+3,  radius/2-3, -thickness]) cylinder(d=boltsDiam, h=thickness*3);
        }
    }
}

module FanMount30(thickness=4, edgeHullDiam=4, centralHoleCoef=0.93, boltsDiam=2.8, clr=undef, drawFan=false) {
    color(clr) FanMount(30, thickness, edgeHullDiam, centralHoleCoef, boltsDiam);
    if(drawFan) {
        %translate([0, 0, 6.8+thickness]) rotate([180]) import("../parts/fan_30mm.stl");
    }
}

module FanMount40(thickness=4, edgeHullDiam=4, centralHoleCoef=0.93, boltsDiam=2.8, clr=undef, drawFan=false) {
    color(clr) FanMount(40, thickness, edgeHullDiam, centralHoleCoef, boltsDiam);
    if (drawFan) {
        %translate([0, 0, 6.8+thickness]) rotate([180]) import("../parts/fan_40mm.stl");
    }
}
