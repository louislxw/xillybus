library verilog;
use verilog.vl_types.all;
entity top_cpu_7 is
    generic(
        ROM_WIDTH       : integer := 24;
        RAM_WIDTH       : integer := 16;
        RAM_ADDR_BITS   : integer := 6
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        din             : in     vl_logic_vector(15 downto 0);
        valid           : in     vl_logic;
        src1            : out    vl_logic_vector;
        src2            : out    vl_logic_vector;
        dst             : out    vl_logic_vector;
        dout            : out    vl_logic_vector(15 downto 0);
        dout_v          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ROM_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of RAM_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of RAM_ADDR_BITS : constant is 1;
end top_cpu_7;
