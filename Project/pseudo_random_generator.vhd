--
-- pseudo-random number generator (warped linear feedback shift register pseudo-random number generator, period=2^64-1)
--
-- if the rnd output is used on every clock cycle, only one output bit should be used
-- if the rnd output is used very rarely, all bits can be used
-- if more than one random number generator is desired instantiate more than one pseudo_random_generator entity, using DIFFERENT seed values
--
-- LSD.TOS April 2015
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity pseudo_random_generator is
  generic
  (
    n_output_bits : integer range 1 to 32         := 1;
    seed          : std_logic_vector(63 downto 0) := X"0123_4567_89AB_CDEF" -- should not be all zeros
  );
  port
  (
    clk : in  std_logic;
    rnd : out std_logic_vector(n_output_bits-1 downto 0)
  );
end pseudo_random_generator;

architecture v1 of pseudo_random_generator is
  constant zero       : std_logic_vector(63 downto 0) := (others => '0');
  signal   state      : std_logic_vector(63 downto 0) := seed;
  signal   next_state : std_logic_vector(63 downto 0);
begin
  --
  -- output
  --
  rnd <= state(n_output_bits-1 downto 0);
  --
  -- state update (memory)
  --
  process(clk) is
  begin
    if rising_edge(clk) then
      if state = zero then
        state <= (0 => '1', others => '0'); -- avoid being stuck at zero (just in case)
      else
        state <= next_state;
      end if;
    end if;
  end process;
  --
  -- next state computation (4 levels of combinatorial logic)
  --
  next_state( 0) <= state(15) xor state(22) xor state(23) xor state(36) xor state(42) xor state(44) xor state(53) xor state(55) xor state(59);               -- state( 0) used  8 times
  next_state( 1) <= state( 2) xor state( 5) xor state(13) xor state(18) xor state(21) xor state(28) xor state(62) xor state(63);                             -- state( 1) used  7 times
  next_state( 2) <= state( 4) xor state( 5) xor state( 6) xor state(23) xor state(31) xor state(36) xor state(39) xor state(44) xor state(46) xor state(53); -- state( 2) used  7 times
  next_state( 3) <= state( 1) xor state( 6) xor state(24) xor state(27) xor state(37) xor state(39) xor state(41) xor state(51) xor state(63);               -- state( 3) used  7 times
  next_state( 4) <= state( 3) xor state( 4) xor state(28) xor state(32) xor state(37) xor state(46) xor state(50);                                           -- state( 4) used  9 times
  next_state( 5) <= state(14) xor state(21) xor state(24) xor state(31) xor state(35) xor state(41) xor state(42) xor state(47) xor state(62);               -- state( 5) used  7 times
  next_state( 6) <= state( 3) xor state(16) xor state(24) xor state(27) xor state(32) xor state(40) xor state(43) xor state(48) xor state(50) xor state(59); -- state( 6) used  9 times
  next_state( 7) <= state( 1) xor state( 4) xor state(23) xor state(32) xor state(33) xor state(43) xor state(51);                                           -- state( 7) used  7 times
  next_state( 8) <= state(26) xor state(27) xor state(28) xor state(29) xor state(31) xor state(34) xor state(50);                                           -- state( 8) used  7 times
  next_state( 9) <= state(10) xor state(18) xor state(29) xor state(33) xor state(37) xor state(42) xor state(45) xor state(47) xor state(57) xor state(63); -- state( 9) used  7 times
  next_state(10) <= state( 0) xor state( 7) xor state(20) xor state(23) xor state(26) xor state(31) xor state(47) xor state(57) xor state(63);               -- state(10) used  8 times
  next_state(11) <= state(10) xor state(16) xor state(22) xor state(36) xor state(39) xor state(43) xor state(44) xor state(56);                             -- state(11) used 11 times
  next_state(12) <= state( 1) xor state(14) xor state(17) xor state(27) xor state(37) xor state(39) xor state(52);                                           -- state(12) used  6 times
  next_state(13) <= state( 9) xor state(13) xor state(36) xor state(38) xor state(39) xor state(53) xor state(54) xor state(59) xor state(63);               -- state(13) used  8 times
  next_state(14) <= state(14) xor state(20) xor state(21) xor state(31) xor state(39) xor state(42) xor state(60);                                           -- state(14) used 10 times
  next_state(15) <= state(15) xor state(18) xor state(33) xor state(34) xor state(40) xor state(51) xor state(62);                                           -- state(15) used 10 times
  next_state(16) <= state( 2) xor state( 8) xor state(19) xor state(23) xor state(30) xor state(43) xor state(49);                                           -- state(16) used 11 times
  next_state(17) <= state( 0) xor state( 1) xor state( 6) xor state( 7) xor state(11) xor state(22) xor state(38) xor state(41) xor state(49);               -- state(17) used  6 times
  next_state(18) <= state(10) xor state(13) xor state(18) xor state(24) xor state(36) xor state(40) xor state(43) xor state(50) xor state(51) xor state(58); -- state(18) used 11 times
  next_state(19) <= state(14) xor state(16) xor state(22) xor state(35) xor state(39) xor state(41) xor state(44) xor state(46) xor state(47) xor state(59); -- state(19) used  6 times
  next_state(20) <= state(13) xor state(19) xor state(20) xor state(28) xor state(30) xor state(33) xor state(40) xor state(49);                             -- state(20) used  7 times
  next_state(21) <= state( 8) xor state(13) xor state(16) xor state(22) xor state(39) xor state(41) xor state(52) xor state(53) xor state(56);               -- state(21) used  6 times
  next_state(22) <= state( 3) xor state( 9) xor state(15) xor state(19) xor state(27) xor state(30) xor state(49) xor state(54) xor state(58) xor state(63); -- state(22) used  8 times
  next_state(23) <= state( 0) xor state( 6) xor state(16) xor state(22) xor state(43) xor state(54) xor state(55) xor state(56) xor state(60);               -- state(23) used 11 times
  next_state(24) <= state( 5) xor state(12) xor state(17) xor state(18) xor state(30) xor state(31) xor state(35) xor state(46) xor state(53) xor state(60); -- state(24) used  6 times
  next_state(25) <= state( 7) xor state(14) xor state(21) xor state(33) xor state(36) xor state(38) xor state(42) xor state(45) xor state(51) xor state(60); -- state(25) used  7 times
  next_state(26) <= state( 2) xor state( 4) xor state( 9) xor state(10) xor state(25) xor state(41) xor state(48) xor state(51) xor state(60);               -- state(26) used  7 times
  next_state(27) <= state( 9) xor state(14) xor state(17) xor state(18) xor state(31) xor state(52) xor state(57) xor state(62);                             -- state(27) used 10 times
  next_state(28) <= state( 4) xor state(11) xor state(30) xor state(45) xor state(46) xor state(48) xor state(55) xor state(58) xor state(63);               -- state(28) used  9 times
  next_state(29) <= state( 3) xor state( 6) xor state(10) xor state(11) xor state(25) xor state(28) xor state(58) xor state(63);                             -- state(29) used  8 times
  next_state(30) <= state( 2) xor state( 4) xor state(40) xor state(45) xor state(47) xor state(56) xor state(61);                                           -- state(30) used  9 times
  next_state(31) <= state( 0) xor state(26) xor state(35) xor state(43) xor state(46) xor state(53) xor state(61);                                           -- state(31) used 11 times
  next_state(32) <= state(11) xor state(25) xor state(34) xor state(35) xor state(47) xor state(55) xor state(56) xor state(59);                             -- state(32) used  9 times
  next_state(33) <= state( 0) xor state( 6) xor state(11) xor state(25) xor state(26) xor state(27) xor state(28) xor state(31) xor state(40) xor state(44); -- state(33) used  9 times
  next_state(34) <= state( 8) xor state(29) xor state(34) xor state(42) xor state(44) xor state(48) xor state(55) xor state(56) xor state(57) xor state(58); -- state(34) used  9 times
  next_state(35) <= state( 0) xor state(11) xor state(12) xor state(16) xor state(25) xor state(30) xor state(60) xor state(63);                             -- state(35) used 10 times
  next_state(36) <= state( 8) xor state(28) xor state(31) xor state(39) xor state(40) xor state(46) xor state(54) xor state(58);                             -- state(36) used 11 times
  next_state(37) <= state( 2) xor state( 9) xor state(13) xor state(27) xor state(32) xor state(34) xor state(37) xor state(49) xor state(57);               -- state(37) used 12 times
  next_state(38) <= state( 7) xor state(17) xor state(19) xor state(23) xor state(29) xor state(35) xor state(41) xor state(52) xor state(61);               -- state(38) used  8 times
  next_state(39) <= state( 3) xor state( 8) xor state( 9) xor state(12) xor state(15) xor state(23) xor state(31) xor state(59);                             -- state(39) used 11 times
  next_state(40) <= state( 2) xor state( 4) xor state(13) xor state(18) xor state(32) xor state(34) xor state(37) xor state(39) xor state(41);               -- state(40) used  9 times
  next_state(41) <= state( 1) xor state(29) xor state(36) xor state(45) xor state(47) xor state(54) xor state(56);                                           -- state(41) used 11 times
  next_state(42) <= state(12) xor state(14) xor state(18) xor state(19) xor state(20) xor state(23) xor state(36) xor state(37) xor state(42);               -- state(42) used  9 times
  next_state(43) <= state(16) xor state(18) xor state(27) xor state(29) xor state(41) xor state(49) xor state(51) xor state(58);                             -- state(43) used 11 times
  next_state(44) <= state( 0) xor state( 7) xor state(17) xor state(18) xor state(50) xor state(61) xor state(62);                                           -- state(44) used  8 times
  next_state(45) <= state( 6) xor state(12) xor state(18) xor state(27) xor state(30) xor state(33) xor state(35) xor state(43) xor state(52);               -- state(45) used  8 times
  next_state(46) <= state(11) xor state(20) xor state(25) xor state(32) xor state(50) xor state(51) xor state(59);                                           -- state(46) used  8 times
  next_state(47) <= state(23) xor state(26) xor state(38) xor state(40) xor state(49) xor state(53) xor state(54) xor state(58) xor state(61);               -- state(47) used 10 times
  next_state(48) <= state( 4) xor state(16) xor state(37) xor state(42) xor state(45) xor state(54) xor state(59) xor state(62);                             -- state(48) used  7 times
  next_state(49) <= state( 5) xor state(15) xor state(19) xor state(35) xor state(37) xor state(43) xor state(55) xor state(59);                             -- state(49) used  8 times
  next_state(50) <= state(15) xor state(16) xor state(27) xor state(32) xor state(35) xor state(37) xor state(40) xor state(47) xor state(58);               -- state(50) used  6 times
  next_state(51) <= state( 2) xor state( 5) xor state(23) xor state(31) xor state(38) xor state(41) xor state(61) xor state(62);                             -- state(51) used 10 times
  next_state(52) <= state( 7) xor state(14) xor state(23) xor state(28) xor state(38) xor state(47) xor state(56) xor state(61);                             -- state(52) used  9 times
  next_state(53) <= state( 5) xor state(16) xor state(17) xor state(24) xor state(33) xor state(34) xor state(38) xor state(43) xor state(52) xor state(57); -- state(53) used 10 times
  next_state(54) <= state( 3) xor state( 6) xor state( 7) xor state(15) xor state(33) xor state(37) xor state(51);                                           -- state(54) used  7 times
  next_state(55) <= state(10) xor state(14) xor state(15) xor state(20) xor state(21) xor state(34) xor state(36) xor state(37) xor state(55);               -- state(55) used  7 times
  next_state(56) <= state(11) xor state(12) xor state(13) xor state(16) xor state(39) xor state(43) xor state(44) xor state(58) xor state(59);               -- state(56) used  8 times
  next_state(57) <= state( 8) xor state(14) xor state(30) xor state(35) xor state(38) xor state(47) xor state(51) xor state(52) xor state(53) xor state(60); -- state(57) used  7 times
  next_state(58) <= state( 1) xor state( 9) xor state(15) xor state(32) xor state(33) xor state(36) xor state(41) xor state(48) xor state(60);               -- state(58) used 10 times
  next_state(59) <= state( 4) xor state(10) xor state(11) xor state(24) xor state(36) xor state(44) xor state(45) xor state(49) xor state(63);               -- state(59) used 10 times
  next_state(60) <= state( 5) xor state(20) xor state(22) xor state(29) xor state(30) xor state(32) xor state(45) xor state(48) xor state(57);               -- state(60) used  8 times
  next_state(61) <= state( 1) xor state( 6) xor state(11) xor state(26) xor state(42) xor state(52) xor state(53);                                           -- state(61) used  7 times
  next_state(62) <= state( 0) xor state( 3) xor state( 8) xor state(29) xor state(34) xor state(46) xor state(48) xor state(52) xor state(53);               -- state(62) used  7 times
  next_state(63) <= state(10) xor state(11) xor state(15) xor state(21) xor state(22) xor state(25) xor state(26) xor state(28);                             -- state(63) used 10 times
end v1;
