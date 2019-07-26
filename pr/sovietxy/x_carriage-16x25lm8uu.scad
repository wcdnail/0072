include <bconf.scad>
include <x_carriage.scad>

slice_zo=OrigCARHeightWOHolder+8;
slice_zyo=2;
sl_cy=11.65;
sl_zo=2.5;

module x_carriage_1s_cutted(rodsHolesDiam=12) {
    difference() {
        union() {
            x_carriage_1s(12, -1);
            translate([carBaseXOffset, (13+LM8UUCenterOffset), carBaseZOffset+10.5]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam+LM8UUHolderOD, h=carCX);
            translate([carBaseXOffset, OrigCARWidth-(13+LM8UUCenterOffset), carBaseZOffset+10.5]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam+LM8UUHolderOD, h=carCX);
        }
        color("red") {
            translate([-carXEdge*2, -1.9, carBaseZOffset+slice_zo]) cube([(OrigCARLen-carXEdge)/2, OrigCARWidth/3, OrigCARHeightWOHolder*2]);
            translate([-carXEdge*2, OrigCARWidth-OrigCARWidth/3+slice_zyo, carBaseZOffset+slice_zo]) cube([(OrigCARLen-carXEdge)/2, OrigCARWidth/3, OrigCARHeightWOHolder*2]);
        }
        // LM8UU slices
        translate([0, (13+LM8UUCenterOffset), carBaseZOffset+(slice_zo-sl_zo)]) cube([(carCX+carXEdge)*2, sl_cy, 5], center=true);
        translate([0, OrigCARWidth-(13+LM8UUCenterOffset), carBaseZOffset+(slice_zo-sl_zo)]) cube([OrigCARLen, sl_cy, 5], center=true);
        // LM8UU holes
        translate([0, (13+LM8UUCenterOffset), 10.5]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam, h=LM8UULen);
        translate([0, OrigCARWidth-(13+LM8UUCenterOffset), 10.5]) rotate([0, 90, 0]) cylinder(d=LM8UUOutterDiam, h=LM8UULen);
        // Linear guides holes
        translate([-10, (13+LM8UUCenterOffset), 10.5]) rotate([0, 90, 0]) cylinder(d=rodsHolesDiam, h=50);
        translate([-10, OrigCARWidth-(13+LM8UUCenterOffset), 10.5]) rotate([0, 90, 0]) cylinder(d=rodsHolesDiam, h=50);
    }
}

module x_carriage_1s_cutted_boltholes() {
    hboltHeadLen=carCX/2+7.5;
    difference() {
        x_carriage_1s_cutted();
        // horizontal bolts holes
        color("red") {
            translate([-(carXEdge+1), (25.5+e3dNutsYOffset), hnut_hh]) rotate([0, 90, 0]) cylinder(d=hbolt_dhead, h=hboltHeadLen);
            translate([-(carXEdge+1), OrigCARWidth-(25.5+e3dNutsYOffset), hnut_hh]) rotate([0, 90, 0]) cylinder(d=hbolt_dhead, h=hboltHeadLen);
        }
    }
}

// В сборе
module x_carriage_assembled() {
    x_carriage_1s_cutted();
    translate([(carCX-carXEdge)*2, 0, 0]) mirror([1, 0, 0]) x_carriage_1s_cutted_boltholes();
    rotate([0, 0, 0]) x_carriage_top();
}

//mirror([1, 0, 0]) rotate([0, 90, 0]) x_carriage_1s_cutted_boltholes();
rotate([0, 90, 0]) x_carriage_1s_cutted();
