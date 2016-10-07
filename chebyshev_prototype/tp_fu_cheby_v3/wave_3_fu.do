onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /test_top/bus_clk
add wave -noupdate -radix unsigned /test_top/user_w_write_32_open
add wave -noupdate -radix unsigned /test_top/user_w_write_32_data
add wave -noupdate -radix unsigned /test_top/user_w_write_32_wren
add wave -noupdate -radix unsigned /test_top/user_r_read_32_open
add wave -noupdate -radix unsigned /test_top/user_r_read_32_rden
add wave -noupdate -radix unsigned /test_top/src1
add wave -noupdate -radix unsigned /test_top/src2
add wave -noupdate -radix unsigned /test_top/dst
add wave -noupdate -radix unsigned /test_top/user_w_write_32_full
add wave -noupdate -radix unsigned /test_top/user_r_read_32_data
add wave -noupdate -radix unsigned /test_top/user_r_read_32_empty
add wave -noupdate -radix unsigned /test_top/cycle
add wave -noupdate -radix unsigned /glbl/GSR
add wave -noupdate -expand -group input_pipe -radix unsigned /test_top/uut/input_pipe/clk
add wave -noupdate -expand -group input_pipe -radix unsigned /test_top/uut/input_pipe/srst
add wave -noupdate -expand -group input_pipe -radix unsigned /test_top/uut/input_pipe/din
add wave -noupdate -expand -group input_pipe -radix unsigned /test_top/uut/input_pipe/wr_en
add wave -noupdate -expand -group input_pipe -radix unsigned /test_top/uut/input_pipe/rd_en
add wave -noupdate -expand -group input_pipe -radix unsigned /test_top/uut/input_pipe/dout
add wave -noupdate -expand -group input_pipe -radix unsigned /test_top/uut/input_pipe/full
add wave -noupdate -expand -group input_pipe -radix unsigned /test_top/uut/input_pipe/empty
add wave -noupdate -expand -group mycpu1 -radix unsigned /test_top/uut/mycpu1/dout
add wave -noupdate -expand -group mycpu1 -radix unsigned /test_top/uut/mycpu1/dout_v
add wave -noupdate -expand -group mycpu1 -radix unsigned /test_top/uut/mycpu1/inst
add wave -noupdate -expand -group mycpu1 -radix unsigned /test_top/uut/mycpu1/pc
add wave -noupdate -expand -group inter_pipe_1 -radix unsigned /test_top/uut/inter_pipe_1/din
add wave -noupdate -expand -group inter_pipe_1 -radix unsigned /test_top/uut/inter_pipe_1/wr_en
add wave -noupdate -expand -group inter_pipe_1 -radix unsigned /test_top/uut/inter_pipe_1/rd_en
add wave -noupdate -expand -group inter_pipe_1 -radix unsigned /test_top/uut/inter_pipe_1/dout
add wave -noupdate -expand -group inter_pipe_1 -radix unsigned /test_top/uut/inter_pipe_1/full
add wave -noupdate -expand -group inter_pipe_1 -radix unsigned /test_top/uut/inter_pipe_1/empty
add wave -noupdate -expand -group mycpu2 -radix unsigned /test_top/uut/mycpu2/dout
add wave -noupdate -expand -group mycpu2 -radix unsigned /test_top/uut/mycpu2/dout_v
add wave -noupdate -expand -group mycpu2 -radix unsigned /test_top/uut/mycpu2/inst
add wave -noupdate -expand -group mycpu2 -radix unsigned /test_top/uut/mycpu2/pc
add wave -noupdate -expand -group inter_pipe_2 -radix unsigned /test_top/uut/inter_pipe_2/din
add wave -noupdate -expand -group inter_pipe_2 -radix unsigned /test_top/uut/inter_pipe_2/wr_en
add wave -noupdate -expand -group inter_pipe_2 -radix unsigned /test_top/uut/inter_pipe_2/rd_en
add wave -noupdate -expand -group inter_pipe_2 -radix unsigned /test_top/uut/inter_pipe_2/dout
add wave -noupdate -expand -group inter_pipe_2 -radix unsigned /test_top/uut/inter_pipe_2/full
add wave -noupdate -expand -group inter_pipe_2 -radix unsigned /test_top/uut/inter_pipe_2/empty
add wave -noupdate -expand -group mycpu3 -radix unsigned /test_top/uut/mycpu3/dout
add wave -noupdate -expand -group mycpu3 -radix unsigned /test_top/uut/mycpu3/dout_v
add wave -noupdate -expand -group mycpu3 -radix unsigned /test_top/uut/mycpu3/inst
add wave -noupdate -expand -group mycpu3 -radix unsigned /test_top/uut/mycpu3/pc
add wave -noupdate -expand -group output_pipe -radix unsigned /test_top/uut/output_pipe/din
add wave -noupdate -expand -group output_pipe -radix unsigned /test_top/uut/output_pipe/wr_en
add wave -noupdate -expand -group output_pipe -radix unsigned /test_top/uut/output_pipe/rd_en
add wave -noupdate -expand -group output_pipe -radix unsigned /test_top/uut/output_pipe/dout
add wave -noupdate -expand -group output_pipe -radix unsigned /test_top/uut/output_pipe/full
add wave -noupdate -expand -group output_pipe -radix unsigned /test_top/uut/output_pipe/empty
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {530100 ps} 0}
configure wave -namecolwidth 261
configure wave -valuecolwidth 100
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
WaveRestoreZoom {319466 ps} {775846 ps}
