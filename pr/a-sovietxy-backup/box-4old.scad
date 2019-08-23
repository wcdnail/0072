//
// Ящик для Вулкана 1 из ЛДСП
// Автор: MadeIn USSR 2018 (С)
//

wt=22;  // толщина плиты (12, 16, 18, 22, 25)
rw=550; // ширина внутр. периметра 
rd=440; // длина внутр. периметра 
rz=700; // высота внутр. периметра 
ed=100; // длина внутр. балок 
fz=150; // высота передней панели
bd=8;   // диаметр под болты
dd=60;  // глубина под болты

module holeCycle(dim = rw, sx = wt/2, kolvo = 4) {
    st=(dim)/(kolvo - 1);
    for(i = [0:kolvo-1]) {
        translate([sx + i * st, dd, sx]) 
            rotate([90, 0, 0]) cylinder(d=bd, h=dd*2);
    }
}

module bottomPlate() {
    cube([wt + rw, rd, wt]);
}
module leftPlate() {
    difference() {
        translate([0, -wt, 0]) cube([wt + rw, wt, wt + rz]);
        color("red") {
            holeCycle();
            translate([0, 0, rz]) holeCycle(dim=ed, kolvo=2);
            translate([rw-wt-ed, 0, rz]) holeCycle(dim=ed, kolvo=2);
            translate([rw, 0, rz]) rotate([0, 90, 0]) holeCycle(dim=fz-wt, kolvo=2);
        }
    }
}
module rightPlate() {
    translate([0, rd + wt, 0]) leftPlate();
}
module backPlate() {
    difference() {
        translate([-wt, -wt, 0]) cube([wt, wt * 2 + rd, wt + rz]);
        color("red") {
            translate([0, -wt, rz]) rotate([0, 90, 90]) holeCycle(dim=rz-wt*2, kolvo=5);
            translate([0, rd, rz]) rotate([0, 90, 90]) holeCycle(dim=rz-wt*2, kolvo=5);
            translate([0, rd/4-wt/2, 0]) rotate([0, 0, 90]) holeCycle(dim=rd/2, kolvo=2);
            translate([0, rd/4-wt/2, rz]) rotate([0, 0, 90]) holeCycle(dim=rd/2, kolvo=2);
        }
    }
}
module backBridge() {
    difference() {
        translate([0, 0, rz]) cube([wt + ed, rd, wt]);
        color("yellow") {
            translate([0, rd/4-wt/2, rz]) rotate([0, 0, 90]) holeCycle(dim=rd/2, kolvo=2);
            translate([0, 0, rz]) holeCycle(dim=ed, kolvo=2);
            translate([0, rd, rz]) holeCycle(dim=ed, kolvo=2);
        }
    }
}
module frontBridge() {
    difference() {
        translate([rw-wt-ed, 0, rz]) cube([wt + ed, rd, wt]);
        color("yellow") {
            translate([rw, rd/4-wt/2, rz]) rotate([0, 0, 90]) holeCycle(dim=rd/2, kolvo=2);
            translate([rw-wt-ed, 0, rz]) holeCycle(dim=ed, kolvo=2);
            translate([rw-wt-ed, rd, rz]) holeCycle(dim=ed, kolvo=2);
        }
    }
}
module frontPanel() {
    difference() {
        translate([rw, 0, rz-fz]) cube([wt, rd, wt + fz]);
        color("red") translate([rw, rd/4-wt/2, rz]) rotate([0, 0, 90]) holeCycle(dim=rd/2, kolvo=2);
    }
}

module draft1() {
    bottomPlate();
    leftPlate();
    rightPlate();
    backPlate();
    backBridge();
    frontBridge();
    frontPanel();
}

draft1();
