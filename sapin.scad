 
 $fs = 0.5;
 $fa = 1;


//

module cone (angle, angle2, sizeTop, sizeDown, height)
{
   minkowski()
    {
        hull()
        {
            difference()
            {
                cylinder(  height, d1=sizeDown,  d2=sizeTop);
                translate([0,0,0])rotate([angle2,0,angle])cube([100,100,10], center=true);
            }
            translate([0,0,-1])cylinder(  0.1, d1=sizeDown-10,  d2=sizeDown-10);
        }
        sphere(r = 2, $fn = 80);
    }
}


cone(0,3,0,40,40);
d=28;
translate([0,0,-35])cone(360/3,3,d,d+40,40);
d2=40+15;
translate([0,0,-70])cone(2*360/3,0,d2,d2+40,40);
