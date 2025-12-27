difference() {
  union() {
    scale([1.2, 1, 1]) {
      cube([60, 20, 10], center=true);
      translate([0, 0, 10])
        cube([30, 20, 10], center=true);
      translate([0, 0, 5 - 0.001])
        cube([30, 20, 0.002], center=true);
    }

    // wheels
    translate([-20, -12, -5])
      rotate([90])
        cylinder(h=3, r=8, center=true);
    translate([-20, 12, -5])
      rotate([90])
        cylinder(h=3, r=8, center=true);
    translate([20, -12, -5])
      rotate([90])
        cylinder(h=3, r=8, center=true);
    translate([20, 12, -5])
      rotate([90])
        cylinder(h=3, r=8, center=true);

    // axes
    translate([-20, 0, -5])
      rotate([90])
        cylinder(h=24, r=3, center=true);
    translate([20, 0, -5])
      rotate([90])
        cylinder(h=24, r=3, center=true);
  }

  translate([45, 0, 0])
    sphere(15);

  translate([45, -10, 0])
    sphere(15);

  translate([45, 10, 0])
    sphere(15);
}
