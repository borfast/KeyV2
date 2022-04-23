// the point of this file is to be a sort of DSL for constructing keycaps.
// when you create a method chain you are just changing the parameters
// key.scad uses, it doesn't generate anything itself until the end. This
// lets it remain easy to use key.scad like before (except without key profiles)
// without having to rely on this file. Unfortunately that means setting tons of
// special variables, but that's a limitation of SCAD we have to work around

include <./includes.scad>


$top_tilt = 0;
$top_skew = 0;
$side_tilt = 0;
$side_skew = 0;


module outer_hull(symbol) {
    legend(symbol, size=5) {
        $stem_type = "cherry";
        $support_type = "flat";
        $stem_support_type = "disable";

        $bottom_key_width = 18.16;
        $bottom_key_height = 18.16;
        $width_difference = 2;
        $height_difference = 2;

        $dish_type = "disable";
        // something weird is going on with this and legends - can't put it below 1.2 or they won't show
        $dish_depth = 1.2;
        $dish_skew_x = 0;
        $dish_skew_y = 0;
        $minkowski_radius = 1.75;
        $key_bump_depth = 0.6;
        $key_bump_edge = 2;
        //also,
        $rounded_key = true;
        $total_depth = 7;
        
        // 2.2 = Make the legends go all the way through the key top to poke a hole.
        // Perhaps an alternative would be to make this 2.1, so that the
        // opaque layer in the symbol is so thin, the light would still
        // shine through? That way I could print a key in a single piece.
        $inset_legend_depth = 2.2;

        difference() {
            key(true);
            inner_shape();
        }
    }
}


module inner_support() {
    $stem_type = "cherry";
    $support_type = "flat";
    $stem_support_type = "disable";

    $bottom_key_width = 14.10;
    $bottom_key_height = 14.10;
    $width_difference = 0;
    $height_difference = 0;

    $dish_type = "disable";
    // something weird is going on with this and legends - can't put it below 1.2 or they won't show
    //$dish_depth = 1.2;
    $dish_skew_x = 0;
    $dish_skew_y = 0;
    //$minkowski_radius = 1.75;
    //$key_bump_depth = 0.6;
    //$key_bump_edge = 2;
    //also,
    $rounded_key = false;
    $total_depth = 1;
    
    
    // 2.2 = Make the legends go all the way through the key top to poke a hole.
    // Perhaps an alternative would be to make this 2.1
    // and print everything in a single piece?
    //$inset_legend_depth = 2.2;

    translate([0, 0, 4]) difference() {
        inset(-4) key(true);
        //inner_shape();
    }
}


module hulls(symbols, max_rows=5) {
    column = 0;
    for (row = [column:len(symbols)-1]) {
        col = floor(row / max_rows);
        r = row - (col * max_rows);
        translate_u(col, -r) {
            outer_hull(symbols[row]);
        }
    }
}


module supports(count, max_rows=5) {
    for (row = [0:count-1]) {
        col = floor(row / max_rows);
        r = row - (col * max_rows);
        translate_u(col,-r) {
            inner_support();
        }
    }
}


letters = [
    "A", "B", "C", "D", "E", "F", "G", "H", "I",
    "J", "K", "L", "M", "N", "O", "P", "Q", "R",
    "S", "T", "U", "V", "W", "X", "Y", "Z",
    "F9", "CTL"
];
$font = "Saira Stencil One";

//mirror([0, 0, 1]) {
    
    // Orange letters
    //color([1.0,0.7,0.25,1]) hulls(letters, 6);

    // Blue letters
    color([0,0.4,0.8,1]) hulls(letters, 6);

    // Purple letters
    //color([0.576,0.439,0.901,1]) hulls(letters, 6);

    // Yellow letters
    //color([0.949,0.843,0.054,1]) hulls(letters, 6);

    // Red Escape
    //color([1.0,0,0,1]) hulls(["ESC"], 1);

    // Green
    //color([0,0.8,0.2,1]) hulls(letters, 6);

    // Semi-transparent supports
    //color([0.8,0.8,0.8,0.3]) supports(90, 9);
//}