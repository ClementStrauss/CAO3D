


$fs = 0.1;
$fa = 5;

holes = 0.4;

difference(){
    cylinder(h=8, d=6, center=false);
    translate([0,0,3])cylinder(h=20, d=2, center=false);
    for (a =[0:180/10:180])translate([0,0,4])#rotate([90,0,a])cylinder(h=20, d=holes, center=true);
    //for (a =[0:180/6:180])translate([0,0,10])#rotate([90,0,a+180/12])cylinder(h=20, d=holes, center=true);
    
   
}


 translate([0,0,8])difference(){
    cylinder(h=10, d1=5, d2=3, center=false);
    translate([0,0,-1])cylinder(h=20, d=2, center=false);
}