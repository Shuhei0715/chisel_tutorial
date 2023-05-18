module CompA(
  input  [7:0] io_a,
  input  [7:0] io_b,
  output [7:0] io_x,
  output [7:0] io_y
);
  assign io_x = io_a; // @[CompC.scala 23:14]
  assign io_y = io_b; // @[CompC.scala 24:14]
endmodule
module CompB(
  input  [7:0] io_in1,
  output [7:0] io_out
);
  assign io_out = io_in1; // @[CompC.scala 34:16]
endmodule
module CompC(
  input        clock,
  input        reset,
  input  [7:0] io_in_a,
  input  [7:0] io_in_b,
  input  [7:0] io_in_c,
  output [7:0] io_out_x,
  output [7:0] io_out_y
);
  wire [7:0] compA_io_a; // @[CompC.scala 48:21]
  wire [7:0] compA_io_b; // @[CompC.scala 48:21]
  wire [7:0] compA_io_x; // @[CompC.scala 48:21]
  wire [7:0] compA_io_y; // @[CompC.scala 48:21]
  wire [7:0] compB_io_in1; // @[CompC.scala 49:21]
  wire [7:0] compB_io_out; // @[CompC.scala 49:21]
  CompA compA ( // @[CompC.scala 48:21]
    .io_a(compA_io_a),
    .io_b(compA_io_b),
    .io_x(compA_io_x),
    .io_y(compA_io_y)
  );
  CompB compB ( // @[CompC.scala 49:21]
    .io_in1(compB_io_in1),
    .io_out(compB_io_out)
  );
  assign io_out_x = compA_io_x; // @[CompC.scala 54:12]
  assign io_out_y = compB_io_out; // @[CompC.scala 58:12]
  assign compA_io_a = io_in_a; // @[CompC.scala 52:14]
  assign compA_io_b = io_in_b; // @[CompC.scala 53:14]
  assign compB_io_in1 = compA_io_y; // @[CompC.scala 56:16]
endmodule
