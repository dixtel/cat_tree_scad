plate_y = 7;
plate_z = 1.5;
short_plate_d = [70, plate_y, plate_z];
half_of_short_plate_d = [short_plate_d.x / 2, short_plate_d.y, short_plate_d.z];
long_plate_d = [175.1, plate_y, plate_z];
fifty_plate_d = [50, plate_y, plate_z];

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

  module duplicate_on_y(num, el_size, width) {
    gap = (width - (num * el_size)) / (num - 1);
    for (dy = [0:num - 1]) {
      translate([0, (el_size / 2) + (dy * (el_size + gap)), 0])
        children(0);
    }
  }

  duplicate_on_y(num=5, el_size=plate_y, width=fifty_plate_d.x) {
    cube(size=fifty_plate_d, center=true);
  }

  translate([fifty_plate_d.x / 2, fifty_plate_d.x / 2, -plate_z])
    rotate([0, 0, 90])
      duplicate_on_y(num=2, el_size=plate_y, width=fifty_plate_d.x) {
        cube(size=fifty_plate_d, center=true);
      }
}

base();

module level_one() {
  height = 30;

  module plate_x_facing() {
    color([1, 1, 0.8])
      translate([0, plate_z / 2, height / 2 + (plate_z / 2)])
        rotate([0, 90, 90])
          cube(size=[height, plate_y, plate_z], center=true);
  }

  module plate_y_facing() {
    color([1, 1, 0.5])
      translate([0, plate_y / 2, height / 2 + (plate_z / 2)])
        rotate([0, 90, 0])
          cube(size=[height, plate_y, plate_z], center=true);
  }

  translate([fifty_plate_d.x / 2 - plate_y / 2, fifty_plate_d.x / 2 - plate_y / 2 - plate_z, -plate_z])
    plate_x_facing();

  translate([0, plate_y + plate_z, 0])
    translate([fifty_plate_d.x / 2 - plate_y / 2, fifty_plate_d.x / 2 - plate_y / 2 - plate_z, -plate_z])
      plate_x_facing();

  translate([fifty_plate_d.x / 2 - plate_z / 2, fifty_plate_d.x / 2 - plate_y / 2, 0])

    plate_y_facing();
}

level_one();
