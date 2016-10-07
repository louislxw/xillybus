library verilog;
use verilog.vl_types.all;
entity fifo_32x512 is
    port(
        clk             : in     vl_logic;
        srst            : in     vl_logic;
        din             : in     vl_logic_vector(31 downto 0);
        wr_en           : in     vl_logic;
        rd_en           : in     vl_logic;
        dout            : out    vl_logic_vector(31 downto 0);
        full            : out    vl_logic;
        empty           : out    vl_logic
    );
end fifo_32x512;
