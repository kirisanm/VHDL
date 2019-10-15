-- 

library ieee;
use ieee.std_logic_1164.all;
 
entity adder4bits_tb is
end adder4bits_tb;
 
architecture behavior of adder4bits_tb is 
    -- Component Declarations for the Units Under Test (UUT)
    component adder4bits
    port(
         Cin: in std_logic;
         opA: in std_logic_vector(3 downto 0);
         opB: in std_logic_vector(3 downto 0);
         resC: out std_logic_vector(3 downto 0);
         Cout: out std_logic
        );
    end component;

   --Inputs
   signal Cin: std_logic;
   signal opA, opB: std_logic_vector(3 downto 0);

 	--Outputs
   signal Cout: std_logic;
   signal resC: std_logic_vector(3 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder4bits port map (
          Cin => Cin,
          opA => opA,
          opB => opB,
          resC => resC,
          Cout => Cout
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
        Cin <= '0';
        opA <= "0001";    -- opA=1
        opB <= "0011";    -- opB=3
        wait for 30 ns;
        opA <= "0010";    -- opA=2
        wait for 30 ns;
        opA <= "0011";    -- opA=3
        wait for 30 ns;
        opA <= "0100";    -- opA=4
        wait for 30 ns;
        opA <= "0101";    -- opA=5
        wait for 30 ns;
   end process;

END;
