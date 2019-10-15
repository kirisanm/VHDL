
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity ROM is
  Port (
    ab : in std_logic_vector (7 downto 0);  --address bus : IN
    db : out std_logic_vector (7 downto 0)  --data bus : OUT
  );
end ROM;

architecture arch of ROM is
    constant ABW : integer := 8;            --address bus width (8-bit)
    constant DBW : integer := 8;            --data bus width (8-bit)
    type rom_type is array (0 to 2**ABW-1)
        of std_logic_vector(DBW-1 downto 0);
      
    --ROM Definition    
    constant content : rom_type := (    --2^8 -by-8
        "10100000", --address 00 contains LD R,M Code (A0H)
        "01010101", --just data (55H)
        "10110000", --address 02 : INCR (B0H)
        "10110000", --address 03 : INCR (B0H)
        "11000000", --address 04 : JMPM (C0H)
        "00000111", --address 05 : address (07H)
        "11111111", --address 06 : HALT (FFH)
        "11111111"  --address 07 : HALT (FFH)
    );  
        
    begin
    db <= content(to_integer(unsigned(ab)));

end arch;
