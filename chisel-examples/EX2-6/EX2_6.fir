circuit EX2_6 :
  module EX2_6 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip sw : UInt<3>, led : UInt<1>}

    reg blkReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[2-6.scala 19:23]
    blkReg <= io.sw @[2-6.scala 21:10]
    io.led <= blkReg @[2-6.scala 22:10]

