library verilog;
use verilog.vl_types.all;
entity alu_core is
    port(
        a_i             : in     vl_logic_vector(29 downto 0);
        alumode_i       : in     vl_logic_vector(3 downto 0);
        b_i             : in     vl_logic_vector(17 downto 0);
        c_i             : in     vl_logic_vector(47 downto 0);
        cea2_i          : in     vl_logic;
        ceb2_i          : in     vl_logic;
        clk             : in     vl_logic;
        inmode_i        : in     vl_logic_vector(4 downto 0);
        opmode_i        : in     vl_logic_vector(6 downto 0);
        rst             : in     vl_logic;
        usemult_i       : in     vl_logic;
        p_o             : out    vl_logic_vector(47 downto 0)
    );
end alu_core;
