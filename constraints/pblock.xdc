create_pblock pblock_rp
add_cells_to_pblock [get_pblocks pblock_rp] \
    [get_cells -quiet [list inst_rp]]
resize_pblock [get_pblocks pblock_rp] \
    -add {SLICE_X0Y50:SLICE_X15Y99}
resize_pblock [get_pblocks pblock_rp] \
    -add {DSP48_X0Y20:DSP48_X0Y39}
resize_pblock [get_pblocks pblock_rp] \
    -add {RAMB18_X0Y21:RAMB18_X0Y39}
resize_pblock [get_pblocks pblock_rp] \
    -add {RAMB36_X0Y10:RAMB36_X0Y19}
set_property HD.RECONFIGURABLE 1 [get_cells inst_rp]
set_property CONTAIN_ROUTING   1 [get_pblocks pblock_rp]
set_property SNAPPING_MODE     ON [get_pblocks pblock_rp]
set_property RESET_AFTER_RECONFIG 1 [get_pblocks pblock_rp]
