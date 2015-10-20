library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Ordenar_2 is
	port( clk : in  std_logic;
			x0  : in  std_logic_vector(5 downto 0);
			x1  : in  std_logic_vector(5 downto 0);
			y0  : out std_logic_vector(5 downto 0);
			y1  : out std_logic_vector(5 downto 0));
end Ordenar_2;

architecture combinatorial of Ordenar_2 is
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			if (x0 < x1) then
				y0 <= x0;
				y1 <= x1;
			else
				y0 <= x1;
				y1 <= x0;
			end if;
		end if;
	end process;
end combinatorial;
