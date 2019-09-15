$fn=20;
fudge=0.1;

SMDpassive("1210",label="000");
translate([4,0,0]) SOT23(22,label="78l05");
translate([10,0,0]) QFN28(label="SAMD21");
translate([16,0,0]) SOIC(8,"NE555");
translate([22,0,0]) SSOP(14,"DRV4711");
translate([28,0,0]) LED5050(6);


module LED5050(pins=6){
  // e.g. WS2812(B)
  dims=[5,5,1.5];
  pitch= (pins==6) ? 0.9 : 1.8;
  grvHght=1;
  marking=[0.7,0.2]; //width,height
  
  //body
  color("white")
    difference(){
      translate([0,0,(dims.z+0.1)/2]) cube(dims-[0,0,0.1],true);
      translate([0,0,dims.z-grvHght]) cylinder(d1=3.2,d2=4,h=grvHght+0.01);
      //marking
      translate([dims.x/2,dims.y/2,dims.z-marking[1]]) linear_extrude(marking[1]+fudge)      
        polygon([[-marking.x-fudge,fudge],[fudge,fudge],[fudge,-marking.x-fudge]]);
    }
  color("grey",0.6)
    translate([0,0,dims.z-grvHght]) cylinder(d1=3.2,d2=4,h=grvHght);
  //leads
  color("silver")
    for (i=[-pins/2+1:2:pins/2],r=[-90,90])
      rotate([0,0,r]) translate([dims.x/2,i*pitch,0]){
        translate([-1.1/2+0.2,0,0.1]) cube([1.1,1.0,0.2],true);
        translate([0.1,0,0.45]) cube([0.2,1.0,0.9],true);
      }
}
module SMDpassive(size="0805", thick=0, label=""){
  // SMD chip resistors, capacitors and other passives by EIA standard
  // e.g. 0805 means 0.08" by 0.05"
  // Dimensions (height, metallization) from Vishay CHP resistors
  // [size,body,capsWdth]
  dimsLUT=[
       ["0201",[0.6,0.3,0.25],0.1],
       ["0402",[1.02,0.5,0.38],0.25],
       ["0603",[1.6,0.8,0.45],0.3],
       ["0805",[2,1.25,0.55],0.4],
       ["1206",[3.2,1.6,0.55],0.45],
       ["1210",[3.2,2.6,0.55],0.5],
       ["1812",[4.6,3.2,0.55],0.5],
       ["2010",[5.0,2.5,0.55],0.6],
       ["2512",[6.35,3.2,0.55],0.6]
       ];
  
  testLUT=[ ["abc",3],["def",5],["gh",6] ];
  
  mtlLngth=dimsLUT[search([size],dimsLUT)[0]][2];//length of metallization
  bdDims=dimsLUT[search([size],dimsLUT)[0]][1]-[mtlLngth,0,0];
  ovThick= thick ? thick : bdDims.z;
  
  txtSize=bdDims.x/(0.8*len(label));
  if (label)
    color("white") translate([0,0,ovThick]) linear_extrude(0.1) 
      text(text=label,size=txtSize,halign="center",valign="center", font="consolas");
  
  
  //body
  color("darkSlateGrey") translate([0,0,ovThick/2]) cube([bdDims.x,bdDims.y,ovThick],true);
  //caps
  for (i=[-1,1]) color("silver")
    translate([i*(bdDims.x+mtlLngth)/2,0,ovThick/2]) cube([mtlLngth,bdDims.y,ovThick],true);
}

module QFN28(label=""){
  
  A=0.85;   //total thickness
  A1=0.035; //standoff
  A3=0.2;   //lead Frame Thick
  b=0.25;   //lead width
  D=5.0;    //body size X
  E=D;      //body size y
  J=3.1;    //pad size x
  K=J;      //pad size Y
  e=0.5;    //pitch
  L=0.55;   //lead Length
  pos=28;
  fudge=0.01; //very small fudge
  
  txtSize=D/(0.8*len(label));
  if (label)
    color("white") translate([0,0,A]) linear_extrude(0.1) 
      text(text=label,size=txtSize,halign="center",valign="center", font="consolas");
  
  
  color("darkSlateGrey")
    translate([0,0,A/2]) cube([D,E,A-A1],true);
  
  color("silver")
    for (i=[0:pos/4],rot=[0,90,180,270]){
      rotate(rot) translate([i*e-b/2-pos/16,-D/2-fudge,0]){
          cube([b,L-b/2,A3]);
        translate([b/2,L-b/2-fudge,0]) cylinder(d=b,h=A3);
      }
    }
  
  color("silver")
    linear_extrude(A3) polygon([[-J/2+b,K/2],[J/2,K/2],[J/2,-K/2],[-J/2,-K/2],[-J/2,K/2-b]]);
}

module SOIC(pins=8, label=""){
  //https://www.jedec.org/system/files/docs/MS-012G.pdf (max. values)
  
  b= (pins>8) ? 0.46 : 0.51; //lead width //JEDEC b: 0.31-0.51
  pitch=1.27;
  A= (pins>8) ? 1.72 : 1.75; // total height
  A1=0.25; //space below package
  c= (pins>8) ? 0.25 : 0.19; //lead thickness //JEDEC: 0.1-0.25
  D= (pins>8) ? (pins > 14) ? 9.9 : 8.65 : 4.9; //total length
 
  E1=3.9; //body width
  E=6.0; //total width
  h=0.5; //chamfer width h=0.25-0.5
  
