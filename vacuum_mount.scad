
mount_center=0;
mount_diameter=61;
mount_radius=mount_diameter/2;
thickness=2;
height=30;
mount_width=12.5;
mount_depth=7;

screw_hole_radius=3.75/2;

vacuum_diameter=38;
vacuum_radius=vacuum_diameter/2;
vacuum_center=65;

far_mount_peak = [0+thickness/2, mount_radius + thickness/2];
far_vacuum_peak = [-vacuum_center-thickness/2,
                   vacuum_radius + thickness/2];
near_mount_peak = [0+thickness/2, -(mount_radius + thickness/2)];
near_vacuum_peak = [-vacuum_center-thickness/2,
                    -(vacuum_radius + thickness/2)];
registration_x = 4.6;
registration_y = 3.1;
registration_z = 3.7;

include <notcher.scad>
include <geometry.scad>

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
        d = distance(far_mount_peak, far_vacuum_peak);
        c = center(far_mount_peak, far_vacuum_peak);
        rotate([0,0,mount_radius - vacuum_radius - thickness/2])
            translate([(far_vacuum_peak[0]+far_mount_peak[0])/2
                        -d/2, mount_radius, 0])
                cube([d,thickness,height/2]);

        d = distance(near_mount_peak, near_vacuum_peak);
        c = center(near_mount_peak, near_vacuum_peak);
        rotate([0,0,-(mount_radius-vacuum_radius-thickness/2)])
            translate([(near_vacuum_peak[0]
                        +near_mount_peak[0])/2-d/2,
                       -(mount_radius+thickness),0])
                cube([d,thickness,height/2]);

        // and a floor...
        translate([-vacuum_center,-mount_radius,
                   height/2-thickness])
            cube([vacuum_center,mount_diameter,thickness]);
        // make the vacuum hose mount
        translate([-vacuum_center, 0, 0])
            cylinder(height/2, r=vacuum_radius+thickness);
        // hide the back of our vacuum registration
        translate([-(vacuum_center-vacuum_radius),
                   -(registration_y/2+thickness/2),
                   height/2-registration_z-thickness*2])
            cube([registration_x,
                  registration_y+thickness,
                  registration_z+thickness]);
    }
    // put a screw hole starter in our screw plate
    #translate([-(mount_radius+mount_depth+thickness+1),
               0, height/2+10])
        rotate([0,90,0])
            cylinder(thickness+2, r=screw_hole_radius);

    // put a screw hole starter in our vacuum ring
    #translate([-(vacuum_center+vacuum_radius+thickness+1), 0, 10])
        rotate([0,90,0])
            cylinder(thickness+2, r=screw_hole_radius);
    // now cut our big holes
    translate([0,0,-height/2])
        cylinder(height*2, r=mount_radius);
    translate([-vacuum_center,0,-height/4])
        cylinder(height, r=vacuum_radius);

    // cut out where our main spindle support structure is
    #translate([-20, mount_radius-10, height/2])
        cube([40, 20, height]);
    // cut out our spindle mount clamp screw rail
    #translate([mount_radius-7, -10, height/2])
        cube([20, 24, height]);
    // cut out our mounting rail
    #translate([-(mount_radius+thickness*2),
               -(mount_width/2), height/2])
        cube([8, mount_width, height]);
    // add some cutouts to ease mounting
    #rotate(a=[0,0,-30]) {
        translate([-thickness/2,
                   -(mount_radius+thickness*3/2),
                   height/2])
            cube([1,thickness*2,height/2]);
    }
    #rotate(a=[0,0,30]) {
        translate([-thickness/2,
                   -(mount_radius+thickness*3/2),
                   height/2])
            cube([1,thickness*2,height/2]);
    }
    // also bevel the edges of the mounting hole
    #translate([0,0,thickness/2])
        cylinder(h=height, r=mount_radius+thickness, r1=0);
    translate([0,0,-thickness/2])
        cylinder(h=height, r0=0, r1=mount_radius+thickness);

    // and trim the flared sides of our floor off.
    #translate([-(vacuum_center+thickness*2),
               -(vacuum_radius*2+thickness*25/32),0])
        rotate([0,0,-(mount_radius-vacuum_radius-thickness/2)])
            cube([distance(near_mount_peak, near_vacuum_peak)
                  +thickness*2, vacuum_radius, height]);
    #translate([-(vacuum_center+thickness*2),
               (vacuum_radius+thickness*20/32),0])
        rotate([0,0,(mount_radius-vacuum_radius-thickness/2)])
            cube([distance(far_mount_peak, far_vacuum_peak)
                  +thickness*2, vacuum_radius, height]);

    // notch out registration on the vaccum tube holder
    translate([-(vacuum_center-vacuum_radius-2.7),
               0,height/2+0.07])
        notcher(registration_x, registration_y, registration_z);

    // and bevel its edge just a bit
    #translate([-vacuum_center, 0, -height/2+thickness])
        cylinder(h=height, r=vacuum_radius+thickness, r1=0);
    #translate([-vacuum_center, 0, -thickness])
        cylinder(h=height, r=0, r1=vacuum_radius+thickness);
}
