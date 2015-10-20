library IEEE; 
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Even_Sort is
	port( clk         : in  std_logic; 
			even_in0    : in  std_logic_vector(5 downto 0);
			even_in1    : in  std_logic_vector(5 downto 0);
			even_in2    : in  std_logic_vector(5 downto 0);
			even_in3    : in  std_logic_vector(5 downto 0);
			even_in4    : in  std_logic_vector(5 downto 0);
			even_out0   : out std_logic_vector(5 downto 0);
			even_out1   : out std_logic_vector(5 downto 0);
			even_out2   : out std_logic_vector(5 downto 0);
			even_out3   : out std_logic_vector(5 downto 0);
			even_out4   : out std_logic_vector(5 downto 0));
end Even_Sort;

architecture Behavioral of Even_Sort is
begin
	even_comp1: entity work.Ordenar_2(combinatorial)
	port map( clk => clk,
				 x0  => even_in0,
				 x1  => even_in1,
				 y0  => even_out0,
				 y1  => even_out1);

	even_comp2: entity work.Ordenar_2(combinatorial)
	port map( clk => clk,
				 x0  => even_in2,
				 x1  => even_in3,
				 y0  => even_out2,
				 y1  => even_out3);
	even_out4 <= even_in4;
end Behavioral;