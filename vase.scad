

//config 1
pts=360;
radius = 60;
topHeight = 100;

// change wrt angle around Z axis
angularFreq= 20;
angularPower = 3;

// change wrt to height 
heightFreq = 1;
heightPower = 10;

// step around Z
//rotStep =  360/;
rotStep = 1;

// step along height
hstep = 1.0 * 1;

// twist parameter
twist = 0;
twistVariation = 10;
twistVariationPower = 2;
freq=0;
power = 0;

function cos2(x) = (x%360) < 90 ? 1 -((x%90) / 90) 
: (x%360) < 180 ?  -((x%90) / 90) 
:  (x%360) < 270 ? -1 + ((x%90) / 90) 
:  ((x%90) / 90) ;

function pointPosition ( angle, height, twist, radius , radiusOffset ) = 
[(radius + radiusOffset) * cos(angle+twist) , (radius + radiusOffset)* sin(angle+twist), height ] ;

function diamChange(height,freq,power) = power * cos(height*freq) ;

function angularChange(angle,freq,power) = power * cos2(angle*freq);

function ivar(i,f,p) = i + p * cos(i*f);

function twistVariation(height, twistVariation ,twistVariationPower ) =  twistVariationPower *  (cos(height*twistVariation));


layerNumber = (topHeight / hstep) * 2  + 1;
pointPerLayer = pts / rotStep;
triangleNumberPerLayer = pointPerLayer * 2 ;
triangleNumberTopBottom = pointPerLayer;

layerPairNumber = layerNumber - 1;

totalPointNumber = layerNumber * pointPerLayer + 2 ;// add top / bottom center point
totalTriangleNumber = layerPairNumber * triangleNumberPerLayer + 2 * triangleNumberTopBottom;

echo(totalPointNumber);
echo(totalTriangleNumber);

points = [ for(i = [0:totalPointNumber-1]) [0 ,0 ,0]];
triangles = [ for(i = [0:totalTriangleNumber-1]) [0 ,0 ,0]];

r = points[0];    

echo(len(points));
echo(totalTriangleNumber);

for( hindex = [0:1:layerNumber])
{
    let(height = hindex * hstep)
	let(hn = height+hstep)
	{
	
		v= [for(i = [0 :rotStep: pts - rotStep])  
			pointPosition ( ivar(i,freq,power),height,height * twist + twistVariation(height,twistVariation ,twistVariationPower)  , radius,
			diamChange(height,heightFreq,heightPower) + angularChange(i,angularFreq,angularPower))];
		
		l=len(v);
				
		v2= [for(i = [0 :rotStep: pts - rotStep]) 
			pointPosition ( ivar(i,freq,power), hn , hn * twist + twistVariation(hn,twistVariation ,twistVariationPower) ,  radius,
			diamChange(hn,heightFreq,heightPower) + angularChange(i,angularFreq,angularPower))];
			
		vv1 = concat(v,v2);
		vv2 = concat(vv1,[[0,0,height]]);
		vv = concat(vv2,[[0,0,hn]]);
		face= [for(i = [0 : l - 2]) [1+i, 0+i,   (l+i),(l+i + 1) ] ];
		facep = concat(face,[ [ 0 , l-1 , l+l - 1, l ]])	;
		
		ll=len(vv);
		faceBottom= [for(i = [0 : l - 2]) [0+i, 1+i, ll-2 ] ];
		faceTop= [for(i = [0 : l - 2]) [ 1+i+l,0+i+l, ll-1 ] ];
		ff = concat(facep,faceBottom, [[l-1, 0, ll-2 ]]);
		ff2 = concat(facep,faceTop, [[ l,l-1+l, ll-1 ]]);

		if(height==0)
		{
			polyhedron( vv, ff );
		}
		else
		{
			if(height>=topHeight-hstep)
			{
				polyhedron( vv, ff2 );
			}
			else
			{
				polyhedron( vv, facep );
			}
		}
	}

}










