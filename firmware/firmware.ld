ENTRY(_start)

MEMORY
{    
    flash (rwx)  : ORIGIN = 0x0, LENGTH = 64K
    itcm (rwx) : ORIGIN = 0x00400000, LENGTH = 16K
    dtcm (rw) : ORIGIN = 0x00500000, LENGTH = 16K
}

SECTIONS
{
	.text.start :
    {
        . = ALIGN(32);
        *(.text.start)
        . = ALIGN(32);
    } >flash

	_text_load = LOADADDR(.text) + (_text_begin - ADDR(.text));

    .text :
    {
		. = ALIGN(32);
		_text_begin = .;
        *(.text)
		*(.text.*)
		. = ALIGN(32);
		_text_end = .;
    } >itcm AT>flash

	_rodata_load = LOADADDR(.rodata) + (_rodata_begin - ADDR(.rodata));

    .rodata :
    {
		. = ALIGN(32);
		_rodata_begin = .;
		*(.rodata .rodata.*)
		. = ALIGN(32);
		_rodata_end = .;
    } >dtcm AT>flash

	_data_load = LOADADDR(.data) + (_data_begin - ADDR(.data));

    .data :
    {
		. = ALIGN(32);
		_data_begin = .;
		*(.data)
		. = ALIGN(32);
		_data_end = .;
    } >dtcm AT>flash

    .bss (NOLOAD) :
    {
		. = ALIGN(32);
		_bss_begin = .;
		*(.bss)
		. = ALIGN(32);
		_bss_end = .;
    } >dtcm

	_stack_top = ORIGIN(dtcm) + LENGTH(dtcm);
}
