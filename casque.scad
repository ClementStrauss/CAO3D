

Longueur=80;
largeur = 15;
H = 2;


difference()
{
union()
{
    translate([0,-largeur/2,0])cube([Longueur,largeur,H]);
    cylinder(h=H, d=largeur);
    translate([Longueur,0,0])cylinder(h=H, d=largeur);
}

Longueur2=50;
largeur2 = 5;
H2 = 10;

translate([0,0,-1])union()
{
    translate([0,-largeur2/2,0])cube([Longueur2,largeur2,H2]);
    cylinder(h=H2, d=largeur2);
    translate([Longueur2,0,0])cylinder(h=H2, d=largeur2);
}

Longueur3=100;
largeur3 = 10;
H3 = 1;
#translate([0,0,0])union()
{
    translate([0,-largeur3/2,0])cube([Longueur3,largeur3,H3]);
    cylinder(h=H3, d=largeur3);
    translate([Longueur3,0,0])cylinder(h=H3, d=largeur3);
}


}