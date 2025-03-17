library verilog;
use verilog.vl_types.all;
entity mult_with_3_stages_pipeline_vlg_sample_tst is
    port(
        A               : in     vl_logic_vector(5 downto 0);
        B               : in     vl_logic_vector(5 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end mult_with_3_stages_pipeline_vlg_sample_tst;
