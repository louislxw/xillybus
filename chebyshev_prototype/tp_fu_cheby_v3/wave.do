onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /test_top/bus_clk
add wave -noupdate -radix unsigned /test_top/user_w_write_32_open
add wave -noupdate -radix unsigned /test_top/user_w_write_32_data
add wave -noupdate -radix unsigned /test_top/user_w_write_32_wren
add wave -noupdate -radix unsigned /test_top/user_r_read_32_open
add wave -noupdate -radix unsigned /test_top/user_r_read_32_rden
add wave -noupdate -radix unsigned /test_top/inst
add wave -noupdate -radix unsigned /test_top/src1
add wave -noupdate -radix unsigned /test_top/src2
add wave -noupdate -radix unsigned /test_top/dst
add wave -noupdate -radix unsigned /test_top/user_w_write_32_full
add wave -noupdate -radix unsigned /test_top/uut/cpu_3/dout
add wave -noupdate -radix unsigned /test_top/uut/cpu_3/dout_v
add wave -noupdate -radix unsigned /test_top/uut/cpu_1/din
add wave -noupdate -radix unsigned /test_top/uut/cpu_1/valid
add wave -noupdate -radix unsigned {/test_top/uut/cpu_1/regfile[0]}
add wave -noupdate -radix unsigned /test_top/uut/cpu_1/count
add wave -noupdate /test_top/uut/cpu_1/pc
add wave -noupdate -radix unsigned /test_top/uut/cpu_1/src1_addr
add wave -noupdate -radix unsigned /test_top/uut/cpu_1/src2_addr
add wave -noupdate -radix binary /test_top/uut/cpu_1/inst
add wave -noupdate -radix decimal /test_top/uut/cpu_1/src1
add wave -noupdate /test_top/uut/cpu_1/src2
add wave -noupdate /test_top/uut/cpu_1/dst
add wave -noupdate -radix unsigned /test_top/uut/cpu_1/dout
add wave -noupdate -radix unsigned /test_top/uut/cpu_1/dout_v
add wave -noupdate -radix unsigned /test_top/uut/cpu_2/din
add wave -noupdate -radix unsigned /test_top/uut/cpu_2/valid
add wave -noupdate -radix unsigned {/test_top/uut/cpu_2/regfile[0]}
add wave -noupdate -radix unsigned {/test_top/uut/cpu_2/regfile[1]}
add wave -noupdate /test_top/uut/cpu_2/pc
add wave -noupdate -radix unsigned /test_top/uut/cpu_2/dout
add wave -noupdate -radix unsigned /test_top/uut/cpu_2/dout_v
add wave -noupdate -radix unsigned /test_top/uut/cpu_3/din
add wave -noupdate -radix unsigned /test_top/uut/cpu_3/valid
add wave -noupdate -radix unsigned {/test_top/uut/cpu_3/regfile[0]}
add wave -noupdate -radix unsigned {/test_top/uut/cpu_3/regfile[1]}
add wave -noupdate -radix unsigned {/test_top/uut/cpu_3/regfile[2]}
add wave -noupdate /test_top/uut/cpu_3/pc
add wave -noupdate -radix unsigned /test_top/uut/cpu_4/din
add wave -noupdate -radix unsigned /test_top/uut/cpu_4/valid
add wave -noupdate -radix unsigned /test_top/uut/cpu_5/din
add wave -noupdate -radix unsigned /test_top/uut/cpu_5/valid
add wave -noupdate -radix unsigned /test_top/uut/cpu_6/din
add wave -noupdate -radix unsigned /test_top/uut/cpu_6/valid
add wave -noupdate -radix unsigned /test_top/uut/cpu_7/din
add wave -noupdate -radix unsigned /test_top/uut/cpu_7/valid
add wave -noupdate -radix unsigned /test_top/uut/output_pipe/clk
add wave -noupdate -radix unsigned /test_top/uut/output_pipe/srst
add wave -noupdate -radix unsigned /test_top/uut/output_pipe/din
add wave -noupdate -radix unsigned /test_top/uut/output_pipe/wr_en
add wave -noupdate -radix unsigned /test_top/uut/output_pipe/rd_en
add wave -noupdate -radix unsigned /test_top/cycle
add wave -noupdate -radix unsigned /test_top/uut/output_pipe/dout
add wave -noupdate -radix unsigned /test_top/uut/output_pipe/full
add wave -noupdate -radix unsigned /test_top/uut/output_pipe/empty
add wave -noupdate -radix unsigned /test_top/user_r_read_32_data
add wave -noupdate -radix unsigned /test_top/user_r_read_32_empty
add wave -noupdate -radix unsigned /glbl/GSR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {540071 ps} 0}
configure wave -namecolwidth 281
configure wave -valuecolwidth 168
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {497368 ps} {1547368 ps}
