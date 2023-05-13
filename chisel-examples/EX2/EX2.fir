circuit EX2 :
  module EX2 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip sw : UInt<3>, led : UInt<1>}

    reg blkReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[EX1.scala 19:23]
    node _blkReg_T = bits(io.sw, 0, 0) @[EX1.scala 22:18]
    node _blkReg_T_1 = bits(io.sw, 1, 1) @[EX1.scala 22:29]
    node _blkReg_T_2 = and(_blkReg_T, _blkReg_T_1) @[EX1.scala 22:22]
    blkReg <= _blkReg_T_2 @[EX1.scala 22:10]
    io.led <= blkReg @[EX1.scala 23:10]

