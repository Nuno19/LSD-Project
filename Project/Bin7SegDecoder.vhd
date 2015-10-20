library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity BinDecoder is
	port(enable   : in  std_logic;
		  input0   : in  std_logic_vector(3 downto 0);
		  input1   : in  std_logic_vector(3 downto 0);
		  unidades : out std_logic_vector(6 downto 0);
		  dezenas  : out std_logic_vector(6 downto 0));
end BinDecoder;

architecture Behavioral of BinDecoder is	
begin
	unidades <= "1111111" when (enable = '0') else
					"1111001" when (input0 = "0001") else --1
					"0100100" when (input0 = "0010") else --2
					"0110000" when (input0 = "0011") else --3
					"0011001" when (input0 = "0100") else --4
					"0010010" when (input0 = "0101") else --5
					"0000010" when (input0 = "0110") else --6
					"1111000" when (input0 = "0111") else --7
					"0000000" when (input0 = "1000") else --8
					"0010000" when (input0 = "1001") else --9
					"1000000"; 									  --0
					
	dezenas <=  "1111111" when (enable = '0') else
					"1111001" when (input1 = "0001") else --1
					"0100100" when (input1 = "0010") else --2
					"0110000" when (input1 = "0011") else --3
					"0011001" when (input1 = "0100") else --4
					"0010010" when (input1 = "0101") else --5
					"1111111"; 									  --0
end Behavioral;
