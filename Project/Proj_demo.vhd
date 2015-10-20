library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Proj_demo is
port 	 (CLOCK_50     : in  std_logic;
		  KEY				: in  std_logic_vector(1 downto 0);
		  HEX4 			: out std_logic_vector(6 downto 0);
		  HEX5 			: out std_logic_vector(6 downto 0);
		  HEX6 			: out std_logic_vector(6 downto 0);
		  HEX7 			: out std_logic_vector(6 downto 0));
end Proj_demo;

architecture Shell of Proj_demo is
	signal s_rnd, s_muxOut: std_logic_vector(5 downto 0);
	signal s_dez1,s_un1, s_dez2,s_un2, s_sel, s_est :std_logic_vector(3 downto 0);
	signal s_input0, s_input1, s_input2, s_input3, s_input4, s_input5, s_input6: std_logic_vector(5 downto 0);
	signal s_sorted0, s_sorted1,  s_sorted2, s_sorted3, s_sorted4, s_sorted5, s_sorted6 : std_logic_vector(5 downto 0);
	signal s_clk,s_clk1:std_logic;
	signal s_loaded, s_reset, s_load0, s_load1 :std_logic;
	signal s_disp, s_sort, s_stop,s_newSet :std_logic;
	signal s_key0, s_key1: std_logic;
	begin
	----------------------------CLK Dividers----------------------------	
---1s--
		clkDivider: entity work.ClkDividerN(Behavioral)
										generic map(divFactor => 50000000)
										port map(reset			 => '0',
													clkIn			 => CLOCK_50,
													clkOut		 => s_clk);
--ns---
		 clkDivider2: entity work.ClkDividerN(Behavioral)
											generic map(divFactor => 50000)
											port map(reset			 => '0',
														clkIn			 => CLOCK_50,
														clkOut		 => s_clk1);
														
----------------------------Debounce--------------------------------

		debounce1: entity work.Debounce(Structural)
										port map(clk1 => s_clk1,
													dirty => KEY(0),
													clean => s_key0);
		debounce2: entity work.Debounce(Structural)
										port map(clk1 => s_clk1,
													dirty => KEY(1),
													clean => s_key1);											
														
-------------------------State Machine----------------------------
		state_machine: entity work.StateMachine(Behavioral)
										port map(clk => s_clk1,
													start	  => s_key0,
													statop  => s_key1,
													load	  => s_loaded,
													sorted  => s_sort,
													mostrar => s_disp,
													parado  => s_stop, 
													new_set => s_newSet, 
													reset   => s_reset);
-------------------PSEUDO RANDOM NUMBER GENERATOR-------------------------
		
		 prbs_num : 		entity work.pseudo_random_generator(v1)
										generic map(n_output_bits => 6,
														seed =>X"1F13_5AC3_5378_682B")
										port map(clk => CLOCK_50,
													rnd => s_rnd);
		 prbs_est : 		entity work.pseudo_random_generator(v1)
										generic map(n_output_bits => 4,
														seed =>X"1957_2763_7CD8_62F9")
										port map(clk => CLOCK_50,
													rnd => s_est);

		
----------------------Registo dos Numeros-------------------------

		num : entity work.Numeros(Behavioral)
										port map( clk	  => s_clk1,
													 reset  => s_reset,
													 input  => s_rnd,
													 loaded => s_load0,
													 dataOut(29 downto 24) => s_input0,
												    dataOut(23 downto 18) => s_input1,
													 dataOut(17 downto 12) => s_input2,
													 dataOut(11 downto 6 ) => s_input3,
													 dataOut( 5 downto 0 ) => s_input4);
	

	estr: entity work.Estrelas(Behavioral)
									port map(clk => s_clk1,
												reset => s_reset,
												input => s_est,
												loaded => s_load1,
												dataOut(11 downto 6) => s_input5,
												dataOut( 5 downto 0) => s_input6);
					
					s_loaded <= s_load0 and s_load1;
													
------------------------------Sorter----------------------------
		sort5:      entity work.Ordenar5(Structural)
									port map(clk  => s_clk1,
												new_set => s_newSet,
												in0  => s_input0,
												in1  => s_input1,
												in2  => s_input2,
												in3  => s_input3,
												in4  => s_input4,
												out0 => s_sorted0,
												out1 => s_sorted1,
												out2 => s_sorted2,
												out3 => s_sorted3,
												out4 => s_sorted4,
												is_sorted => s_sort);
												
		sort2: entity work.Ordenar_2(combinatorial)
									port map(clk => s_clk1,
												x0  => s_input5,
												x1  => s_input6,
												y0  => s_sorted5,
												y1  => s_sorted6);
													
													
-------------------------Counter0_6-------------------------
		count: entity work.Counter0_6(Behavioral)
									port map(clk 	 => s_clk,
												parado => s_stop,												
												reset  => s_reset,
												count  => s_sel);

--------------------------MUX(8-0)--------------------------										
		mux: entity work.Mux8_1(Behavioral)
									port map(sel 	 => s_sel,
												input6 => s_sorted6,
												input5 => s_sorted5,
												input4 => s_sorted4,
												input3 => s_sorted3,
												input2 => s_sorted2,
												input1 => s_sorted1,
												input0 => s_sorted0,
												muxOut => s_muxOut);
						
			--mux_Out<=s_muxOut;
-------------------------Coversor----------------------------
		conv1: entity	work.Conversor6_4(Behavioral)
									port map(binInput => s_muxOut,
												dezenas  => s_dez1,
												unidades => s_un1);
												
		conv2: entity	work.Conversor(Behavioral)
									port map(binInput => s_sel,
												dezenas  => s_dez2,
												unidades => s_un2);											
-------------------------BIn7SegDecoder----------------------

	seg1: entity	work.BinDecoder(Behavioral)
									port map(enable   => '1',
												input0   => s_un1,
												input1   => s_dez1,
												dezenas  => HEX5,
												unidades => HEX4);
	
	seg2: entity	work.BinDecoder(Behavioral)
									port map(enable   => '1',
												input0   => s_un2,
												input1   => s_dez2,
												dezenas  => HEX7,
												unidades => HEX6);
end Shell;
		