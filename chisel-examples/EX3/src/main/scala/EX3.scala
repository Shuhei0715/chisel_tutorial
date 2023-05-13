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
//import chisel3.Driver

class EX3 extends Module {
  val io = IO(new Bundle {
    val sw = Input(UInt(10.W))
    val led = Output(UInt(2.W))
  })
  
//  class data() extends Bundle{
//  	val a = UInt(2.W)
//  	val b = UInt(2.W)
//  	val c = UInt(2.W)
//  	val d = UInt(2.W)
//  	val sel = UInt(2.W) 
//  }
  

	val sel = io.sw(1,0)
	val a = io.sw(3,2)
	val b = io.sw(5,4)
	val c = io.sw(7,6)
	val d = io.sw(9,8)
	
	//create components
	val One_4IN_MUX0 = Module(new One_4IN_MUX())
	val One_4IN_MUX1 = Module(new One_4IN_MUX())
	
	//connect MUX0
	One_4IN_MUX0.io.u := a(0)
	One_4IN_MUX0.io.v := b(0)
	One_4IN_MUX0.io.w := c(0)
	One_4IN_MUX0.io.x := d(0)
	One_4IN_MUX0.io.sel := sel
	
	One_4IN_MUX1.io.u := a(1)
	One_4IN_MUX1.io.v := b(1)
	One_4IN_MUX1.io.w := c(1)
	One_4IN_MUX1.io.x := d(1)
	One_4IN_MUX1.io.sel := sel
	
	val m = Cat(One_4IN_MUX1.io.m, One_4IN_MUX0.io.m)
	
  val blkReg = RegInit(0.U(2.W))

	blkReg := m
  io.led := blkReg

}

class One_2IN_MUX extends Module {
	val io = IO(new Bundle {
		val x = Input(UInt(1.W))
		val y = Input(UInt(1.W))
		val sel = Input(UInt(1.W)) 
		val m = Output(UInt(1.W))
	})
		
		val a = io.x & (~io.sel)
		val b = io.y & io.sel
		
		val or = a | b
		
		val io.m := or
}

class One_4IN_MUX extends Module {
	val io = IO(new Bundle {
		val u = Input(UInt(1.W))
		val v = Input(UInt(1.W))
		val w = Input(UInt(1.W))
		val x = Input(UInt(1.W))
		val sel = Input(UInt(2.W)) 
		val m = Output(UInt(1.W))
	})
	
	//create components
	val One_2IN_MUX0 = Module(new One_2IN_MUX())
	val One_2IN_MUX1 = Module(new One_2IN_MUX())
	val One_2IN_MUX2 = Module(new One_2IN_MUX())
	
	//connect MUX0
	One_2IN_MUX0.io.x := io.u
	One_2IN_MUX0.io.y := io.v
	One_2IN_MUX0.io.sel := io.sel(0)
	One_2IN_MUX2.io.x := One_2IN_MUX0.io.m
	
	//connect MUX1
	One_2IN_MUX1.io.x := io.w
	One_2IN_MUX1.io.y := io.x
	One_2IN_MUX1.io.sel := io.sel(0)
	One_2IN_MUX2.io.y := One_2IN_MUX1.io.m
	
	//connect MUX2
	One_2IN_MUX2.io.sel := io.sel(1)
	io.m := One_2IN_MUX1.io.m
}

/**
 * An object extending App to generate the Verilog code.
 */
//object EX2_6 extends App {
//  chisel3.Driver.execute(Array[String](), () => new EX2())
//}

object EX3 extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new EX3())
}

