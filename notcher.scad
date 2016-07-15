
module tube(h, r, t) {
    difference() {
        cylinder(h=h, r=r);
        cylinder(h=h, r=r-t);
    }
}

module notcher(x, y, z) {
    rotate([180,0,90]) {
        translate([-x/2, -y, -z]) {
            difference() {
                union() {
                    minkowski() {
                        translate([0,0,z-x*.1])
                            rotate([-90,0,0]) cylinder(h=1,r=x*.1);
                        translate([x*.1,0,x*.2])
                            cube([x*.8,y-1,z-x*.2]);
                    }
                    translate([-x*.1,0,z]) cube([x*.2,y,x*.1]);
                    translate([x*.9,0,z]) cube([x*.2,y,x*.1]);
                }
                translate([-x*0.1,-y*0.0005,z+x*.1])
                    rotate([-90,0,0]) cylinder(h=y*1.001, r=x*.1);
                translate([x*1.1,-y*0.0005,z+x*.1])
                    rotate([-90,0,0]) cylinder(h=y*1.001, r=x*.1);
                translate([-x*0.1,0,0]) cube([x*1.2,y,z]);
            }
        }
    }
}
