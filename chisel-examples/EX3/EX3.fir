circuit EX3 :
  module CompA :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<8>, flip b : UInt<8>, x : UInt<8>, y : UInt<8>}

    io.x <= io.a @[EX3.scala 23:14]
    io.y <= io.b @[EX3.scala 24:14]

  module CompB :
    input clock : Clock
    input reset : Reset
    output io : { flip in1 : UInt<8>, flip in2 : UInt<8>, out : UInt<8>}

    io.out <= io.in1 @[EX3.scala 34:16]

  module EX3 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in_a : UInt<8>, flip in_b : UInt<8>, flip in_c : UInt<8>, out_x : UInt<8>, out_y : UInt<8>}

    inst compA of CompA @[EX3.scala 48:21]
    compA.clock <= clock
    compA.reset <= reset
    inst compB of CompB @[EX3.scala 49:21]
    compB.clock <= clock
    compB.reset <= reset
    compA.io.a <= io.in_a @[EX3.scala 52:14]
    compA.io.b <= io.in_b @[EX3.scala 53:14]
    io.out_x <= compA.io.x @[EX3.scala 54:12]
    compB.io.in1 <= compA.io.y @[EX3.scala 56:16]
    compB.io.in2 <= io.in_c @[EX3.scala 57:16]
    io.out_y <= compB.io.out @[EX3.scala 58:12]

