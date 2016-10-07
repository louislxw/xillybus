library verilog;
use verilog.vl_types.all;
entity top is
    port(
        bus_clk         : in     vl_logic;
        user_w_write_32_open: in     vl_logic;
        user_w_write_32_data: in     vl_logic_vector(31 downto 0);
        user_w_write_32_wren: in     vl_logic;
        user_w_write_32_full: out    vl_logic;
        user_r_read_32_open: in     vl_logic;
        user_r_read_32_rden: in     vl_logic;
        user_r_read_32_data: out    vl_logic_vector(31 downto 0);
        user_r_read_32_empty: out    vl_logic;
        src1            : out    vl_logic_vector(15 downto 0);
        src2            : out    vl_logic_vector(15 downto 0);
        dst             : out    vl_logic_vector(15 downto 0)
    );
end top;
