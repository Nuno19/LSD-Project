library IEEE; 
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Odd_Sort is
	port( clk        : in  std_logic; 
			odd_in0    : in  std_logic_vector(5 downto 0);
			odd_in1    : in  std_logic_vector(5 downto 0);
			odd_in2    : in  std_logic_vector(5 downto 0);
			odd_in3    : in  std_logic_vector(5 downto 0);
			odd_in4    : in  std_logic_vector(5 downto 0);
			odd_out0   : out std_logic_vector(5 downto 0);
			odd_out1   : out std_logic_vector(5 downto 0);
			odd_out2   : out std_logic_vector(5 downto 0);
			odd_out3   : out std_logic_vector(5 downto 0);
			odd_out4   : out std_logic_vector(5 downto 0));
end Odd_Sort;

architecture Behavioral of Odd_Sort is
begin
	odd_out0 <= odd_in0;
	even_comp1: entity work.Ordenar_2(combinatorial)
	port map( clk => clk,
				 x0  => odd_in1,
				 x1  => odd_in2,
				 y0  => odd_out1,
				 y1  => odd_out2);

	even_comp2: entity work.Ordenar_2(combinatorial)
	port map( clk => clk,
				 x0  => odd_in3,
				 x1  => odd_in4,
				 y0  => odd_out3,
				 y1  => odd_out4);
end Behavioral;