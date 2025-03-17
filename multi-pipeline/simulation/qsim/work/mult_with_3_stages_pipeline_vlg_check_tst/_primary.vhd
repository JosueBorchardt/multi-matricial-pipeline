library verilog;
use verilog.vl_types.all;
entity mult_with_3_stages_pipeline_vlg_check_tst is
    port(
        S               : in     vl_logic_vector(11 downto 0);
        sampler_rx      : in     vl_logic
    );
end mult_with_3_stages_pipeline_vlg_check_tst;
