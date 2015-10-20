library IEEE; 
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity NewSort is
	port(	new_set : in  std_logic;
			old_in0  : in  std_logic_vector(5 downto 0);
			old_in1  : in  std_logic_vector(5 downto 0);
			old_in2  : in  std_logic_vector(5 downto 0);
			old_in3  : in  std_logic_vector(5 downto 0);
			old_in4  : in  std_logic_vector(5 downto 0);
			new_in0  : in  std_logic_vector(5 downto 0); 
			new_in1  : in  std_logic_vector(5 downto 0);
			new_in2  : in  std_logic_vector(5 downto 0);
			new_in3  : in  std_logic_vector(5 downto 0);
			new_in4  : in  std_logic_vector(5 downto 0);
			mux_out0 : out std_logic_vector(5 downto 0);
			mux_out1 : out std_logic_vector(5 downto 0);
			mux_out2 : out std_logic_vector(5 downto 0);
			mux_out3 : out std_logic_vector(5 downto 0);
			mux_out4 : out std_logic_vector(5 downto 0));
end NewSort;

architecture Behavioral of NewSort is
begin
	process(new_set, new_in0, new_in1, new_in2, new_in3, new_in4, old_in0, old_in1, old_in2, old_in3, old_in4)
	begin
		if (new_set = '1') then
			mux_out0 <= old_in0;
			mux_out1 <= old_in1;
			mux_out2 <= old_in2;
			mux_out3 <= old_in3;
			mux_out4 <= old_in4;
		else
			mux_out0 <= new_in0;
			mux_out1 <= new_in1;
			mux_out2 <= new_in2;
			mux_out3 <= new_in3;
			mux_out4 <= new_in4;
		end if;
	end process;
end Behavioral;