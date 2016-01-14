//------------------
// Adjustable Syringe Bracket
//------------------
// Nathan Vierling-Claassen
// 4/2015-1/2016
// -----------------
// * Bracket designed to install outside of a med associates behavior box
// * Designed to hold 3 separate 10mL syringes in combination with the syringe holder
// * Requires separate printing of 3 syringe brackets from this same repository
// * Syringes used as fluid reservoirs can be moved up and down the bracket to
//      control fluid flow
// * Designed for use in combination with Multi Tastant spout
// * Number labels allow tracking of syringe position each day 
//      (fluid flow can be different with different valves, weather, wear...)
// * Prints in two pieces
// * Upper piece installs with extension of grid above box
// * Lower piece fits together with upper piece braced by brackets behind assembly
// * This file generates both pieces and requires a large print bed
//      will require alterationg to print on smaller printer
// * It is helpful to hook grids together using syringe holders to make sure spacing is correct
// * Printing with low resolution works fine
// * Tested with 3mm ABS printed on a LulzBot Taz 4/5, 0.35 mm hexagon print head
// * Designed to fit outside/above to hold fluid tubes that then enter box through right side opening
//      in a Med Associates behavior box
// ------------------

// min total height of bracket, height will round up in order to evenly space openings
ht_m=430;

// number of syringes to hold
s_num=3;

// distance between braces 
// (needs to leave enough room for each syringe to not interfere with each other)
br_d=24;

// width & height of openings in bracket
o_w=8;
o_h=15;

// vertical distance between openings in bracket (center to center)
o_d=30;

// thickness of walls throughout
th=2.5;

// height of vertical support for bracket brace above box
b_d=32;

// foot depth of bracket above box, beyond depth of screw brackets 
f_d=25;

// height of screw brackets (distance of back of brace from wall attached to)
b_ht=8;

// width of screw brackets
b_w=12;

// diam of screw hole
s_d=6;

// screw hole recess depth
s_dp=3;

// screw hole width at top
s_w=9;

// calculate number of holes that will fit centered on bracket
num_holes=round(ht_m/o_d);

// alter height to be exact amount that symmetrically fits this number of holes
// end holes have th amount of plastic
ht=num_holes*o_h+(num_holes-1)*(o_d-o_h)+2*th;

// width of number label strip to left of grid
lab_w=12;

// thickness of number label strip to left of grid
lab_th=1.6;

//-----------------
// run and move specific parts here
// This set up prints both parts on same (large) print bed
//-----------------
 
 uppergrid();
 translate([s_num*(o_w+2*th)+(s_num-1)*br_d+20, -ht/2, 0])lowergrid();

//---------------
// module that makes upper piece of grid
//---------------
module uppergrid(){
    
    // remove lower portion to make upper brace 
    // ------  
    difference(){
        fullgrid();
        translate([-lab_w-1,ht/2-0.5,-1])
            cube([s_num*(o_w+2*th)+(s_num-1)*br_d+lab_w+2, ht/2+10,f_d+b_ht+th+1]);
    }
    
    // add cubes to back of join with other piece, helps hold pieces together 
    // with proper measurements during installation
    difference(){
        union(){
            translate([o_w+2*th, ht/2-b_w/2+0.5, th])cube([br_d/2-0.5, b_w-1, th]);
            translate([2*(o_w+2*th)+2*br_d-br_d/2+0.5, ht/2-b_w/2+0.5, th])cube([br_d/2-0.5, b_w-1, th]);
        }
        // remove a little extra clearance from back cubes for holding join 
        translate([0,ht/2-0.5,0])cube([s_num*(o_w+2*th)+(s_num-1)*br_d, b_w,th+0.5]);
    }
}


//-------------
// module that makes lower piece of grid
//-------------
module lowergrid(){
    
    // remove upper portion to make lower brace
    //------  
    difference(){
        fullgrid();
        translate([-lab_w-1,-1,-1])
            cube([s_num*(o_w+2*th)+(s_num-1)*br_d+lab_w+2, ht/2+0.5+1,f_d+b_ht+th+2]);
    }

    // add cubes for hooking two pieces together during installation
    //----------
    difference(){
    	union(){
    		translate([o_w+2*th+br_d/2+0.5, ht/2-b_w/2+0.5, th])cube([br_d/2-0.5, b_w-1, th]);
    		translate([2*(o_w+2*th)+br_d, ht/2-b_w/2+0.5, th])cube([br_d/2-0.5, b_w-1, th]);
    	}
        // remove a little extra clearance
    	translate([0,ht/2-b_w+0.5,0])cube([s_num*(o_w+2*th)+(s_num-1)*br_d, b_w,th+0.5]);
    }
}


