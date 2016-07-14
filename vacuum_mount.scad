
mount_diameter=61;
mount_radius=mount_diameter/2;
thickness=3;
height=30;
mount_width=12.5;
mount_depth=7;
pi=3.14;

vacuum_diameter=36;
vacuum_radius=vacuum_diameter/2;
vacuum_center=-(mount_radius + thickness*2 
                + vacuum_radius + mount_depth);

module tube(h, r, t) {
    difference() {
        cylinder(h=h, r=r);
        cylinder(h=h, r=r-t);
    }
}
module notcher(h, w, d) {
    difference() {
        translate([0,0,h/3]) cube([d, w*3, h*2]);
        cube([d, h, w*2/3]);
        cube([d, h*2/3, w]);
        translate([0,w*2/3,h*2/3])
            rotate ([0,90,0]) cylinder(h=d, r=h/3);
        translate([0,w*6/3,0]) cube([d, h, w*2/3]);
        translate([0,w*7/3,0]) cube([d, h*2/3, w]);
        translate([0,w*7/3,h*2/3])
            rotate ([0,90,0]) cylinder(h=d, r=h/3);
    }
}


translate([-100, -100, 0]) notcher(40, 40, 40);

difference() {
    union() {
        // big cylindar
        cylinder(height, r=mount_radius+thickness);
        // build our screw plate
        translate([-(mount_radius+mount_depth+thickness),
                   -(mount_width+(thickness*2))/2,
                      height/2])
            cube([thickness, mount_width+(thickness*2),
                  height/2]);
        // and the near wall
        translate([-(mount_radius+mount_depth+thickness),
                   -(mount_width/2)-thickness,
                   height/2])
            cube([mount_depth+thickness*2, thickness,
                  height/2]);
        // and the far wall
        translate([-(mount_radius+mount_depth+thickness),
                   (mount_width/2),
                   height/2])
            cube([mount_depth+thickness*2, thickness,
                  height/2]);
        // put some walls on it to hang the curtain from
        rotate([0,0,-11.5])
            translate([-60,-33.5,0]) cube([64,thickness,height/2]);
        rotate([0,0,11.5])
            translate([-60,30.5,0]) cube([64,thickness,height/2]);
        // and a floor...
        translate([-59,-30,height/2-thickness])
            cube([70,60,thickness]);
        // make the vacuum hose mount
        translate([vacuum_center, 0, 0])            
            cylinder(height/2, r=vacuum_radius+thickness);
    }
    // put a screw hole starter in our screw plate
    translate([-(mount_radius+mount_depth+thickness),
               0, height/2+10])
        rotate([0,90,0])
            cylinder(thickness, r=2);
    
    // put a screw hole starter in our vacuum ring
    translate([-(mount_radius+mount_depth+thickness*3+vacuum_diameter)-2,
               0, 10])
        rotate([0,90,0])
            cylinder(thickness+5, r=2);
    // now cut our big holes
    cylinder(height, r=mount_radius);
    translate([-(mount_radius+vacuum_radius
               +(thickness*2)+mount_depth),
               0])
        cylinder(height, r=vacuum_radius);
    
    // cut out where our main spindle support structure is
    translate([-20, mount_radius-10, height/2])
        cube([40, 20, height/2]);
    // cut out our spindle mount clamp screw rail
    translate([mount_radius-7, -10, height/2])
        cube([20, 24, height/2]);
    // cut out our mounting rail
    translate([-(mount_radius+thickness*2),
               -(mount_width/2), height/2])
        cube([6, mount_width, height/2]);
    // add some cutouts to ease mounting
    rotate(a=[0,0,-30]) {
        translate([-thickness/2,
                   -(mount_radius+thickness),
                   height/2])
            cube([1,thickness*1.1,height/2]);
    }
    // add some cutouts to ease mounting
    rotate(a=[0,0,30]) {
        translate([-thickness/2,
                   -(mount_radius+thickness),
                   height/2])
            cube([1,thickness*1.1,height/2]);
    }
    // and trim the flared sides of our floor off.
    translate ([-64,-(35.5+thickness),height/2])
        rotate([-90,0,-11.5])            
            cube([68,thickness*2,height/2+2]);
    translate ([-64,(18+thickness),height/2+1])
        rotate([-90,0,11.5])            
            cube([68,thickness*2,height/2]);
}

