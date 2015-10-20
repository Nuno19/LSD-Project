library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Estrelas is
	port( clk    : in  std_logic;
			reset  : in  std_logic;
			input  : in  std_logic_vector(3 downto 0); 
         dataOut : out std_logic_vector(11 downto 0);
			loaded	: out std_logic);
end Estrelas;

architecture Behavioral of Estrelas is
signal s_count : unsigned(1 downto 0);
signal s_dataMid : std_logic_vector(5 downto 0);
signal s_dataOut : std_logic_vector(11 downto 0);
begin
	
	process(clk)
		begin
			if(rising_edge(clk)) then
				if ( reset = '1' ) then
					s_count <= "00";
					loaded <= '0';
				elsif(s_count = "10") then
					loaded <='1';
					s_count <= s_count;
				elsif(input > "0000" and input < "1100" and s_count <"10") then
						s_count <= s_count + 1;
						s_dataMid <= "00" & input;
						s_dataOut <= s_dataOut(5 downto 0) & s_dataMid; 
				end if;
			end if;
		end process;
		dataOut <= s_dataOut;
	end Behavioral;	
		
				