
module ShopVacTube(length=50, thickness=1.5, elbow=false)
{
    if (thickness < 0.5) {
        thickness = 0.5;
    }
    TubeOD = 31.2;
    TubeOR = TubeOD / 2;
    TubeID = TubeOD - thickness;
    TubeIR = TubeID / 2;

    Tube0Z = 0;
    Tube0H = 16;
    LipZ = Tube0Z + Tube0H;
    LipH = 5;
    LipW = 1.5;
    Tube1Z = LipZ + LipH;
    Tube1H = 14;
    Flange0Z = Tube1Z + Tube1H;
    Flange0H = 2;
    Flange0W = 2;
    Tube2Z = Flange0Z + Flange0H;
    Tube2H = 3;
    Flange1Z = Tube2Z + Tube2H;
    Flange1H = 2;
    Flange1W = 3;
    Flange2Z = Flange1Z + Flange1H;
    Flange2H = 2;
    Flange2W = 1;
    Tube3Z = Flange2Z + Flange2H;
    Tube3H = TubeOD;

    if (length < Tube3Z + Tube3H) {
        length = Tube3Z + Tube3H;
    }

        difference() {
            // build the outside
            union() {
                cylinder(h=Tube0H, r=TubeOR);
                translate([0,0,LipZ])
                    cylinder(h=LipH, r=TubeOR + LipW, r1=TubeOR);
                translate([0,0,Tube1Z])
                    cylinder(h=Tube1H, r=TubeOR);
                translate([0,0,Flange0Z])
                    cylinder(h=Flange0H, r=TubeOR + Flange0W);
                translate([0,0,Tube2Z])
                    cylinder(h=Tube2H, r=TubeOR);
                translate([0,0,Flange1Z])
                    cylinder(h=Flange1H, r=TubeOR + Flange1W);
                translate([0,0,Flange2Z])
                    cylinder(h=Flange2H, r=TubeOR + Flange2W);
                if (elbow) {
                    translate([0,-Tube3H*1.4, Tube3Z])
                        rotate([-90,0,0])
//                    difference() {
                        translate([Tube3H,0,Tube3Z])
                            rotate_extrude(height=Tube3H, convexivity=45)
                                translate([16,0,0])
                                    circle(r=TubeOR);
                        //translate([-Tube3H/2,0,Tube3Z-Tube3H/2])
                        //    cube(Tube3H*1.5);
                        //translate([Tube3H,0,Tube3Z-Tube3H/2])
                        //    cube(Tube3H*1.5);
                        //translate([Tube3H,-Tube3H*1.5,Tube3Z-Tube3H/2])
                        //    cube(Tube3H*1.5);
//                    }
                    cylinder(h=Tube3H/2, r=TubeOR);
                } else {
                    #translate([0,0,Tube3Z])
                        cylinder(h=Tube3H, r=TubeOR);
                }
            }
            // then scrape out the inside
            union() {
                // bevel this edge a bit...
                translate([0,0,-(TubeOR-TubeIR)/3])
                    cylinder(h=TubeOD / 2, r=0, r1=TubeOR);
                // then cut out the whole tube inside
                // now bevel the top
                if (elbow) {
                    translate([0,0,-0.001])
                        cylinder(h=Tube3Z+0.002, r=TubeIR);
//                    translate([0,-Tube3H*1.4, Tube3Z])
//                        rotate([-90,0,0])
//                    difference() {
//                        translate([Tube3H,0,Tube3Z])
//                            rotate_extrude(height=Tube3H, convexivity=45)
//                                translate([-Tube3H,0,0])
//                                    circle(r=TubeIR);
//                        translate([-Tube3H/2,0,Tube3Z-Tube3H/2])
//                            cube(Tube3H*1.5);
//                        translate([Tube3H,0,Tube3Z-Tube3H/2])
//                            cube(Tube3H*1.5);
//                        translate([Tube3H,-Tube3H*1.5,Tube3Z-Tube3H/2])
//                            cube(Tube3H*1.5);
//                    }

                } else {
                    translate([0,0,-0.001])
                        cylinder(h=Tube3Z + Tube3H + 0.002, r=TubeIR);
                    //#translate([0,0,Tube3Z + Tube3H/2 + (TubeOR-TubeIR)/3])
                        cylinder(h=TubeOD / 2, r=TubeOR, r1=0);
                }
            }
        }
}


ShopVacTube(elbow=1);
