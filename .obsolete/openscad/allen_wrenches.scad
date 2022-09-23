// wrench sizes from https://www1.mscdirect.com/PDF/FASTENERS/HexKeys.pdf
// width, length_long_side, length_short_side, bend_radius
wrenches = [
    //[34, 300, 100, 34], // 34mm
    [11.95, 124, 45, 12], // 12mm
    [9.95, 112, 40, 10], // 10mm
    [7.95, 100, 36, 8],  // 8mm
    [5.95, 90, 32, 6],  // 6mm
    [4.96, 80, 28, 5],  // 5mm
    [3.96, 70, 25, 4],  // 4mm
    [2.96, 63, 20, 3],  // 3mm
    [2.47, 56, 18, 2.5],  // 2.5mm
    [1.97, 50, 16, 2],  // 2mm
    [1.47, 45, 14, 1.5],  // 1.5mm
];


module hexagon(d) {
    // d is the distance between parallel edges of the hexagon
    // x, where x is the short side of a 30/60/90 degree triangle
    x = d / (2*sqrt(3));
    polygon([
        [-1 * x, x * sqrt(3)], [x, x * sqrt(3)],
        [2 * x, 0],
        [x, -1 * x * sqrt(3)], [-1 * x, -x * sqrt(3)],
        [-2 * x, 0]
    ]);
}

module hex_key(wrench_diameter, wrench_long_side, wrench_short_side, wrench_bend_radius) {
    union() {
        translate([wrench_diameter / sqrt(3), wrench_bend_radius, 0]) {
            rotate([-90, 90, 0]) {
                linear_extrude(wrench_long_side-wrench_bend_radius) {
                    hexagon(wrench_diameter);
                }
            }
        }

        translate([-wrench_bend_radius, -wrench_diameter / sqrt(3), 0]) {
            rotate([0, 0, 0]) {
                rotate([0, -90, 0]) {
                    linear_extrude(wrench_short_side-wrench_bend_radius) {
                        hexagon(wrench_diameter);
                    }
                }
            }
        }
        
        translate([-wrench_bend_radius, wrench_bend_radius, 0]) {
            difference() {
                rotate_extrude(angle = 90) {
                    rotate([0, 0, -90]) {
                        translate([0, wrench_bend_radius + wrench_diameter / sqrt(3), 0]) {
                            rotate([0, 0, 0]) {
                                hexagon(wrench_diameter);
                            }
                        }
                    }
                }
                rotate([0, 0, 90]) {
                    translate([-50 * wrench_diameter, 0, -50 * wrench_diameter]) {
                        cube(100*wrench_diameter);
                    }
                }
                translate([-50 * wrench_diameter, 0, -50 * wrench_diameter]) {
                    cube(100*wrench_diameter);
                }
            }
        }
    }
}

function sum_width(wrenches, cur_position, final_position)
    = cur_position > final_position ? 0 : wrenches[cur_position][0] + sum_width(wrenches, cur_position+1, final_position);

for (i=[0:len(wrenches)-1]) {
    offset = sum_width(wrenches, 0, i-1);
    
    wrench = wrenches[i];
    translate([-offset, offset, wrench[0]/2]) {
        hex_key(wrench[0], wrench[1], wrench[2], wrench[3]);
    }
}