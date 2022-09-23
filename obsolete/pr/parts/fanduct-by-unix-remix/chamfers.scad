// ---------------------------------------------------------------------------------------------------------------------

module ChamferCyl(scx, scy, cz, diam=3, center=false) {
    r=diam/2;
    cx=scx-diam;
    cy=scy-diam;
    sx=center?-scx/2+r:r;
    sy=center?-scy/2+r:r;
    sz=center?-cz/2:0;
    hull() {
        translate([sx, sy, sz]) cylinder(d=diam, h=cz);
        translate([sx+cx, sy, sz]) cylinder(d=diam, h=cz);
        translate([sx+cx, sy+cy, sz]) cylinder(d=diam, h=cz);
        translate([sx,  sy+cy, sz]) cylinder(d=diam, h=cz);
    }
}

module ChamferBox(scx, scy, scz, diam=3, center=false) {
    r=diam/2;
    cx=scx-diam;
    cy=scy-diam;
    cz=scz-diam;
    sx=center?-scx/2+r:r;
    sy=center?-scy/2+r:r;
    sz=center?-scz/2+r:r;
    hull() {
        // Bottom
        translate([sx, sy, sz]) sphere(d=diam);
        translate([sx+cx, sy, sz]) sphere(d=diam);
        translate([sx+cx, sy+cy, sz]) sphere(d=diam);
        translate([sx,  sy+cy, sz]) sphere(d=diam);
        // Top
        translate([sx, sy, sz+cz]) sphere(d=diam);
        translate([sx+cx, sy, sz+cz]) sphere(d=diam);
        translate([sx+cx, sy+cy, sz+cz]) sphere(d=diam);
        translate([sx,  sy+cy, sz+cz]) sphere(d=diam);
    }
}

module chamfer_cube(v3, d=3, center=false) {
    ChamferCyl(v3[0], v3[1], v3[2], diam=d, center=center);
}

// ---------------------------------------------------------------------------------------------------------------------
