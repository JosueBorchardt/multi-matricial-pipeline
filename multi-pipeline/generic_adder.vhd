library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY generic_adder is
	Generic(
		N: integer := 4
	);
   Port(
      A, B  : in std_logic_vector(N-1 downto 0);
		S : out std_logic_vector(N-1 downto 0)
   );
end generic_adder;

architecture arc_generic_adder of generic_adder is

   signal Sum : std_logic_vector(N downto 0) := (others => '0');
	
begin
	
	Sum <= ('0' & A) + ('0' & B);
   S   <= Sum(N-1 downto 0); 

end arc_generic_adder;