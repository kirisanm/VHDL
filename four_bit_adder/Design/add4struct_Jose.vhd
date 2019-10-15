-- USN VHDL 101 course
-- 4-bit adder using 1-bit adders
-- structural description
-- author: josemmf@usn.no

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity adder4bits is
    Port ( Cin: in std_logic;
           opA: in std_logic_vector(3 downto 0);
           opB: in std_logic_vector(3 downto 0);
           resC: out std_logic_vector(3 downto 0);
           Cout: out std_logic
	 );
end adder4bits;

architecture sarch of adder4bits is
  signal ic01, ic12, ic23: std_logic;

    component adder1bit
        Port (Cin, A, B: in std_logic;
              Cout, S: out std_logic);
    end component;

begin
    U0: adder1bit Port Map 
	(Cin => '0', A => opA(0), B => opB(0),
	 Cout => ic01, S => resC(0));
    U1: adder1bit Port Map 
	(Cin => ic01, A => opA(1), B => opB(1),
	 Cout => ic12, S => resC(1));
    U2: adder1bit Port Map 
	(Cin => ic12, A => opA(2), B => opB(2),
	 Cout => ic23, S => resC(2));
    U3: adder1bit Port Map 
	(Cin => ic23, A => opA(3), B => opB(3),
	 Cout => Cout, S => resC(3));

end sarch;