  txtSize=D/(0.8*len(label));
  if (label)
    color("white") translate([0,0,A]) linear_extrude(0.1) 
      text(text=label,size=txtSize,halign="center",valign="center", font="consolas");
    
  //body
  color("darkSlateGrey")
    difference(){
      translate([-D/2,-E1/2,A1]) cube([D,E1,(A-A1)]);
      translate([0,E1/2+fudge,A+fudge]) 
        rotate([0,90,180]) 
          linear_extrude(D+fudge,center=true) 
            polygon([[0,0],[h+fudge,0],[0,h+fudge]]);
    }    
  //leads
  color("silver")
    for (i=[-pins/2+1:2:pins/2],r=[-90,90])
      rotate([0,0,r]) translate([E1/2,i*pitch/2,0]) lead([(E-E1)/2,b,A*0.5]);
  
}

module SSOP(pins=8,label=""){
  //Plastic shrink small outline package (14,16,18,20,24,26,28 pins)
  //https://www.jedec.org/system/files/docs/MO-137E.pdf (max. values where possible)
  
  b= 0.254; //lead width //JEDEC b: 0.2-0.3
  pitch=0.635;
  A= (pins>8) ? 1.72 : 1.75; // total height //JEDEC A: 
  A1=0.25; //space below package //JEDEC A1: 0.1-0.25
  c= (pins>8) ? 0.25 : 0.19; //lead tAickness //JEDEC: 0.1-0.25
  D= (pins>16) ? (pins > 24) ? 9.9 : 8.66 : 4.9;
  E1=3.9; //body width
  E=6.0; //total width
  h=0.5; //chamfer width h=0.25-0.5
  
  txtSize=D/(0.8*len(label));
  if (label)
    color("white") translate([0,0,A]) linear_extrude(0.1) 
      text(text=label,size=txtSize,halign="center",valign="center", font="consolas");
  
  
  //body
  color("darkSlateGrey")
    difference(){
      translate([-D/2,-E1/2,A1]) cube([D,E1,(A-A1)]);
      translate([0,E1/2+fudge,A+fudge]) 
        rotate([0,90,180]) 
          linear_extrude(D+fudge,center=true) 
            polygon([[0,0],[h+fudge,0],[0,h+fudge]]);
    }    
  //leads
  color("silver")
    for (i=[-pins/2+1:2:pins/2],r=[-90,90])
    rotate([0,0,r]) translate([E1/2,i*pitch/2,0]) lead([(E-E1)/2,b,A*0.5]);
  
}

module SOT23(pins=3, label=""){
  //http://www.ti.com/lit/ml/mpds026l/mpds026l.pdf
  //3..6 pins
  pins = (pins<3) ? 3 : (pins>6) ? 6 : pins; //limit to 6 pins max
   b= 0.5; //lead width 
  pitch= 0.95;
  A= 1.45; // total height 
  A1=0.15; //space below package 
  c= 0.22; //lead tAickness /
  D= 3.05; //total package length
  E1=1.75; //body width
  E=3.0; //total width
  h=0; //chamfer width h=0.25-0.5
  
  txtSize=D/(0.8*len(label));
  if (label)
    color("white") translate([0,0,A]) linear_extrude(0.1) 
      text(text=label,size=txtSize,halign="center",valign="center", font="consolas");
  
  
  //body
  color("darkSlateGrey")
    difference(){
      translate([-D/2,-E1/2,A1]) cube([D,E1,(A-A1)]);
      if (h)
       translate([0,E1/2+fudge,A+fudge]) 
        rotate([0,90,180]) 
          linear_extrude(D+fudge,center=true) 
            polygon([[0,0],[h+fudge,0],[0,h+fudge]]);
    }    
  //leads
  color("silver"){
    rotate([0,0,-90]) translate([E1/2,-pitch,0]) lead([(E-E1)/2,b,A*0.5]); //pin1
    if (pins>4) rotate([0,0,-90]) translate([E1/2,0,0]) lead([(E-E1)/2,b,A*0.5]); //pin2
    rotate([0,0,-90]) translate([E1/2,pitch,0]) lead([(E-E1)/2,b,A*0.5]); //pin3
    if (pins>3) rotate([0,0,90]) translate([E1/2,-pitch,0]) lead([(E-E1)/2,b,A*0.5]); //pin4
    if ((pins==3) || (pins==6)) rotate([0,0,90]) translate([E1/2,0,0]) lead([(E-E1)/2,b,A*0.5]); //pin5
    if (pins>3) rotate([0,0,90]) translate([E1/2,pitch,0]) lead([(E-E1)/2,b,A*0.5]); //pin6
  }
    
}

module lead(dims=[1.04,0.51,0.7],thick=0.2){
  
  b=dims.x*0.7; //lead length tip //JEDEC: 0.835 +-0.435
  a=dims.x-b; //JEDEC SOIC total length=1.04;
  
  translate([0,-dims.y/2,dims.z]){
    translate([-fudge,0,0]) cube([a+fudge,dims.y,thick]);
    translate([a,0,thick/2]) rotate([-90,0,0]) cylinder(d=thick,h=dims.y);
    translate([a-thick/2,0,-dims.z+thick/2]) cube([thick,dims.y,dims.z]);
    translate([a,0,-dims.z+thick/2]) rotate([-90,0,0]) cylinder(d=thick,h=dims.y);
    translate([a,0,-dims.z]) cube([b,dims.y,thick]);
  }
}