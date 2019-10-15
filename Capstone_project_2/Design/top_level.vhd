
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity top_level is
  Port (clk, reset : in std_logic;
        ob : out std_logic_vector (7 downto 0)
--        ab : in std_logic_vector (7 downto 0);
--        db : out std_logic_vector (7 downto 0) 
  );
end top_level;

architecture arch of top_level is
    constant ABW : integer := 8;    --address bus width
    constant DBW : integer := 8;    --data bus width
    signal ab : std_logic_vector(ABW-1 downto 0);
    signal db : std_logic_vector(DBW-1 downto 0);
    
    component CPU
        port (clk, reset : in std_logic;
              db : in std_logic_vector (7 downto 0);
              ab, ob : out std_logic_vector (7 downto 0));
    end component;
    
    component ROM
        port (ab : in std_logic_vector (7 downto 0);
              db : out std_logic_vector (7 downto 0));
    end component;
    
begin
    ctr_unit : CPU
        port map(clk => clk, reset => reset, ab => ab, db => db, ob => ob);
    ROM_unit : ROM
        port map(ab => ab, db => db);    
end arch;
