library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity cpu_sim_tb is
--    Port ( );
end cpu_sim_tb;

architecture Behavioral of cpu_sim_tb is

    component top_level
        port(
            clk, reset : in std_logic;
                    ob : out std_logic_vector (7 downto 0)
        );
    end component;
    
    --inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    
    --outputs
    signal ob : std_logic_vector (7 downto 0);
    
    --clock period definitions
    constant clk_period : time := 10ns;
    
begin
    -- top_level PORT map(clk <= clk, reset <= reset, ob <= ob);
    
    --clock period definition
    clock_preocess : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    --stimulus process
    stim_proc : process
    begin
        reset <= '1';
        wait for clk_period*2;
        reset <= '0';
        wait for clk_period*1000;
    end process;

end Behavioral;
