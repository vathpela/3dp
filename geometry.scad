
function distance(xy0, xy1) = sqrt(pow((xy1[0] - xy0[0]), 2)
                                   + pow((xy1[1] - xy1[1]), 2));
function center(xy0, xy1) = [(xy1[0]+xy0[0])/2, (xy1[1]+xy0[1])/2];
