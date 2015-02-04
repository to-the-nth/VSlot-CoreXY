// jhead Hotend Bowden Mount
// Author: sdavi

//Inspired by imrahil's jhead mount: http://www.thingiverse.com/thing:148536
//and sauce71's E3D FanfanfanDuct: https://www.youmagine.com/designs/e3d-fanfanfanduct#!design-information
// and http://www.thingiverse.com/thing:108273



//Designed to fit verical X-Carriage using the 30mm spaced mounting holes
//uses 3 25mm fans

include <../configuration.scad>


//pneumatic_thread = 9/2; //1/8 BSP
pneumatic_thread = 5.5/2; //6mm thread

//feed_hole = 2.2; //1.75mm filament
feed_hole = 3.5; // 3mm filament



jhead_mount_fan();
//jhead_mount();
//calibration();

//bowden_holder2(); //ziptie
//bowden_holder();



module jhead_mount_fan(){
	//fan end only
	translate([0, -15, 0]){
   	 intersection() {
   	   mounting_plate();
   	   separator();
   	 }
 	}
}

module jhead_mount(){
	// carriage end only
	difference() {
	    mounting_plate();
	    separator();//
	}
}


padding = 0.1; //if holes print small can make them a bit bigger

jhead_top_diameter = 16 + padding; 
jhead_top_height = 4.8+0.9; //5.7 small gap
jhead_recess_diameter = 12.1 + padding;
jhead_recess_height = 4.5;



//*** mounting plate settings***
mounting_screws_distance = 30; //distance between mounting screws on X-carriage
mounting_screw_diameter = 3.2;
//

plate_width = 50;
plate_length = 32;
plate_depth = 9;

bowden_thickness = 6.8;


extra_length=45-6;
delta_length=extra_length-plate_length;
arm_width=plate_depth;

//fan shroud
sSize = 27;	
sDepth = 10;
sDia = 22; 



module fanShroud(){

	

	difference(){
		union(){

			linear_extrude(height = sSize, center = false, convexity = 10, twist = 0){
				hull(){
					square([sSize,5]);
					translate([sSize/2,sDepth])circle(d=sDia+4);
				}
			}

			//tabs for cooling fans
			translate([5,0,6])rotate([0,180-30,0])coolingFin();
			translate([5+18,0,6])mirror([1,0,0])rotate([0,180-30,0])coolingFin();


		}
		color("red")translate([sSize/2, 5-0.1 ,sSize/2 ])rotate([90,0,0])cylinder(d=22, h=5, $fn=60);//entry
		color("green")translate([sSize/2,sDepth+14, -0.1])cylinder(d=16.5, h=sSize+0.2); //smaller for bottom
		color("green")translate([sSize/2,sDepth+6, -0.1])cylinder(d=4, h=sSize+0.2, $fn=30); //small hole to let thermistor wires not get squashed


		color("green")translate([sSize/2,sDepth+18/2, 3])cylinder(d=18, h=sSize); //larger for main


		//translate([0,sDepth+22/4,0])cube([35,10,35]);//chop jdhead end
		translate([0,sDepth+22/4+4,0])cube([35,10,35]);//chop jdhead end
		translate([0,-5,0])cube([35,5,35]); //chop fan end
		translate([0,0,sSize-(sSize-25)/2])cube([35,25,2]); //chop top to be flush with fan

		hull(){
			translate([sSize/2, 6 ,sSize/2 ])rotate([90,0,0])cylinder(d=22, h=1, $fn=60);
			translate([sSize/2,sDepth, 2+8])cylinder(d=18, h=10);
		}
	
		//screw holes 
		translate([sSize/2-20/2, -0.1 ,sSize/2-20/2 ])rotate([-90,0,0])cylinder(d=2.5, h=5, $fn=6);
		translate([sSize/2+20/2, -0.1 ,sSize/2-20/2 ])rotate([-90,0,0])cylinder(d=2.5, h=5, $fn=6);
		translate([sSize/2-20/2, -0.1 ,sSize/2+20/2 ])rotate([-90,0,0])cylinder(d=2.5, h=5, $fn=6);
		translate([sSize/2+20/2, -0.1 ,sSize/2+20/2 ])rotate([-90,0,0])cylinder(d=2.5, h=5, $fn=6);

	}
}


