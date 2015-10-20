library verilog;
use verilog.vl_types.all;
entity Proj_demo_vlg_check_tst is
    port(
        HEX4            : in     vl_logic_vector(6 downto 0);
        HEX5            : in     vl_logic_vector(6 downto 0);
        HEX6            : in     vl_logic_vector(6 downto 0);
        HEX7            : in     vl_logic_vector(6 downto 0);
        sampler_rx      : in     vl_logic
    );
end Proj_demo_vlg_check_tst;
