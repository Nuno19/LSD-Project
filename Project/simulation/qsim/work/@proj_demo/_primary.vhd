library verilog;
use verilog.vl_types.all;
entity Proj_demo is
    port(
        CLOCK_50        : in     vl_logic;
        KEY             : in     vl_logic_vector(1 downto 0);
        HEX4            : out    vl_logic_vector(6 downto 0);
        HEX5            : out    vl_logic_vector(6 downto 0);
        HEX6            : out    vl_logic_vector(6 downto 0);
        HEX7            : out    vl_logic_vector(6 downto 0)
    );
end Proj_demo;
