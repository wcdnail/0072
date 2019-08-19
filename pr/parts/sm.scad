%import("sm.stl");

module Hammer(cz = 3) {
  sf = 0.4;
  da = 1 - sf;
  db = da;
  // Древко
  linear_extrude(height=cz)
    polygon(points=[
       [  21.8 + da,  -24.16 + da + db]
      ,[  27.2 - da,  -19.84 - da + db]
      ,[-4.156 - da, 10.3421 - da]
      ,[-8.181 + da,   6.671 + da]
      ]);
  /*
  // Молот
  linear_extrude(height=cz)
    polygon(points=[
       [    21.8,  -24.16]
      ,[    27.2,  -19.84]
      ,[  -1.156,  7.3421]
      ,[    6.08,   13.94]
      ,[  -5.011,   13.94]
      ,[  -17.67,    3.43]
      ,[-11.4173, -2.0134]
      ,[  -5.181,   3.671]
      ]);
  */
}

Hammer();
