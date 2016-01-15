//---------------------
// 10 mL Syringe Holder
//---------------------
// Nathan Vierling-Claassen
// 4/2016-1/2016
//---------------------
// ** 10 mL Syringe holder to fit with adjustable syringe bracket
// ** If adjusting dimensions, make sure dimensions are compatible with the 
// ** check that dimensions are compatible with adjustable_fluid_bracket.scad
// ** measurements in mm
//---------------------

// thickness of bracket wall (needs to be same as bracket)
th=2.5;

// thickness of wall around syringe (can be thinner)
th_w=1.5;

// height and width of opening of holes in bracket (needs to be same as bracket) 
o_w=8;
o_h=15;

// distance between opening holes in bracket (center to center)
// (needs to be same as bracket)
o_d=30;

// clearance distance to allow parts to fit together smoothly
cl=1.4;

// syringe diameter
s_d=17.2;

// distance of syringe wall from brace
d_sw=10;

difference(){
    union(){
        //outer cylinder for syringe, extended to support further down syringe
        cylinder(h=4.5*o_w+2*th, r=s_d/2+th_w,center=false);	
        // cube for bracket (1)
        translate([s_d/2,-o_w/2+cl/2,0])cube([d_sw+th+cl,o_w-cl,2*th]);
        // hook behind hole (1)
        translate([s_d/2+d_sw+th+cl/2,-o_w/2+cl/2,0])cube([1.5*th+.5,o_w-cl,o_h-2*cl]);
        // cube for bracket (2)
        translate([s_d/2,-o_w/2+cl/2,o_d])cube([d_sw+th+cl,o_w-cl,2*th]);
        // hook behind hole (2)
        translate([s_d/2+d_sw+th+cl/2,-o_w/2+cl/2,o_d])cube([1.5*th+.5,o_w-cl,o_h-2*cl]);
        // cube that supports back bracket
        translate([0,-o_w/2-th-th_w,0])cube([s_d+th_w,o_w+2*th+2*th_w,4.5*o_w+2*th]);
        // reinforce front brace
        translate([-s_d/2-th_w,-4,0])cube([2*th,8,4.5*o_w+2*th]);    
    }
    union(){
        // remove inner cylinder for syringe
        translate([0,0,-th/2])cylinder(h=3*th+4.5*o_w, r=s_d/2,center=false);

        // remove part of cylinder below full circle holder to serve as tray/brace deeper on syringe		
        rotate(45,[0,0,1])translate([-s_d/2+1.5*th+1,0,o_w+1.5*th])cube([s_d-0.5*th,s_d/2+2*th,2*o_w+2*th]);
        rotate(-45,[0,0,1])translate([-s_d/2+1.5*th+1,-s_d/2-2*th,o_w+1.5*th])cube([s_d-0.5*th,s_d/2+2*th,2*o_w+2*th]);

        // take away inside of cube that goes flat on bracket
        translate([s_d/2+th/2,-o_w/2-th,-1])cube([d_sw-th,o_w+2*th,4.5*o_w+2*th+2]);

        // remove lattice from upper part of brace (reduces print time, looks nice)
        translate([0,0,1.5]){
            for(i=[0:7]){
                rotate(i*45,[0,0,1]){
                    translate([-s_d/2-th,0,0])rotate(45,[1,0,0])cube([s_d+2*th,th,th]);
                    translate([-s_d/2-th,0,2*th])rotate(45,[1,0,0])cube([s_d+2*th,th,th]);
                }

                translate([0,0,th])rotate(i*45+45/2,[0,0,1]){
                    translate([-s_d/2-th,0,0])rotate(45,[1,0,0])cube([s_d+2*th,th,th]);
                }
            }
        }
    }
}
        
// cube to support against bracket            
difference(){
    // cube to hold holder flat on bracket
    translate([s_d/2,-o_w/2-th-th_w,0])cube([d_sw,o_w+2*th+2*th_w,4.5*o_w+1.5*th]);
    // take away inside of cube that goes flat on bracket
    translate([s_d/2+th/2,-o_w/2-th,-1])cube([d_sw-th,o_w+2*th,4.5*o_w+2*th+2]);
}


