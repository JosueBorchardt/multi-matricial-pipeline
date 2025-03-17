onerror {quit -f}
vlib work
vlog -work work multi-pipeline.vo
vlog -work work multi-pipeline.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.mult_with_3_stages_pipeline_vlg_vec_tst
vcd file -direction multi-pipeline.msim.vcd
vcd add -internal mult_with_3_stages_pipeline_vlg_vec_tst/*
vcd add -internal mult_with_3_stages_pipeline_vlg_vec_tst/i1/*
add wave /*
run -all
