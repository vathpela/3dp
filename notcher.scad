
module tube(h, r, t) {
    difference() {
        cylinder(h=h, r=r);
        cylinder(h=h, r=r-t);
    }
}

module notcher(w, d, h) {
    scale([4/5,1,3/5]) {
        translate([-w,+h/2,-d]) {
	    rotate([90,0,0]) {
		difference() {
		    union() {
			minkowski() {
			    cube([w,h,d/2]);
			    translate([w/9,w/9,0]) cylinder(h=d/2, r=w/9);
			}
			translate([w,h+w/9,0]) cube([w*3/9,w/9,d]);
			translate([-w/9,h+w/9,0]) cube([w*3/9,w/9,d]);
		    }
		    translate([-w/9,h+w/9,0]) cylinder(h=d, r=w/9);
		    translate([w+w*3/9,h+w/9,0]) cylinder(h=d, r=w/9);
		}
	    }
        }
    }
}
