circuit EX1 :
  module EX1 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip sw : UInt<3>, led : UInt<1>}

    reg blkReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[EX1.scala 19:23]
    node _blkReg_T = bits(io.sw, 0, 0) @[EX1.scala 21:18]
    blkReg <= _blkReg_T @[EX1.scala 21:10]
    io.led <= blkReg @[EX1.scala 22:10]

