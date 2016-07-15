
DysonLength = 50;

module DysonConnector(WallThickness = 3, h = 50)
{
    if (WallThickness < 0.5) {
        WallThickness = 0.5;
    }
    if (h < 50) {
        h = 50;
    }
    DysonOD = 34.1;
    DysonOR = DysonOD / 2;
    DysonID = DysonOD - WallThickness * 2;
    DysonIR = DysonID / 2;

    BaseTubeH = 10;
    BaseTubeZ = BaseTubeH;
    LedgeH = 4.5;
    LedgeZ = BaseTubeZ + LedgeH;
    LedgeSlopeH = 2.5;
    LedgeSlopeZ = LedgeZ + LedgeSlopeH;
    LedgeOD = DysonOD - 4;
    LedgeOR = LedgeOD / 2;
    LedgeID = LedgeOD - WallThickness * 2;
    LedgeIR = LedgeID / 2;

    AnchorTubeZ = h;
    AnchorTubeH = AnchorTubeZ - LedgeSlopeZ;

    AnchorBaseZ = 37;
    AnchorTailH = 8;
    AnchorWidth = 19.8;

    // Put a union to put our cylinder and our anchor together
    union() {
        // first the rocket tube
        difference() {
            // first build the outside
            union() {
                cylinder(h=BaseTubeH, r=DysonOR);
                    translate([0,0,BaseTubeZ])
                cylinder(h=LedgeH, r=LedgeOR);
                    translate([0,0,LedgeZ])
                cylinder(h=LedgeSlopeH, r=DysonOR, r1=LedgeOR);
                    translate([0,0,LedgeSlopeZ])
                cylinder(h=AnchorTubeH, r=DysonOR);
            }
            // then remove the inside from it
            translate([0,0,-0.001])
                cylinder(h=BaseTubeH-WallThickness, r=DysonIR);
            translate([0,0,BaseTubeZ - (WallThickness+0.002)])
                cylinder(h=WallThickness*2 + 0.002, r=LedgeIR, r1=DysonIR);
            translate([0,0,BaseTubeZ-0.001])
                cylinder(h=LedgeH + 0.002, r=LedgeIR);
            translate([0,0,LedgeZ-0.001])
                cylinder(h=LedgeSlopeH + 0.002, r=DysonIR, r1=LedgeIR);
            translate([0,0,LedgeSlopeZ-0.001])
                cylinder(h=AnchorTubeH+0.002, r=DysonIR);
        }

    }
}

DysonConnector(1);