module coolingFin(){	
	difference(){
		cube([15, 11+8, 4]); 		
		translate([10,11/2+8,-0.1]) cylinder(d=2.5, h=4+0.2);
		translate([10,11/2,-0.1]) cylinder(d=2.5, h=4+0.2);

	}
	
}




module bowden_holder(){

	//bowden holder
	difference(){
		union(){


			hull(){ //
				translate([plate_width/2-16/2,plate_length-5,0])
					cube_fillet([16, 5, 6], top=[0,0,0,0]);
				translate([plate_width/2-33/2,plate_length-5,-15]) 
					cube([33,5,15]);
			}
			
			hull(){ //top part
				translate([plate_width/2-16/2,plate_length-5,0])
					cube_fillet([16, 5, 6], top=[0,0,0,0]);
				translate([plate_width/2,plate_length/2, 0]) 
					cylinder(d=6+6, h=6, $fn=20);
				
			}
		}
		// tube holder hole
		translate([plate_width/2,plate_length/2,0])
			cylinder(d=6.5, h=6+0.2, $fn=20);

		translate([plate_width/2-25/2, plate_length+0.1, -15+1.5+3])
			rotate([90,0,0])cylinder(d=3.1, h=5+0.2);
		translate([plate_width/2+25/2, plate_length+0.1, -15+1.5+3])
			rotate([90,0,0])cylinder(d=3.1, h=5+0.2);
	}

}

module bowden_holder2(){

	//bowden holder with zipties
	difference(){
		union(){


			color("yellow")hull(){ //
				translate([plate_width/2-36.5/2,plate_length-5,0])
					cube_fillet([36.5, 5, 8], top=[0,0,0,0]);
				translate([plate_width/2-40/2,plate_length-5,-15]) 
					cube([40,5,15]);
			}
			
			hull(){ //top part
				translate([plate_width/2-16/2,plate_length-5,0])
					cube_fillet([16, 5, 8], top=[0,0,0,0]);
				translate([plate_width/2,plate_length/2, 0]) 
					cylinder(d=6+6, h=8, $fn=20);
				
			}
		}
		// tube holder hole
		translate([plate_width/2,plate_length/2,0])
			cylinder(d=6.5, h=8+0.2, $fn=20);

		//zip tie
		translate([plate_width/2,plate_length/2,8/2-2]){
			difference(){
				cylinder(d=6.5+15, h=4, $fn=35);
				cylinder(d=6.5+15-4, h=4, $fn=35);

			}
		}



		translate([plate_width/2-10,plate_length/2-10,0]) cube([20,10,10]);

		translate([plate_width/2-25/2, plate_length+0.1, -15+1.5+3])
			rotate([90,0,0])cylinder(d=3.1, h=5+0.2);
		translate([plate_width/2+25/2, plate_length+0.1, -15+1.5+3])
			rotate([90,0,0])cylinder(d=3.1, h=5+0.2);
	}

}

/*
	Calibration piece to ensure mount for hotend will fit (this should be a tight fit)
*/
module calibration(){
	difference(){
		cube([jhead_top_diameter+2, jhead_top_diameter+2, plate_depth]);
		translate([(jhead_top_diameter+2)/2,(jhead_top_diameter+2)/2,0]) hotend_mount();
		cube([jhead_top_diameter+2, (jhead_top_diameter+2)/2, plate_depth]);
	}

}


module jhead_Mount() {

  translate([0, -15, 0]){
    intersection() {
      mounting_plate();
      separator();
    }
  }

  difference() {
    mounting_plate();
    separator();
  }
}



module mounting_plate(){

