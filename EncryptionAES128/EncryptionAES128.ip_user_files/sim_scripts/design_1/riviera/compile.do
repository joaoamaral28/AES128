vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/microblaze_v10_0_5
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/lib_pkg_v1_0_2
vlib riviera/lib_srl_fifo_v1_0_2
vlib riviera/lib_cdc_v1_0_2
vlib riviera/axi_uartlite_v2_0_19
vlib riviera/mdm_v3_2_12
vlib riviera/proc_sys_reset_v5_0_12
vlib riviera/generic_baseblocks_v2_1_0
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_register_slice_v2_1_15
vlib riviera/fifo_generator_v13_2_1
vlib riviera/axi_data_fifo_v2_1_14
vlib riviera/axi_crossbar_v2_1_16
vlib riviera/lmb_v10_v3_0_9
vlib riviera/lmb_bram_if_cntlr_v4_0_14
vlib riviera/blk_mem_gen_v8_4_1

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap microblaze_v10_0_5 riviera/microblaze_v10_0_5
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap lib_pkg_v1_0_2 riviera/lib_pkg_v1_0_2
vmap lib_srl_fifo_v1_0_2 riviera/lib_srl_fifo_v1_0_2
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap axi_uartlite_v2_0_19 riviera/axi_uartlite_v2_0_19
vmap mdm_v3_2_12 riviera/mdm_v3_2_12
vmap proc_sys_reset_v5_0_12 riviera/proc_sys_reset_v5_0_12
vmap generic_baseblocks_v2_1_0 riviera/generic_baseblocks_v2_1_0
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_15 riviera/axi_register_slice_v2_1_15
vmap fifo_generator_v13_2_1 riviera/fifo_generator_v13_2_1
vmap axi_data_fifo_v2_1_14 riviera/axi_data_fifo_v2_1_14
vmap axi_crossbar_v2_1_16 riviera/axi_crossbar_v2_1_16
vmap lmb_v10_v3_0_9 riviera/lmb_v10_v3_0_9
vmap lmb_bram_if_cntlr_v4_0_14 riviera/lmb_bram_if_cntlr_v4_0_14
vmap blk_mem_gen_v8_4_1 riviera/blk_mem_gen_v8_4_1

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work microblaze_v10_0_5 -93 \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4f30/hdl/microblaze_v10_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_microblaze_0_0/sim/design_1_microblaze_0_0.vhd" \

vcom -work axi_lite_ipif_v3_0_4 -93 \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/cced/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work lib_pkg_v1_0_2 -93 \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -93 \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work axi_uartlite_v2_0_19 -93 \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/c778/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_axi_uartlite_0_0/sim/design_1_axi_uartlite_0_0.vhd" \

vcom -work mdm_v3_2_12 -93 \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/8608/hdl/mdm_v3_2_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_mdm_1_0/sim/design_1_mdm_1_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ip/design_1_clk_wiz_1_0/design_1_clk_wiz_1_0_clk_wiz.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_1_0/design_1_clk_wiz_1_0.v" \

vcom -work proc_sys_reset_v5_0_12 -93 \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_rst_clk_wiz_1_100M_0/sim/design_1_rst_clk_wiz_1_100M_0.vhd" \
"../../../bd/design_1/ipshared/0626/hdl/DataTypes.vhd" \
"../../../bd/design_1/ipshared/0626/hdl/vectorToMatrix.vhd" \
"../../../bd/design_1/ipshared/0626/hdl/KeyExpansion.vhd" \
"../../../bd/design_1/ipshared/0626/hdl/AddRoundKey.vhd" \
"../../../bd/design_1/ipshared/0626/hdl/SubBytes.vhd" \
"../../../bd/design_1/ipshared/0626/hdl/RowShifter.vhd" \
"../../../bd/design_1/ipshared/0626/hdl/MixColumns.vhd" \
"../../../bd/design_1/ipshared/0626/hdl/MatrixToVector.vhd" \
"../../../bd/design_1/ipshared/0626/hdl/AES.vhd" \
"../../../bd/design_1/ipshared/0626/hdl/AES128_IP_v1_0_S00_AXI.vhd" \
"../../../bd/design_1/ipshared/0626/hdl/AES128_IP_v1_0.vhd" \
"../../../bd/design_1/ip/design_1_AES128_IP_0_0/sim/design_1_AES128_IP_0_0.vhd" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_15  -v2k5 "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/3ed1/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_1  -v2k5 "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/5c35/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_1 -93 \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/5c35/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_1  -v2k5 "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/5c35/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_14  -v2k5 "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/9909/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_16  -v2k5 "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/c631/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ip/design_1_xbar_0/sim/design_1_xbar_0.v" \

vcom -work lmb_v10_v3_0_9 -93 \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/78eb/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_dlmb_v10_0/sim/design_1_dlmb_v10_0.vhd" \
"../../../bd/design_1/ip/design_1_ilmb_v10_0/sim/design_1_ilmb_v10_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_14 -93 \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/226d/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_dlmb_bram_if_cntlr_0/sim/design_1_dlmb_bram_if_cntlr_0.vhd" \
"../../../bd/design_1/ip/design_1_ilmb_bram_if_cntlr_0/sim/design_1_ilmb_bram_if_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_4_1  -v2k5 "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../EncryptionAES128.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ip/design_1_lmb_bram_0/sim/design_1_lmb_bram_0.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/sim/design_1.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

