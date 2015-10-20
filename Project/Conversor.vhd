library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Conversor is
	port(binInput : in  std_logic_vector(3 downto 0);
		  unidades : out std_logic_vector(3 downto 0);
		  dezenas  : out std_logic_vector(3 downto 0));
end Conversor;

architecture Behavioral of Conversor is
	signal s_unidades : std_logic_vector(3 downto 0);
	signal s_dezenas  : std_logic_vector(3 downto 0);
begin
	process(binInput)
	begin
		if(binInput < "0110")then
			s_unidades <= binInput;
			s_dezenas  <= "0000";
		elsif(binInput = "0110") then
			s_unidades <= "0001";
			s_dezenas  <= "0001";
		else
			s_unidades <= "0010";
			s_dezenas  <= "0001";
		end if;
	end process;
	unidades <= s_unidades;
	dezenas  <= s_dezenas;
end Behavioral;