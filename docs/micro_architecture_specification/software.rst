******************
Software Interface
******************

Address Space
=============

.. list-table:: Memory Map
   :widths: 25 75
   :class: longtable
   :header-rows: 1

   * - Address Range
     - Description
   * - 0x00000000 - 0x0003ffff
     - Flash
   * - 0x00400000 - 0x0040ffff
     - Instruction Tightly Coupled Memory (ITCM)
   * - 0x00500000 - 0x0050ffff
     - Data Tightly Coupled Memory (DTCM)
   * - 0x00600000 - 0x00603fff
     - Interrupt Controller
   * - 0x00700000 - 0x00703fff
     - AHB Master Controller
   * - 0x40000000 - 0x40000fff
     - GPIO Controller
   * - 0x80000000 - 0xffffffff
     - AHB SRAM

Control and Status Register
===========================

Interrupts
==========

DMA
===

Virtualization
==============
