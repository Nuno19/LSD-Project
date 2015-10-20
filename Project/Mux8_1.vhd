library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity Mux8_1 is
	port(sel    : in  std_logic_vector(3 downto 0);
		  input0 : in  std_logic_vector(5 downto 0);
		  input1 : in  std_logic_vector(5 downto 0);
		  input2 : in  std_logic_vector(5 downto 0);
		  input3 : in  std_logic_vector(5 downto 0);
		  input4 : in  std_logic_vector(5 downto 0);
		  input5 : in  std_logic_vector(5 downto 0);
		  input6 : in  std_logic_vector(5 downto 0);
		  muxOut : out std_logic_vector(5 downto 0));
end Mux8_1;

architecture Behavioral of Mux8_1 is
begin
with sel select
		muxOut   <= input0 when "0001",
						input1 when "0010",
						input2 when "0011", 
						input3 when "0100",
						input4 when "0101",
						input5 when "0110",
						input6 when "0111",
						"111111" when others;
 end Behavioral;