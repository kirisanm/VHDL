----------------------------------------------------------------------------------
-- Engineer: Kirisan Manivannan and Rahmat Mozafari

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
	port(
			clk, rst: in std_logic;
			ob: out std_logic_vector(7 downto 0)
		);
end top;

architecture arch of top is
	constant ABW,DBW: integer := 8; -- address & data bus width
    signal ab: std_logic_vector(ABW-1 downto 0);
	signal db: std_logic_vector(DBW-1 downto 0);	
	
component cpu
    port(
        clk, rst: in std_logic;
        db: in std_logic_vector(7 downto 0);
        ab, ob: out std_logic_vector(7 downto 0)
                );
end component;
        
component rom
    port(
      ab: in std_logic_vector(7 downto 0);
      db: out std_logic_vector(7 downto 0)
        );        
end component;

begin  
        
	  control_unit: cpu	
      port map ( clk => clk, rst => rst,
                 ab => ab, db => db, ob => ob
				);
					
      rom_unit: rom	
      port map( ab => ab, 
				db => db
				);	  
					
end  arch;