library verilog;
use verilog.vl_types.all;
entity mult_with_3_stages_pipeline is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        A               : in     vl_logic_vector(5 downto 0);
        B               : in     vl_logic_vector(5 downto 0);
        S               : out    vl_logic_vector(11 downto 0)
    );
end mult_with_3_stages_pipeline;