//-------------------
// Module that makes the entire primary grid structure
// ------------------
// This grid is too big to print, so we split it into an upper and 
// lower portion with some supports to help the two halves fit together
//-------------------
module fullgrid() {
//-----------
    difference(){
        union(){
            // long vertical brackets for each syringe
            for (i=[1:s_num]) {
                translate([(i-1)*(o_w+2*th+br_d),0,0])cube([o_w+2*th,ht,th]);
            }
            // crossing braces where screws will go through
            cube([s_num*(o_w+2*th)+(s_num-1)*br_d,b_w,th]);
            translate([0,ht-b_w,0])cube([s_num*(o_w+2*th)+(s_num-1)*br_d,b_w,th]);
            // wider cross brace at middle
            translate([0,ht/2-3*b_w/2,0])cube([s_num*(o_w+2*th)+(s_num-1)*br_d,3*b_w,th]);

            // wider cross brace where brackets for support above box will attach
            translate([0,ht/4-b_d+b_w/2-2*th,0])cube([s_num*(o_w+2*th)+(s_num-1)*br_d,b_d+2*th,th]);
		
            // support above box across width
            difference(){
                translate([o_w+2*th,ht/4+b_w/2-th,0])cube([o_w+2*th+2*br_d-th,th,b_ht+f_d]);
                translate([o_w+2*th+br_d+th-o_w/2,ht/4+b_w/2-th-th/2,0])cube([2*o_w,2*th,1.5*b_ht]);
            }
            hull(){
                translate([o_w+2*th,ht/4+b_w/2-3*th,0])cube([th,3*th,b_ht+f_d]);
                translate([o_w+2*th,0,0])cube([th,th,3*th]);
            }
            hull(){
                translate([2*(o_w+2*th+br_d)-th,ht/4+b_w/2-3*th,0])cube([th,3*th,b_ht+f_d]);
                translate([2*(o_w+2*th+br_d)-th,0,0])cube([th,th,3*th]);
            }
        
            // extra plastic for number labels along edge of brace
            translate([-lab_w,0,0])cube([lab_w,ht,lab_th]);
        
            // bracing for above box
            translate([0,ht/4+b_w/2-th,0]){
            hull(){
                translate([o_w+2*th+br_d/4,0,0])cube([br_d/2,th,f_d+b_ht+th]);	
                translate([o_w+2*th+br_d/2-th/2,-3*th,0])cube([th,th,th]);
            }
    
            hull(){
                translate([o_w+2*th+br_d/4,0,0])cube([br_d/2,th,b_ht+th]);	
                translate([o_w+2*th+br_d/2-th/2,th-b_d,0])cube([th,th,th]);	
            }
            translate([o_w+2*th,th,0])cube([br_d,3*th,th]);
            translate([o_w+2*th+br_d/4,th,0])cube([br_d/2,2*th,b_ht+th]);
            }	
	
            translate([(s_num-2)*(br_d+2*th+o_w),ht/4+b_w/2-th,0])
            {
            hull(){
                translate([o_w+2*th+br_d/4,0,0])cube([br_d/2,th,f_d+b_ht+th]);	
                translate([o_w+2*th+br_d/2-th/2,-3*th,0])cube([th,th,th]);	
            }
    
            hull(){
                translate([o_w+2*th+br_d/4,0,0])cube([br_d/2,th,b_ht+th]);	
                translate([o_w+2*th+br_d/2-th/2,th-b_d,0])cube([th,th,th]);	
            }
            translate([o_w+2*th,th,0])cube([br_d,3*th,th]);
            translate([o_w+2*th+br_d/4,th,0])cube([br_d/2,2*th,b_ht+th]);
            }

            // cylinder supports for screws -- places between brackets at edges along 3 braces		
            translate([o_w+2*th+6,ht-b_w/2,0])cylinder(h=b_ht+th, r=b_w/2);
            translate([(s_num-1)*(o_w+2*th)+(s_num-1)*br_d-6,ht-b_w/2,0])cylinder(h=b_ht+th, r=b_w/2);
            
            translate([o_w+2*th+6,ht/2-b_w,0])cylinder(h=b_ht+th, r=b_w/2);
            translate([(s_num-1)*(o_w+2*th)+(s_num-1)*br_d-6,ht/2-b_w,0])cylinder(h=b_ht+th, r=b_w/2);
    
            translate([o_w+2*th+6,ht/2+b_w,0])cylinder(h=b_ht+th, r=b_w/2);
            translate([(s_num-1)*(o_w+2*th)+(s_num-1)*br_d-6,ht/2+b_w,0])cylinder(h=b_ht+th, r=b_w/2);
        }

        union(){
            // remove openings for syringe holders
            for (k=[1:s_num]){
                for (j=[1:num_holes]){
                    translate([(k-1)*(2*th+o_w+br_d)+th,th+(j-1)*o_d,-th/2])cube([o_w,o_h,2*th+b_ht]);
                }
            }

            // remove screw holes
            //-------------------
            // in bracing bracket above box
            translate([o_w+2*th+br_d/2,ht/4+b_w/2+1,f_d+th+b_ht-b_w/2])
                rotate(90,[1,0,0])cylinder(h=b_ht+6*th, r=s_d/2);
            translate([(s_num-2)*(br_d+2*th+o_w)+o_w+2*th+br_d/2,ht/4+b_w/2+1,f_d+th+b_ht-b_w/2])
                rotate(90,[1,0,0])cylinder(h=b_ht+6*th, r=s_d/2);
    
            // in body of bracket
            translate([o_w+2*th+6,ht-b_w/2,0])cylinder(h=b_ht+2*th, r=s_d/2);
            translate([(s_num-1)*(o_w+2*th)+(s_num-1)*br_d-6,ht-b_w/2,0])
                cylinder(h=b_ht+2*th, r=s_d/2);
    
            translate([o_w+2*th+6,ht/2-b_w,0])cylinder(h=b_ht+2*th, r=s_d/2);
            translate([(s_num-1)*(o_w+2*th)+(s_num-1)*br_d-6,ht/2-b_w,0])
                cylinder(h=b_ht+2*th, r=s_d/2);
    
            translate([o_w+2*th+6,ht/2+b_w,0])cylinder(h=b_ht+2*th, r=s_d/2);
            translate([(s_num-1)*(o_w+2*th)+(s_num-1)*br_d-6,ht/2+b_w,0])
                cylinder(h=b_ht+2*th, r=s_d/2);
    
            // remove recessed area for screw head	
            //-------------------
            // in bracing bracket above box
            translate([o_w+2*th+br_d/2,ht/4+b_w/2-s_dp,f_d+th+b_ht-b_w/2])
                rotate(90,[1,0,0])cylinder(s_dp, s_d/2, s_w/2);
            translate([(s_num-2)*(br_d+2*th+o_w)+o_w+2*th+br_d/2,ht/4+b_w/2-s_dp,f_d+th+b_ht-b_w/2])
                rotate(90,[1,0,0])cylinder(s_dp, s_d/2, s_w/2);
            
            // in body of bracket
            translate([o_w+2*th+6,ht-b_w/2,0])cylinder(s_dp, s_w/2, s_d/2);
            translate([(s_num-1)*(o_w+2*th)+(s_num-1)*br_d-6,ht-b_w/2,0])
                cylinder(s_dp, s_w/2, s_d/2);
    
            translate([o_w+2*th+6,ht/2-b_w,0])cylinder(s_dp, s_w/2, s_d/2);
            translate([(s_num-1)*(o_w+2*th)+(s_num-1)*br_d-6,ht/2-b_w,0])cylinder(s_dp, s_w/2, s_d/2);
        
            translate([o_w+2*th+6,ht/2+b_w,0])cylinder(s_dp, s_w/2, s_d/2);
            translate([(s_num-1)*(o_w+2*th)+(s_num-1)*br_d-6,ht/2+b_w,0])cylinder(s_dp, s_w/2, s_d/2);	
    
            // Make the label bar on side of grid, labeling position of each opening top to bottom
            //------------------
            font = "Liberation Sans:style=Bold";
            translate([0,0,-0.5]){
                for (i = [1:num_holes]) {
                    translate([-lab_w/2, th+o_h/2+(i-1)*o_d, 0]) {
                        mirror([0,1,0])
                        linear_extrude(height = 1.2) {
                            text(text = str(i), font = font, size = 7, halign = "center", valign="center");
                        }
                    }
                }
            }
        }
    }
}
  


