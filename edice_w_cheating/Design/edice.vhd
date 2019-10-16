-- e-dice using RSC (result generator module)
-- credits: Jose Manuel Martins Ferreira

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity resgen is  -- result generator module
    port ( cheat, run, clk, rst: in std_logic;
           rin: in std_logic_vector (2 downto 0); -- cheating value: called R(2:0) in the spec
           rout: out std_logic_vector (2 downto 0) -- result output to drive the outputs decoder
	 );
end resgen;

architecture arch of resgen is
signal clear: std_logic;
signal ffin, ffout: unsigned(2 downto 0);

begin
-- state register
process (clk, rst)
begin
    if (rst = '1') then
        ffout <= (others => '0');
    elsif rising_edge(clk) then
        ffout <= ffin;
    end if;
end process;

-- next-state
clear <= ( run and not(cheat) and ffout(2) and not(ffout(1)) and ffout(0) )       -- restart at 5 when not cheating
         -- restart at 5 if cheating with invalid result (0): 
         or ( run and cheat and ffout(2) and not(ffout(1)) and ffout(0) and not(rin(2)) and not(rin(1)) and not(rin(0)) )  
         -- restart at 5 if cheating with invalid result (7):
         or ( run and cheat and ffout(2) and not(ffout(1)) and ffout(0) and rin(2) and rin(1) and rin(0) );                   

ffin <= ffout when run='0' else
        (others => '0') when clear = '1'  else  
        ffout + 1;

-- outputs
rout <= std_logic_vector(ffout) when ffout<=5 else
        std_logic_vector(unsigned(rin)-1); -- because result 1 is defined by rout=”000”

end arch;
