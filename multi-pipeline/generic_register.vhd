library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity generic_register is
	generic (
		N : integer := 6  -- Define o tamanho do registrador
	);

   Port (
        clk   : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        d     : in  STD_LOGIC_VECTOR (N-1 downto 0);
        q     : out STD_LOGIC_VECTOR (N-1 downto 0)
   );
end generic_register;

architecture Behavioral of generic_register is
   signal reg : STD_LOGIC_VECTOR (N-1 downto 0);
begin
   process(clk, reset)
   begin
      if reset = '1' then
         reg <= (others => '0');  -- Reset assíncrono
      elsif rising_edge(clk) then
         reg <= d;  -- Captura o valor na borda de subida do clock
      end if;
   end process;
    
   q <= reg;
end Behavioral;