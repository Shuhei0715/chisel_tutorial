/*
 * This code is a minimal hardware described in Chisel.
 * 
 * Copyright: 2013, Technical University of Denmark, DTU Compute
 * Author: Martin Schoeberl (martin@jopdesign.com)
 * License: Simplified BSD License
 * 
 */

import chisel3._
//import chisel3.Driver

class EX2 extends Module {
  val io = IO(new Bundle {
    val sw = Input(UInt(3.W))
    val led = Output(UInt(1.W))
  })

  val blkReg = RegInit(0.U(1.W))

  //val and = io.sw(0) & io.sw(1)
  blkReg := io.sw(0) & io.sw(1)
  io.led := blkReg

}
/**
 * An object extending App to generate the Verilog code.
 */
//object EX2_6 extends App {
//  chisel3.Driver.execute(Array[String](), () => new EX2())
//}

object EX2 extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new EX2())
}

