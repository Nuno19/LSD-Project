library IEEE; 
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Sort_Done is
	port( sort_in0    : in  std_logic_vector(5 downto 0);
			sort_in1    : in  std_logic_vector(5 downto 0);
			sort_in2    : in  std_logic_vector(5 downto 0);
			sort_in3    : in  std_logic_vector(5 downto 0);
			sort_in4    : in  std_logic_vector(5 downto 0);
			is_sorted   : out std_logic);
end Sort_Done;

architecture Behavioral of Sort_Done is
begin
	process(sort_in0, sort_in1, sort_in2, sort_in3, sort_in4)
	begin
		if(sort_in0 < sort_in1 and sort_in1 < sort_in2 and sort_in2 < sort_in3 and sort_in3 < sort_in4) then
			is_sorted <= '1';
		else
			is_sorted <= '0';
		end if;
	end process;
end Behavioral;