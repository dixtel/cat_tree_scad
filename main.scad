plate_y = 7;
plate_z = 1.5;
short_plate_d = [70, plate_y, plate_z];
half_of_short_plate_d = [short_plate_d.x / 2, short_plate_d.y, short_plate_d.z];
long_plate_d = [175.1, plate_y, plate_z];
fifty_plate_d = [50, plate_y, plate_z];
max_height = 130;
base_square_width = 50;

module duplicate_on_axis(num, el_size, width, axis) {
  gap = (width - (num * el_size)) / (num - 1);
  echo(gap)
  for (dy = [0:num - 1]) {
    offset = (el_size / 2) + (dy * (el_size + gap));
    s = axis[1] == "-" ? -1 : 1;
    v = [
      axis[0] == "x" ? s * 1 * offset : 0,
      axis[0] == "y" ? s * 1 * offset : 0,
      axis[0] == "z" ? s * 1 * offset : 0,
    ];
    echo(v)
    translate(v)
      children(0);
  }
}

module base() {
  module long_plate() {
    cube(size=long_plate_d, center=true);
  }

  module short_plate() {
    cube(size=short_plate_d, center=true);
  }

  module half_of_short_plate() {
    cube(size=half_of_short_plate_d, center=true);
  }

  module _of_short_plate() {
    cube(size=half_of_short_plate_d, center=true);
  }

  duplicate_on_axis(num=5, el_size=plate_y, width=fifty_plate_d.x, "y") {
    translate([0, 0, plate_z / 2 + plate_z]) cube(size=fifty_plate_d, center=true);
  }

  translate([fifty_plate_d.x / 2, fifty_plate_d.x / 2, plate_z / 2])
    rotate([0, 0, 90])
      duplicate_on_axis(num=2, el_size=plate_y, width=fifty_plate_d.x, "y") {
        cube(size=fifty_plate_d, center=true);
      }
}

base();

module level_one_legs() {
  first_level_high = 45;

  module plate_x_facing(h) {
    color([1, 1, 0.8])
      translate([0, plate_z / 2, h / 2 + (plate_z / 2)])
        rotate([0, 90, 90])
          cube(size=[h, plate_y, plate_z], center=true);
  }

  module plate_y_facing(h) {
    color([1, 1, 0.5])
      translate([0, plate_y / 2, h / 2 + (plate_z / 2)])
        rotate([0, 90, 0])
          cube(size=[h, plate_y, plate_z], center=true);
  }

  module front_leg(middle_h) {
    translate([base_square_width / 2 - plate_y / 2, base_square_width / 2 - plate_y / 2 - plate_z, plate_z / 2])
      plate_x_facing(first_level_high);

    translate([0, plate_y + plate_z, 0])
      translate([base_square_width / 2 - plate_y / 2, base_square_width / 2 - plate_y / 2 - plate_z, plate_z / 2])
        plate_x_facing(first_level_high);

    translate([base_square_width / 2 - plate_z / 2, base_square_width / 2 - plate_y / 2, 3 / 2 * plate_z])
      plate_y_facing(middle_h);
  }

  front_leg(90);

  mirror([1, 0, 0]) front_leg(120);
}

level_one_legs();

module final_height_helper() {
  color("blue", 0.4) translate([-5, -5, 0]) cube([10, 1, max_height]);
}

*final_height_helper();

module level_one_base() {
  carrier_width = 30;

  module carrier() {
    color([0.4, 0.6, 0.7]) cube([plate_y, carrier_width, plate_z]);
  }

  module carrier_edge() {
    color([0.4, 0.6, 0.7]) difference() {
        cube([plate_y, carrier_width, plate_z]);
        translate([plate_y - plate_z, carrier_width - plate_y - plate_z, 0])
          cube([plate_z, plate_y, plate_z]);
      }
  }

  translate([(base_square_width / 2) - plate_y, 0, 0]) carrier_edge();
  mirror([1, 0, 0]) translate([(base_square_width / 2) - plate_y, 0, 0]) carrier_edge();

  gap = 3;
  translate([(base_square_width / 2) - 3 * plate_y / 2, 0, 0])
    duplicate_on_axis(num=4, el_size=plate_y, width=36 - gap, axis="x-") {
      translate([-(gap / 2), 0, 0]) carrier();
    }
}

translate([0, 0, 46.5]) level_one_base();

module level_two_legs() {
  module leg() {
    translate([(base_square_width / 2) - 8.5 - plate_y - plate_y - 1.66666, 0, plate_z * 2]) cube([plate_y, plate_z, 90]);
  }

  module shorter_leg() {
    translate([(base_square_width / 2) - 8.5 - plate_y, 0, plate_z * 2]) cube([plate_y, plate_z, 45]);
  }

  leg();
  mirror([1, 0, 0]) shorter_leg();
}

color("purple") level_two_legs();

module level_two_base() {
  module grid() {
   color("green") duplicate_on_axis(num=4, el_size=plate_y, width=30, axis="x") {
      cube(size=[plate_y, 33, plate_z]);
    }

    color("#1f1") translate([plate_y/2,-plate_y/2, -plate_z]) duplicate_on_axis(num=2, el_size=plate_y, width=33, axis="y") {
      cube(size=[30, plate_y, plate_z]);
    }
  }

   grid();
}

translate([-5, 32, 90 + plate_z * 2]) rotate([0, 0, -90]) level_two_base();

module level_there_base() {
  module grid() {
   color("silver") duplicate_on_axis(num=4, el_size=plate_y, width=plate_y*4 + 4, axis="x") {
      cube(size=[plate_y, 33, plate_z]);
    }

    color("#823") translate([plate_y/2,-plate_y/2, -plate_z]) duplicate_on_axis(num=2, el_size=plate_y, width=33, axis="y") {
      cube(size=[32, plate_y, plate_z]);
    }
  }

   grid();
}

translate([-base_square_width + plate_y, 10, 120 + plate_z * 2]) rotate([0, 0, -10]) level_there_base();
