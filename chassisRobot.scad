
mainDiameter = 200;
mainThickness = 5;

// wheel Slots
wheelSlotLength = 80;
wheelSlotDepth = 35;

module wheelSlot(ypos) 
{
    translate([0, ypos,0])
  {  
     
    shift = mainDiameter/2 -wheelSlotDepth/2;
    translate([shift,0,3]) cube([wheelSlotDepth,wheelSlotLength, 10], center= true);

    translate([-shift,0,3]) cube([wheelSlotDepth,wheelSlotLength, 10], center= true);
  }
}

module motor(xShift, ypos)
{
  motorZ = 22.5;  
  motorX = 19;
  motorY = 65;  
  shaftToSide = 12;
  holesToSide = 31;
    
  shaftLength = 37;
    
  zShift =   mainThickness + motorZ/2 ;
    
  translate([xShift, ypos,0])
  {  
       // body  
      %color( "yellow", 0.3 )translate([0, motorY/2 - shaftToSide, zShift])color( "Yellow", 1.0 ) cube([motorX,motorY, motorZ], center= true);  
      
      // shaft 
      %color( "White", 0.3 ) translate([0, 0, zShift])rotate([0,90,0])cylinder(h = shaftLength, d = 5, center = true);
        
      %color( "Black", 0.3 ) translate([shaftLength/2 - 3/2, 0, zShift])rotate([0,90,0])cylinder(h = 3, d = 25, center = true);
      %color( "Black", 0.3 ) translate([- shaftLength/2 + 3/2, 0, zShift])rotate([0,90,0])cylinder(h = 3, d = 25, center = true);
    
  // holes
  
      difference()
      {
          // support  
          supportThickness = 2;
          color( "green", 1.0 )
          {
            translate([motorX/2 + supportThickness/2, holesToSide-shaftToSide , zShift])color( "Yellow", 1.0 ) cube([supportThickness,10, motorZ], center= true);  
            
            translate([- motorX/2 - supportThickness/2, holesToSide-shaftToSide , zShift])color( "Yellow", 1.0 ) cube([supportThickness,10, motorZ], center= true);
          }   
          
          centerShift = 9;  
          translate([0, holesToSide-shaftToSide , zShift + centerShift ])rotate([0,90,0])cylinder(h = 30, d = 3, center = true);
          translate([0, holesToSide-shaftToSide, zShift - centerShift ])rotate([0,90,0])cylinder(h = 30, d = 3, center = true);
      
      }
    }
}

module HBridge(Xpos, Ypos)
{
    translate([Xpos, Ypos, 0])
    {
        height = 30;
        hole2hole = 38;
        zShift = mainThickness + height/2;
        %color( "yellow", 0.3 )translate([0,0, zShift])color( "Yellow", 1.0 ) cube([43,43, height], center= true);  
        
        spacer = 2 * 2;
    
        difference()
        {
           union() 
            {
                translate([hole2hole/2, hole2hole/2, mainThickness])cylinder(h = spacer, d = 5, center = true);
                translate([hole2hole/2, -hole2hole/2, mainThickness])cylinder(h = spacer, d = 5, center = true);
                translate([-hole2hole/2, hole2hole/2, mainThickness])cylinder(h = spacer, d = 5, center = true);
                translate([-hole2hole/2, -hole2hole/2, mainThickness])cylinder(h = spacer, d = 5, 
                center = true);
            }
            
            translate([hole2hole/2, hole2hole/2, 0])cylinder(h = 100, d = 3, center = true);
            translate([hole2hole/2, -hole2hole/2, 0])cylinder(h = 100, d = 3, center = true);
            translate([-hole2hole/2, hole2hole/2, 0])cylinder(h = 100, d = 3, center = true);
            translate([-hole2hole/2, -hole2hole/2, 0])cylinder(h = 100, d = 3, center = true);
            
        }
    }
}

module Wheel(Xpos, Ypos, Zpos)
{
    %translate([Xpos, Ypos, Zpos]) color( "Black", 0.3 ) translate([0, 0, 0])rotate([0,90,0])cylinder(h = 25, d = 68, center = true);
}

module EncoderSupport(Xpos, Ypos, Zpos)
{
    holeDistance = 21;
   
    translate([Xpos, Ypos, Zpos + mainThickness ])
    {
        %union()
        {
            cube([26,4, 6], center= true);
            difference()
            {
                translate([0, 13/2 - 2, 0])cube([17,13, 6], center= true);
                translate([0, 13/2 - 2, 0])cube([6,14, 7], center= true);
            }
        }
        
        difference()
        {
            union()
            {
                translate([holeDistance/2, -3, 0])rotate([90,0,0])cylinder(h = 2, d = 6, center = true);
                translate([-holeDistance/2, -3, 0])rotate([90,0,0])cylinder(h = 2, d = 6, center = true);
                 translate([0, -2-2-2, -(Zpos)/2])cube([27,4,6+Zpos], center=true);
                 translate([27/2 - 3, -3, -(Zpos)/2])cube([6,2,6+Zpos-3], center=true);
                 translate([-27/2 + 3, -3, -(Zpos)/2])cube([6,2,6+Zpos-3], center=true);

            }
            translate([holeDistance/2, 0, 0])rotate([90,0,0])cylinder(h = 30, d = 3, center = true);
        translate([-holeDistance/2, 0, 0])rotate([90,0,0])cylinder(h = 30, d = 3, center = true);
        }
        
        
    }
}


HBridge(0, -40);

difference()
{

#color( "green", 0.3 )cylinder(h = mainThickness, d = mainDiameter);
color( "Purple", 0.2 )wheelSlot(0);
translate([0, 0, -mainThickness])color( "green", 0.3 )cylinder(h = mainThickness, d = mainDiameter);

}

motor(53, 0);
motor(-53, 0);

Wheel(80, 0, 5 + 22/2);
Wheel(-80, 0, 5 + 22/2);

difference()
{
    union()
    {
        rotate([30,0,0])EncoderSupport(35, -8, 22/2);
        rotate([30,0,0])EncoderSupport(-35, -8, 22/2);
    }
    translate([0, 0, -100])color( "green", 0.3 )cylinder(h = 100, d = mainDiameter);
}


bottom = 15;
//translate([0, 0, -bottom])cylinder(h = bottom, d = 10);
wheelDiam = 15;
wheelHole=4;

shift = 3;
Yshift = 90;




//sub : bearing
translate([0, Yshift, 0])rotate([0,0,0])cylinder(h = 5, d = 14);

//spacer
spacerDiam=7;
translate([0, Yshift, -1])rotate([0,0,0])cylinder(h = 1, d = spacerDiam);

// baseplate
//translate([0, Yshift, -3])rotate([0,0,0])cylinder(h = 2, d = wheelDiam + 2);

//vertical shaft
translate([0, Yshift, 0])rotate([0,0,0])cylinder(h = 20, d = 5);

//wheel
%color( "Green", 0.7 )translate([-3, Yshift+5, -wheelDiam/2 -2 -2 ])rotate([0,90,0])cylinder(h = 6, d = wheelDiam);
//wheel axis
translate([-10, Yshift+5, -wheelDiam/2 -2 - 2])rotate([0,90,0])cylinder(h = 20, d = wheelHole);

color( "Blue", 0.7 )translate([-2-3, Yshift-7, -3])cube([10,16,2]);

difference()
{
    
color( "Blue", 0.7 )translate([-2-3, Yshift-7, -wheelDiam/2 -2 - 2 -4])cube([2,16,13]);
color( "Blue", 0.7 )translate([-2-5, 48, -3])rotate([-60,0,0])cube([20,50,30]);
}



