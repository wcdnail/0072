use <../../openscad/bezier-eh.scad>;

module Hammer(shrinkage=0, cz=3) {
  render() union() {
    se=shrinkage/2;
    //--------------------------------------------------------------------------------------
    // древко
    dTopCX=5.1;             // ширина верхушки древка
    dBotCX=7;               // ширина дна древка
    dCY=47;                 // высота древка
    // кривизна 
    bRCY=-0.8;
    //--------------------------------------------------------------------------------------
    linear_extrude(height=cz)
      polygon(points=[
         [(-dTopCX/2)+se, ( dCY/2)-se-2]
        ,[( dTopCX/2)-se, ( dCY/2)-se-2]
        ,[( dBotCX/2)-se, (-dCY/2+bRCY)+se]
        ,[(-dBotCX/2)+se, (-dCY/2)+se]
        ]);
    //--------------------------------------------------------------------------------------
    // Молот
    hCX=23.2;             // Ширина головки
    hCY=8.1;              // Высота головки
    bCX=7.3;              // Наклонная бойка
    // кривизна 
    dLCX=-0.5;
    dLCY=0.4;
    dRCX=-0;
    dRCY=-1.1;
    dbRCX=0.5-shrinkage;
    dbRCY=-0.85;
    dbLCX=0;
    dbLCY=0.2;
    //--------------------------------------------------------------------------------------
    translate([0.3, (dCY-hCY)/2, 0]) linear_extrude(height=cz)
      polygon(points=[
         [(-hCX/2)+se+dLCX, (hCY/2)-se+dLCY]
        ,[(hCX/2-bCX)-se+dRCX, (hCY/2)-se+dRCY]
        ,[(hCX/2)-se+dbRCX, (-hCY/2)+se+dbRCY]
        ,[(-hCX/2)+se+dbLCX, (-hCY/2)+se+dbLCY]
        ]);
    //--------------------------------------------------------------------------------------
  }
}

module SickleBezierVis(shrinkage=0) {
  //--------------------------------------------------------------------------------------
  // Серп
  se=shrinkage;
  BezierVisualize([
       /*B*/[-23.31+se, 7.07+se],
       /*C*/OFFSET([-1.1, -24.5]),     /*C*/SHARP(),                  [-3.35+se, -19.1+se],
       /*C*/OFFSET([0, 0]),            /*C*/OFFSET([0, 0]),           [3.35-se, -19.1+se],
       /*C*/OFFSET([23.5-se, 0.3+se]), /*C*/OFFSET([5.3-se, -10+se]), [19.416+se/(3/2), 24.4378-se*3], // Острие
       /*C*/OFFSET([2.5, -19.8]),      /*C*/OFFSET([11, .25]),        [3.18-se, -11.85-se],
       /*C*/OFFSET([0, 0]),            /*C*/OFFSET([0, 0]),           [-3.18+se, -11.85-se],
       /*C*/OFFSET([-17.75-se, 5-se]), /*C*/SHARP(),                  [-18.6-se/2, 10-se/2],
       /*C*/OFFSET([-2.2, 0]),         /*C*/SHARP(),                  [-23.05, 12.7-se/2],
       /*C*/OFFSET([0, 0]),            /*C*/OFFSET([0, 0]),           [-24.5, 11.4-se/2],
       /*C*/OFFSET([-2, 0.7]),         /*C*/OFFSET([2, -1]),          [-29.5, 12.2-se/2],
       /*C*/OFFSET([-5, 3]),           /*C*/OFFSET([0, 2]),           [-38.9+se/2, 11.9],
       /*C*/OFFSET([0, -4]),           /*C*/OFFSET([-4, -1.5]),       [-26.7, 8.6+se/2],
       /*C*/OFFSET([0, 0.2]),          /*C*/OFFSET([0, 1]),           [-23.31+se/2, 7.07+se/2],
  ]);
  //--------------------------------------------------------------------------------------
}

module Sickle(shrinkage=0, cz=3) {
  //--------------------------------------------------------------------------------------
  // Серп
  se=shrinkage/2;
  linear_extrude(height=cz)
    polygon(Bezier([
       /*B*/[-23.31+se, 7.07+se],
       /*C*/OFFSET([-1.1, -24.5]),     /*C*/SHARP(),                  [-3.35+se, -19.1+se],
       /*C*/OFFSET([0, 0]),            /*C*/OFFSET([0, 0]),           [3.35-se, -19.1+se],
       /*C*/OFFSET([23.5-se, 0.3+se]), /*C*/OFFSET([5.3-se*2, -10+se]), [19.416+se/1.2, 24.4378-se*3], // Острие
       /*C*/OFFSET([2.5, -19.8]),      /*C*/OFFSET([11, .25]),        [3.18-se, -11.85-se],
       /*C*/OFFSET([0, 0]),            /*C*/OFFSET([0, 0]),           [-3.18+se, -11.85-se],
       /*C*/OFFSET([-17.75-se, 5-se]), /*C*/SHARP(),                  [-18.6-se, 10-se],
       /*C*/OFFSET([-2.2, 0]),         /*C*/SHARP(),                  [-23.05, 12.7-se],
       /*C*/OFFSET([0, 0]),            /*C*/OFFSET([0, 0]),           [-24.5, 11.4-se],
       /*C*/OFFSET([-2, 0.7]),         /*C*/OFFSET([2, -1]),          [-29.5, 12.2-se],
       /*C*/OFFSET([-5, 3]),           /*C*/OFFSET([0, 2]),           [-38.9+se, 11.9],
       /*C*/OFFSET([0, -4]),           /*C*/OFFSET([-4, -1.5]),       [-26.7, 8.6+se],
       /*C*/OFFSET([2, 0]),            /*C*/OFFSET([0, 0]),           [-23.31+se, 7.07+se],
    ]));
  //--------------------------------------------------------------------------------------
}

module HammerAndSickle(shrinkage=0, cz=6) { 
  union() {
    Hammer(shrinkage, cz);
    Sickle(shrinkage, cz);
  }
}

//%translate([-1.75, 9, 0]) rotate([0, 0, -45]) import("sm.stl");
//SickleBezierVis(1);
%HammerAndSickle();
HammerAndSickle(1);


