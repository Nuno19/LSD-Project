library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Debounce is
	port(clk1  : in  std_logic;
		  dirty : in  std_logic;
		  clean : out std_logic);
end Debounce;

architecture Structural of Debounce is
	signal s1 : std_logic_vector(3 downto 0);
begin
	ffd1 : entity work.FlipFlopD(Behavioral)
	port map(clk 	=> clk1,
				d 		=> '1',
				set 	=> '0',
				reset => dirty,
				q 		=> s1(0));
	ffd2 : entity work.FlipFlopD(Behavioral)
	port map(clk	=> clk1,
				d 		=> s1(0),
				set 	=> '0',
				reset => dirty,
				q 		=> s1(1));
	ffd3 : entity work.FlipFlopD(Behavioral)
	port map(clk	=> clk1,
				d 		=> s1(1),
				set 	=> '0',
				reset => dirty,
				q 		=> s1(2));
	ffd4 : entity work.FlipFlopD(Behavioral)
	port map(clk	=> clk1,
				d 		=> s1(2),
				set 	=> '0',
				reset => dirty,
				q 		=> s1(3));
	clean <= s1(3) xor s1(2);
end Structural;
