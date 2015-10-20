library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity StateMachine is
	port( clk	   : in  std_logic;
			start	   : in  std_logic;
		   statop   : in  std_logic;
			load	   : in  std_logic;
		   sorted   : in  std_logic;
		   mostrar  : out std_logic;
		   parado   : out std_logic;
			new_set  : out std_logic;
			reset    : out std_logic);
end StateMachine;

architecture Behavioral of StateMachine is

	type TState is (S0, S1, S2, S3, S4, S5);
	signal s_currentState, s_nextState : TState;

begin
	sync_proc : process(clk)
	begin
		if (rising_edge(clk)) then
			s_currentState <= s_nextState;
		end if;
	end process;

	comb_proc : process(s_currentState, statop, start, load, sorted)
	begin
		case (s_currentState) is
		when S0 =>
			mostrar <= '0';
			parado <= '0';
			new_set <= '0';
			reset <= '1';
			if(start ='1') then
				s_nextState <= S1;
			else
				s_nextState <= S0;
			end if;
			
		when S1 =>
			mostrar <= '0';
			parado <= '0';
			new_set <= '0';
			reset <= '0';
			if (load = '1') then
				s_nextState <= S2;
			else
				s_nextState <= S1;
			end if;
			
		when S2 =>
			mostrar <= '0';
			parado <= '0';
			new_set <= '1';
			reset <= '1';
			s_nextState <= S3;
			
		when S3 =>
			mostrar <= '0';
			parado <= '0';
			new_set <= '0';
			reset <= '1';
			if (sorted = '1') then
				s_nextState <= S4;
			elsif (start = '1') then
				s_nextState <= S1;
			else
				s_nextState <= S3;
			end if;
			
		when S4 =>
			mostrar <= '1';
			parado <= '0';
			new_set <= '0';
			reset <= '1';
			if (start = '1') then
				s_nextState <= S1;
			elsif (statop = '1') then
				s_nextState <= S5;
			else
				s_nextState <= S4;
			end if;

		when S5 =>
			mostrar <= '1';
			parado <= '1';
			new_set <= '0';
			reset <= '1';
			if (statop = '1') then
				s_nextState <= S4 after 10 ns;
			else
				s_nextState <= S5 after 10 ns;
			end if;

		when others =>
			s_nextState <= S0;
			
		end case;
	end process;
end Behavioral;
