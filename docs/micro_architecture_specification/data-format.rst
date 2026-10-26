************
Data Formats
************

Memory Map
==========


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
   * - 0x00600000 - 0x0060ffff
     - Data Tightly Coupled Memory (DTCM)
   * - 0x40000000 - 0x40000fff
     - GPIO Controller
   * - 0x80000000 - 0xffffffff
     - AHB SRAM
