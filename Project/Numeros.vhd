library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Numeros is
	port( clk    : in  std_logic;
			reset  : in  std_logic;
			input  : in  std_logic_vector(5 downto 0);
			loaded : out std_logic;
         dataOut: out std_logic_vector(29 downto 0));
end Numeros;

architecture Behavioral of Numeros is
	signal s_count : unsigned(2 downto 0);
	signal s_dataOut : std_logic_vector(29 downto 0);
begin
	process( clk )
	begin
		if( rising_edge(clk) ) then
			if (reset = '1') then
				s_count <= "000";
				loaded <= '0';
			elsif ( s_count = "101" ) then
				s_count <= s_count;
				loaded <= '1';
			elsif (input = "000000" or input >= "110011") then
				s_count <= s_count;
			else
				s_dataOut <= input & s_dataOut(29 downto 6);
				s_count <= s_count + 1;
			end if;
		end if;
	end process;
	dataOut <= s_dataOut;
end Behavioral;