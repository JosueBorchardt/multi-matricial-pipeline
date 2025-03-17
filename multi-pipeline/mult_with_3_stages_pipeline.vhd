LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mult_with_3_stages_pipeline is
	port(
		clk, reset: in std_logic;
		A, B: in std_logic_vector(5 downto 0);
		S: out std_logic_vector(11 downto 0)
	);
end mult_with_3_stages_pipeline;

ARCHITECTURE arc_mult_with_3_stages_pipeline of mult_with_3_stages_pipeline is
	component generic_register 
		generic (
			N : integer := 6
		);
		Port (
			clk   : in  STD_LOGIC;
			reset   : in  STD_LOGIC;
			d     : in  STD_LOGIC_VECTOR (N-1 downto 0);
			q     : out STD_LOGIC_VECTOR (N-1 downto 0)
		);
	end component;

	component generic_adder
		Generic(
			N: integer := 4
		);
		Port(
			A, B  : in std_logic_vector(N-1 downto 0);
			S : out std_logic_vector(N-1 downto 0)
		);
	end component;

	type matriz_6x6 is array (0 to 5) of std_logic_vector(11 downto 0);
	signal PP: matriz_6x6 := (others => (others => '0'));
	
	type matriz_5x6 is array (0 to 4) of std_logic_vector(11 downto 0);
	signal sum: matriz_5x6 := (others => (others => '0'));

	signal carry: std_logic_vector(0 to 4);
	
	signal signal_a, signal_b: std_logic_vector(5 downto 0);
	signal signal_s: std_logic_vector(11 downto 0);
	
	signal stage2_pp3, stage2_pp4, stage2_pp5, stage2_sum1: std_logic_vector(7 downto 0);
	signal stage2_S: std_logic_vector(2 downto 0);
	
	signal stage3_pp4, stage3_pp5, stage3_sum2: std_logic_vector(7 downto 0);
	signal stage3_S: std_logic_vector(3 downto 0);
	
begin
	
	register_a: generic_register generic map (N => 6) port map (clk, reset, A, signal_a);
	register_b: generic_register generic map (N => 6) port map (clk, reset, B, signal_b);
	
	G1: for i in 0 to 5 generate
      G2: for j in 0 to 5 generate
         PP(i)(j + i) <= signal_b(i) and signal_a(j);
      end generate;
   end generate;

	sum1: generic_adder generic map (N => 8) port map (PP(1)(7 downto 0), PP(0)(7 downto 0), sum(0)(7 downto 0));
	sum2: generic_adder generic map (N => 8) port map (PP(2)(8 downto 1), sum(0)(8 downto 1), sum(1)(8 downto 1));

	------------------------------------------------------------------------------------------------------------------------
	pipeline_barrier_1_pp3: generic_register generic map (N => 8) port map (clk, reset, PP(3)(9 downto 2), stage2_pp3);
	pipeline_barrier_1_pp4: generic_register generic map (N => 8) port map (clk, reset, PP(4)(10 downto 3), stage2_pp4);
	pipeline_barrier_1_pp5: generic_register generic map (N => 8) port map (clk, reset, PP(5)(11 downto 4), stage2_pp5);
	pipeline_barrier_1_sum1: generic_register generic map (N => 8) port map (clk, reset, sum(1)(9 downto 2), stage2_sum1);
	pipeline_barrier_1_S: generic_register generic map (N => 3) port map (clk, reset, sum(1)(2) & sum(0)(1) & PP(0)(0), stage2_S);
	------------------------------------------------------------------------------------------------------------------------

	sum3: generic_adder generic map (N => 8) port map (stage2_pp3, stage2_sum1, sum(2)(9 downto 2));

	------------------------------------------------------------------------------------------------------------------------
	pipeline_barrier_2_pp4: generic_register generic map (N => 8) port map (clk, reset, stage2_pp4, stage3_pp4);
	pipeline_barrier_2_pp5: generic_register generic map (N => 8) port map (clk, reset, stage2_pp5, stage3_pp5);
	pipeline_barrier_2_sum2: generic_register generic map (N => 8) port map (clk, reset, sum(2)(10 downto 3), stage3_sum2);
	pipeline_barrier_2_S: generic_register generic map (N => 4) port map (clk, reset, sum(2)(3) & stage2_S, stage3_S);
	------------------------------------------------------------------------------------------------------------------------

	sum4: generic_adder generic map (N => 8) port map (stage3_pp4, stage3_sum2, sum(3)(10 downto 3));
	sum5: generic_adder generic map (N => 8) port map (stage3_pp5, sum(3)(11 downto 4), sum(4)(11 downto 4));

	register_s: generic_register generic map (N => 12) port map (clk, reset, sum(4)(11 downto 5) & sum(3)(4) & stage3_S, S);

end arc_mult_with_3_stages_pipeline;	