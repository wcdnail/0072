$fn=36;
Pitch=2.54;
Color="white";
Size=1;   //0=5mm   1=5mm bicolor   2=5mm RGB   3=3mm   4=3mm bicolor  5=3mm rgb
Solder=1;

module Led(Color,Size,,Solder)
  {
  if(Size==0)
    translate([1.27,0,3])
      difference()
         {
         union()
            {
             color("Silver")
               translate([Pitch/2-0.25,-0.25,-28],center=true)
                  cube([0.5,0.5,30]);
            color("Silver")
               translate([-Pitch/2-0.25,-0.25,-26],center=true)
                  cube([0.5,0.5,28.5]);
            color("Silver")
               translate([0,0,3],center=true)
                  cylinder(d1=0,d2=2,center=true);

            color("Silver")
               difference()
                  {
                  translate([-Pitch/2-0.25,-0.25,1.5])
                     cube([Pitch+0.5,0.5,2]);
                  translate([0.65,-0.25,3])
                     rotate([0,35,0])
                     cube([0.5,5,5],center=true);
                  }

          if(Solder==1)
            {
            color("Silver")
                translate([Pitch*0.5,0,-3])
                  rotate([0,0,0])
                    scale([1,1,1.1])
                      sphere(d=2);
            color("Silver")
                translate([-Pitch*0.5,0,-3])
                  rotate([0,0,0])
                    scale([1,1,1.1])
                      sphere(d=2);
            }

            color(Color,0.8)
               {
               hull()
                  {
                  translate([0,0,6])
                     sphere(d=5);
                  translate([0,0,1])
                     cylinder(d=5,h=1);
                  }
               cylinder(d=6,h=1);
               }
            }
         color(Color,0.6)
          translate([-7.5,0,-1])
            cube([10,10,10],center=true);
         }  


 if(Size==1)
    translate([0,0,3])
      difference()
         {
         union()
            {
             color("Silver")
               translate([Pitch,0,-18])
                  cube([0.5,0.5,30],center=true);
            color("Silver")
               translate([-Pitch,0,-17.4])
                  cube([0.5,0.5,28.5],center=true);
            color("Silver")
               translate([1.75,0,-1])
                  rotate([0,-20,0])
                  cube([0.5,0.5,5],center=true);
            color("Silver")
               translate([-1.75,0,-1])
                  rotate([0,20,0])
                  cube([0.5,0.5,5],center=true);
            color("Silver")
               translate([0,0,-15.5])
                  cube([0.5,0.5,34],center=true);

            color("Silver")
               translate([0,0,2.5])
                  cylinder(d1=0,d2=2,center=true);

            color("Silver")
               difference()
                  {
                  translate([-Pitch/2-0.25,-0.25,1])
                     cube([Pitch+0.5,0.5,2]);
                  translate([0.65,-0.25,2.5])
                     rotate([0,35,0])
                     cube([0.5,5,5],center=true);
                  }

          if(Solder==1)
            {
            color("Silver")
                translate([Pitch,0,-3])
                  rotate([0,0,0])
                    scale([1,1,1.1])
                      sphere(d=2);
            color("Silver")
                translate([0,0,-3])
                  rotate([0,0,0])
                    scale([1,1,1.1])
                      sphere(d=2);
            color("Silver")
                translate([-Pitch,0,-3])
                  rotate([0,0,0])
                    scale([1,1,1.1])
                      sphere(d=2);

            }

            color(Color,0.8)
               {
               hull()
                  {
                  translate([0,0,6])
                     sphere(d=5);
                  translate([0,0,1])
                     cylinder(d=5,h=1);
                  }
               cylinder(d=6,h=1);
               }
            }
         color(Color,0.6)
          translate([-7.5,0,4])
            cube([10,10,10],center=true);
         }  


if(Size==2)
    translate([Pitch/2,Pitch/2,3])
      difference()
         {
         union()
            {
            color("Silver")
               translate([Pitch/2,-Pitch/2,-18.15])
                  cube([0.5,0.5,30],center=true);
            color("Silver")
               translate([-Pitch/2,-Pitch/2,-17.4])
                  cube([0.5,0.5,28.5],center=true);
            color("Silver")
               translate([Pitch/2,Pitch/2,-18.15])
                  cube([0.5,0.5,30],center=true);
            color("Silver")
               translate([-Pitch/2,Pitch/2,-18.15])
                  cube([0.5,0.5,30],center=true);

            color("Silver")
               translate([0.73,0.73,-1])
                  rotate([13,-13,0])
                  cube([0.5,0.5,5],center=true);
            color("Silver")
               translate([-0.73,0.73,-1])
                  rotate([13,13,0])
                  cube([0.5,0.5,5],center=true);
             color("Silver")
               translate([-0.73,-0.73,-1])
                  rotate([-13,13,0])
                  cube([0.5,0.5,5],center=true);
              color("Silver")
               translate([0.73,-0.73,-1])
                  rotate([-13,-13,0])
                  cube([0.5,0.5,5],center=true);

            color("Silver")
               translate([0,0,2.5])
                  cylinder(d1=0,d2=2,center=true);

            color("Silver")
               difference()
                  {
                  translate([-Pitch/2-0.25,-0.25,1])
                     cube([Pitch+0.4,0.4,2]);
                  translate([0.65,-0.25,2.5])
                     rotate([0,35,0])
                     cube([0.5,5,5],center=true);
                  }
            if(Solder==1)
              {
              color("Silver")
                  translate([Pitch/2,Pitch/2,-3])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              color("Silver")
                  translate([-Pitch/2,Pitch/2,-3])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              color("Silver")
                  translate([Pitch/2,-Pitch/2,-3])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              color("Silver")
                  translate([-Pitch/2,-Pitch/2,-3])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              }

            color(Color,0.8)
               {
               hull()
                  {
                  translate([0,0,6])
                     sphere(d=5);
                  translate([0,0,1])
                     cylinder(d=5,h=1);
                  }
               cylinder(d=6,h=1);
               }

            }
         color(Color,0.6)
          translate([-7.5,0,4.95])
            cube([10,10,10],center=true);
         }

if(Size==3)
    translate([Pitch/2,0,3])
      difference()
         {
         union()
            {
             color("Silver")
               translate([Pitch/2,0,-14],center=true)
                  cube([0.4,0.4,30],center=true);
            color("Silver")
               translate([-Pitch/2,0,-13],center=true)
                  cube([0.4,0.4,28.5],center=true);
            color("Silver")
               translate([0,0,2.2],center=true)
                  cylinder(d1=0,d2=2,center=true);

            color("Silver")
               difference()
                  {
                  translate([0,0,1.5])
                     cube([Pitch,0.5,2],center=true);
                  translate([1.2,-0.25,3])
                     rotate([0,35,0])
                     cube([0.5,5,6.5],center=true);
                  }

            if(Solder==1)
              {
              color("Silver")
                  translate([Pitch*0.5,0,-3])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              color("Silver")
                  translate([-Pitch*0.5,0,-3])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              }

            color(Color,0.8)
               {
               hull()
                  {
                  translate([0,0,3.5])
                     sphere(d=3);
                  translate([0,0,1])
                     cylinder(d=3,h=1);
                  }
               cylinder(d=4,h=1);
               }

            }
         color(Color,0.6)
          translate([-7.5,0,-1])
            cube([10,10,10],center=true);
         }  


if(Size==4)
    translate([0,0,3])
      difference()
         {
         union()
            {
            color("Silver")
               translate([Pitch,0,-18.15])
                  cube([0.5,0.5,30],center=true);
            color("Silver")
               translate([-Pitch,0,-17.4])
                  cube([0.5,0.5,28.5],center=true);
            color("Silver")
               translate([1.6,0,-1])
                  rotate([0,-23,0])
                  cube([0.5,0.5,5],center=true);
            color("Silver")
               translate([-1.6,0,-1])
                  rotate([0,23,0])
                  cube([0.5,0.5,5],center=true);
            color("Silver")
               translate([0,0,-15.5])
                  cube([0.5,0.5,34],center=true);

            color("Silver")
               translate([0,0,2.5])
                  cylinder(d1=0,d2=2,center=true);

            color("Silver")
               difference()
                  {
                  translate([0,0,2])
                     cube([Pitch+0.4,0.4,2],center=true);
                  translate([0.65,-0.25,2.5])
                     rotate([0,35,0])
                     cube([0.5,5,5],center=true);
                  }
            if(Solder==1)
              {
              color("Silver")
                  translate([Pitch,0,-3])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              color("Silver")
                  translate([-Pitch,0,-3])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              color("Silver")
                  translate([0,0,-3])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              }

            color(Color,0.8)
               {
               hull()
                  {
                  translate([0,0,3.5])
                     sphere(d=3);
                  translate([0,0,1])
                     cylinder(d=3,h=1);
                  }
               cylinder(d=4,h=1);
               }

            }
         color(Color,0.6)
          translate([-6.5,0,4.95])
            cube([10,10,10],center=true);
         }

if(Size==5)
    translate([Pitch/2,Pitch/2,3])
      difference()
         {
         union()
            {
            color("Silver")
               translate([Pitch/2,-Pitch/2,-18.15])
                  cube([0.5,0.5,30],center=true);
            color("Silver")
               translate([-Pitch/2,-Pitch/2,-17.4])
                  cube([0.5,0.5,28.5],center=true);
            color("Silver")
               translate([Pitch/2,Pitch/2,-18.15])
                  cube([0.5,0.5,30],center=true);
            color("Silver")
               translate([-Pitch/2,Pitch/2,-18.15])
                  cube([0.5,0.5,30],center=true);

            color("Silver")
               translate([0.73,0.73,-1])
                  rotate([13,-13,0])
                  cube([0.5,0.5,5],center=true);
            color("Silver")
               translate([-0.73,0.73,-1])
                  rotate([13,13,0])
                  cube([0.5,0.5,5],center=true);
             color("Silver")
               translate([-0.73,-0.73,-1])
                  rotate([-13,13,0])
                  cube([0.5,0.5,5],center=true);
              color("Silver")
               translate([0.73,-0.73,-1])
                  rotate([-13,-13,0])
                  cube([0.5,0.5,5],center=true);

            color("Silver")
               translate([0,0,2.5])
                  cylinder(d1=0,d2=2,center=true);

            color("Silver")
               difference()
                  {
                  translate([-Pitch/2-0.25,-0.25,1])
                     cube([Pitch+0.4,0.4,2]);
                  translate([0.65,-0.25,2.5])
                     rotate([0,35,0])
                     cube([0.5,5,5],center=true);
                  }
            if(Solder==1)
              {
              color("Silver")
                  translate([Pitch/2,Pitch/2,-3])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              color("Silver")
                  translate([-Pitch/2,Pitch/2,-3])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              color("Silver")
                  translate([Pitch/2,-Pitch/2,-3])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              color("Silver")
                  translate([-Pitch/2,-Pitch/2,-3])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              }

            color(Color,0.8)
               {
               hull()
                  {
                  translate([0,0,3.5])
                     sphere(d=3);
                  translate([0,0,1])
                     cylinder(d=3,h=1);
                  }
               cylinder(d=4,h=1);
               }

            }
         color(Color,0.6)
          translate([-6.5,0,4.95])
            cube([10,10,10],center=true);
         }
  }

Led(Color,Size,Solder);