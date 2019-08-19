use <../../openscad/BezierScad/BezierScad.scad>;
use <../../openscad/bezier-eh.scad>;


module Hammer(shrinkage=0, cz=3) {
  render() union() {
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
         [(-dTopCX/2)+shrinkage, ( dCY/2)-shrinkage-2]
        ,[( dTopCX/2)-shrinkage, ( dCY/2)-shrinkage-2]
        ,[( dBotCX/2)-shrinkage, (-dCY/2+bRCY)+shrinkage]
        ,[(-dBotCX/2)+shrinkage, (-dCY/2)+shrinkage]
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
    dbRCX=0.5-shrinkage*2;
    dbRCY=-0.85;
    dbLCX=0;
    dbLCY=0.2;
    //--------------------------------------------------------------------------------------
    translate([0.3, (dCY-hCY)/2, 0]) linear_extrude(height=cz)
      polygon(points=[
         [(-hCX/2)+shrinkage+dLCX, ( hCY/2)-shrinkage+dLCY]
        ,[( hCX/2-bCX)-shrinkage+dRCX, ( hCY/2)-shrinkage+dRCY]
        ,[( hCX/2)-shrinkage+dbRCX, (-hCY/2)+shrinkage+dbRCY]
        ,[(-hCX/2)+shrinkage+dbLCX, (-hCY/2)+shrinkage+dbLCY]
        ]);
    //--------------------------------------------------------------------------------------
  }
}

module Sickle(shrinkage=0, cz=3) {
  /*
  BezArc([
     [-23.31, 7.07]
    ,[-25, -10]
    ,[-15, -32]
    ,[39.5, -28]
    ,[19.416, 24.4378]
   ],[0, 7.07]
    ,steps=32, showCtlR=1);
  */
  /*
  BezArc([
    // -- Левый нижний
     [-23.31, 7.07]
    ,[-23.65, -17.2]
    ,[0, -19.6]
    // -- Правый нижний
    // -- Правый верхний
   ],[-23.31, 7.07]
    ,steps=32, showCtlR=1, height=cz);
  */
  polygon(Bezier([
     [166.577, 138.645l]
    ,[-33.986, 32.37]
    ,[18.126, 18.126]
    ,[15.651, -15.756]
    ,[19.416, 24.4378]
    ]));
}

//%translate([-1.75, 9, 0]) rotate([0, 0, -45]) import("sm.stl");
//Hammer();
//Hammer(1);
Sickle();

