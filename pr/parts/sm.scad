%import("sm.stl");

module Hammer(h = 1, dec = 0) {
  xd = dec;
  yd = dec;
  // Молот
  linear_extrude(height=h)
    polygon(points=[
       [    21.8 + xd * 1,  -24.16 + yd * 1]
      ,[    27.2 - xd * 1,  -19.84 - yd * 1]
      ,[  -1.156 - xd * 1,  7.3421 + yd * 1]
      ,[    6.08 - xd * 3,   13.94 - yd * 1]
      ,[  -5.011 + xd * 1,   13.94 - yd * 1]
      ,[  -17.67 + xd * 1,    3.43 - yd * 1]
      ,[-11.4173 - xd * 0.1, -2.0134 + yd * 1]
      ,[  -5.181 - xd * 1,   3.671 + yd * 1]
      ]);
}

Hammer(2, 0.2);
