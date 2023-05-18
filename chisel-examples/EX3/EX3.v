module CompA(
  input  [7:0] io_a,
  input  [7:0] io_b,
  output [7:0] io_x,
  output [7:0] io_y
);
  assign io_x = io_a; // @[EX3.scala 23:14]
  assign io_y = io_b; // @[EX3.scala 24:14]
endmodule
module CompB(
  input  [7:0] io_in1,
  output [7:0] io_out
);
  assign io_out = io_in1; // @[EX3.scala 34:16]
endmodule
module EX3(
  input        clock,
  input        reset,
  input  [7:0] io_in_a,
  input  [7:0] io_in_b,
  input  [7:0] io_in_c,
  output [7:0] io_out_x,
  output [7:0] io_out_y
);
  wire [7:0] compA_io_a; // @[EX3.scala 48:21]
  wire [7:0] compA_io_b; // @[EX3.scala 48:21]
  wire [7:0] compA_io_x; // @[EX3.scala 48:21]
  wire [7:0] compA_io_y; // @[EX3.scala 48:21]
  wire [7:0] compB_io_in1; // @[EX3.scala 49:21]
  wire [7:0] compB_io_out; // @[EX3.scala 49:21]
  CompA compA ( // @[EX3.scala 48:21]
    .io_a(compA_io_a),
    .io_b(compA_io_b),
    .io_x(compA_io_x),
    .io_y(compA_io_y)
  );
  CompB compB ( // @[EX3.scala 49:21]
    .io_in1(compB_io_in1),
    .io_out(compB_io_out)
  );
  assign io_out_x = compA_io_x; // @[EX3.scala 54:12]
  assign io_out_y = compB_io_out; // @[EX3.scala 58:12]
  assign compA_io_a = io_in_a; // @[EX3.scala 52:14]
  assign compA_io_b = io_in_b; // @[EX3.scala 53:14]
  assign compB_io_in1 = compA_io_y; // @[EX3.scala 56:16]
endmodule
