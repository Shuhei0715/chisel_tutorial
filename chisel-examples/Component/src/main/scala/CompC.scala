/*
 * This code is a minimal hardware described in Chisel.
 * 
 * Copyright: 2013, Technical University of Denmark, DTU Compute
 * Author: Martin Schoeberl (martin@jopdesign.com)
 * License: Simplified BSD License
 * 
 */

import chisel3._
import chisel3.util._
//import chisel3.iotesters._
//import chisel3.Driver

class CompA extends Module { 
  val io = IO(new Bundle { 
    val a = Input(UInt(8.W)) 
    val b = Input(UInt(8.W)) 
    val x = Output(UInt(8.W)) 
    val y = Output(UInt(8.W))
  })

	io.x := io.a
	io.y := io.b
}

class CompB extends Module { 
  val io = IO(new Bundle { 
    val in1 = Input(UInt(8.W)) 
    val in2 = Input(UInt(8.W)) 
    val out = Output(UInt(8.W)) 
  })

	io.out := io.in1
  
}

class CompC extends Module { 
  val io = IO(new Bundle { 
    val in_a = Input(UInt(8.W)) 
    val in_b = Input(UInt(8.W)) 
    val in_c = Input(UInt(8.W)) 
    val out_x = Output(UInt(8.W)) 
    val out_y = Output(UInt(8.W)) 
  })

  // create components A and B 
  val compA = Module(new CompA()) 
  val compB = Module(new CompB())

  // connect A 
  compA.io.a := io.in_a 
  compA.io.b := io.in_b 
  io.out_x := compA.io.x 
  // connect B 
  compB.io.in1 := compA.io.y 
  compB.io.in2 := io.in_c 
  io.out_y := compB.io.out
}

	
/**
 * An object extending App to generate the Verilog code.
 */
//object EX3 extends App {
//  chisel3.Driver.execute(Array[String](), () => new EX3())
//}

object CompC extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new CompC())
}