	difference(){
		union(){
			translate([0,plate_length-extra_length,0])cube_fillet([plate_width, extra_length, plate_depth], center=false, vertical=[3,3,0,0], $fn=60);
		
			//cabletie blocks
			translate([-arm_width/2,-7,0]) 
				cube_fillet([arm_width, 12, plate_depth], vertical=[0,0,0,0], $fn=12);
			translate([plate_width,-7,0]) 
				cube_fillet([arm_width/2, 12, plate_depth], vertical=[0,0,0,0], $fn=12);
				
			//pneumatic rounded triangle
			hull(){
				translate([0,plate_length-7,plate_depth]) 
					cube_fillet([plate_width,7,7+1.2], vertical=[3,3,3,3]);
				translate([plate_width/2,plate_length/2,plate_depth])  
						cylinder(r=20/2,  h=7+1.7, $fn=20);
			}
			hull(){
				color("green") translate([plate_width/2,plate_length/2,jhead_recess_height+jhead_top_height+7])
					cylinder(r=pneumatic_thread+4, h=10, $fn=20);
				translate([plate_width/2,plate_length/2,plate_depth])  
						cylinder(r=20/2,  h=7+1.7, $fn=20);
				
			}	
					
			translate([plate_width/2-sSize/2,-10+3,-25-1]) fanShroud();



		} //end union

		//x-carriage holes
		translate([plate_width/2, plate_length/2, plate_depth/2]) rotate([90,0,0]){
			translate([-mounting_screws_distance/2, 0, 0]) 
				cylinder(r=m3_diameter/2, h=plate_length+0.1, center=true);
			translate([+mounting_screws_distance/2, 0, 0]) 
				cylinder(r=m3_diameter/2, h=plate_length+0.1, center=true);
		}

		//countersunk holes for carriage screws
		translate([plate_width/2, 7/2-delta_length/2-2, plate_depth/2]) rotate([90,0,0]){
			translate([-mounting_screws_distance/2, -0.5/2, 0])
				cylinder(r=m3_washer_diameter/2, h=7+delta_length+0.5, center=true, $fn=32);
			translate([+mounting_screws_distance/2, -0.5/2, 0]) 
				cylinder(r=m3_washer_diameter/2, h=7+delta_length+0.5, center=true, $fn=32);
		}

		//cable grooves for ziptie 
		translate([-arm_width/2,0-0.3,-0.1]) 
			cylinder(r=6/2, h=plate_depth+0.2, center=false);  
		translate([plate_width+arm_width/2,0-0.3,-0.1]) 
			cylinder(r=6/2, h=plate_depth+0.2, center=false);  

		//cable ziptie left
		translate([-arm_width/2+1,0-0.3,plate_depth/2-5/2]){
 			difference(){
				cylinder(r=9, h=5, center=false);  
				cylinder(r=7, h=5, center=false);  
			}
		}
		//cable ziptie right
		translate([plate_width+arm_width/2,0-0.3,plate_depth/2-5/2]){
 			difference(){
				cylinder(r=9, h=5, center=false);  
				cylinder(r=7, h=5, center=false);  
			}
		}






		translate([plate_width/2, plate_length/2, 0]) hotend_mount();


		//feed hole
		translate([plate_width/2,plate_length/2,jhead_recess_height+jhead_top_height])
			cylinder(d=feed_hole, h=7+1.7+10, $fn=20);


		//cone for filament guide
		color("green") translate([plate_width/2,plate_length/2,jhead_recess_height+jhead_top_height+2])
			//cylinder(r=pneumatic_thread, h=10, $fn=20);
			cylinder(r2=pneumatic_thread, r1=feed_hole/2, h=7, $fn=20);

		//pneumatic hole
		color("green") translate([plate_width/2,plate_length/2,jhead_recess_height+jhead_top_height+9])
			cylinder(r=pneumatic_thread, h=10+0.1, $fn=20);





		//hole for the thermistor wires
		translate([plate_width/2, 3, -6])cylinder(d=9, h=plate_depth+6+0.1, $fn=60);

		
	}//end difference


	//fill top of countersink to print without supports, drill out
	translate([plate_width/2, 7/2-delta_length/2-2, plate_depth/2]) rotate([90,0,0]){
		translate([-mounting_screws_distance/2, -0.5/2, 0])
			cylinder(r=m3_washer_diameter/2+0.8, h=0.3, center=true, $fn=32);
		translate([+mounting_screws_distance/2, -0.5/2, 0]) 
			cylinder(r=m3_washer_diameter/2+0.8, h=0.3, center=true, $fn=32);
		}


}

module roundedArmJoint(){
	difference(){
				cube([6/2, 6/2, plate_depth]);
				translate([6/2,0,0]) 
					cylinder(r=6/2, h=plate_depth, center=false, $fn=60);

			}
}


module hotend_mount(){

//cutout for jhead  tight fit
		
	translate([0,0,-0.1])cylinder(r=jhead_recess_diameter/2, h=jhead_recess_height+0.2, center=false, $fn=60);
	translate([0,0,jhead_recess_height])
		cylinder(r=jhead_top_diameter/2, h=jhead_top_height, center=false, $fn=60);

}


module separator() {
  translate([plate_width/2, -38, plate_depth/2-35/2]){
	cylinder(r=110/2, h=jhead_recess_height+jhead_top_height+35, center=true, $fn=64); 
  }
}







