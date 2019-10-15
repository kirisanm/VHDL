----------------------------------------------------------------------------------
-- Company: USN - VHDL
-- Engineer: Kirisan Manivannan
-- Design Name: 
-- Module Name: CPU
-- Description: Small CPU

----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity cpu is

    Port (
               clk, reset : in std_logic;
                       db : in std_logic_vector (7 downto 0);   --data bus : in
                       ob : out std_logic_vector (7 downto 0);  --data out bus : out
                       ab : out std_logic_vector (7 downto 0)   --address bus : out
--        rightMotorPhase : out std_logic_vector (3 downto 0);
--         leftMotorPhase : out std_logic_vector (3 downto 0)
        );
end cpu;

architecture arch of cpu is
    constant ABW: integer := 8; --Address Bus Width
    constant DBW: integer := 8; --Data Bus Width
    constant LDRM: unsigned := "10100000";  --Load data to register from memory
    constant JMPM: unsigned := "10110000";  --Jump to memory address
    constant JRNZ: unsigned := "00110000";  --Jump to memory addr if data register not zero

    constant INCR: unsigned := "11000000";  --Increment
    constant DECR: unsigned := "11010000";  --Decrement
    
    constant MF: unsigned := "10000000";    --Move Forward
    constant MB: unsigned := "01000000";    --Move Backward
    constant ML: unsigned := "00100000";    --Move Left
    constant MR: unsigned := "00010000";    --Move Right
    
    constant PUP: unsigned := "10010000";   --Pen UP
    constant PDN: unsigned := "01100000";   --Pen DOWN
    
    constant HALT: unsigned := "11111111";  --HALT
    
    type state_type is(all_0, all_1);
    signal st_pre, st_nxt: state_type;  --state present, state next
    signal pc_pre, pc_nxt: unsigned (ABW-1 downto 0); --Program Counter Present, Program Counter Next
    signal ir_pre, ir_nxt: unsigned (DBW-1 downto 0); --Instruction Register Present, Instruction Register Next
    signal r_pre, r_nxt: unsigned (DBW-1 downto 0); --Register Present, Register Next
    
    begin 
    --State Register
    process(clk, reset)
    begin
        if(reset = '1') then
            st_pre <= all_0;    --State Present is all_0
            pc_pre <= (others => '0');   --reset address i all_0
            ir_pre <= (others => '1');   --
            r_pre <= (others => '0');    --Register is 0
        elsif rising_edge(clk) then
            st_pre <= st_nxt;   -- State Present is State next
            pc_pre <= pc_nxt;   --Program Counter Present is Program Counter Next
            ir_pre <= ir_nxt;   --Instruction Register Present is Instruction Register Next
            r_pre <= r_nxt;    --Register Present is Register Next
        end if;
    end process;
    
    --Next State + (Moore) outputs
    process(st_pre, db, pc_pre, r_pre)  --State present, data bus, Program Counter Present, Register Present
    begin
        st_nxt <= st_pre;   --Assignes next state to present state
        pc_nxt <= pc_pre;
        ir_nxt <= ir_pre;
        r_nxt <= r_pre;
        
        case st_pre is
            when all_0 =>
                ir_nxt <= unsigned(db);
                pc_nxt <= pc_pre + 1;
                st_nxt <= all_1;
                
            when all_1 =>
                if(ir_pre = LDRM) then      --Load data to register from memory
                    r_nxt <= unsigned(db);
                    pc_nxt <= pc_pre + 1;
                    st_nxt <= all_0;
                
                elsif(ir_pre = INCR) then   --Increment Data Register
                    r_nxt <= r_pre + 1;
                    st_nxt <= all_0;
                
                elsif(ir_pre = DECR) then   --Decrement Data Register
                    r_nxt <= r_pre - 1;
                    st_nxt <= all_0;
                
                elsif(ir_pre = JMPM) then   --Jump to memory address
                    pc_nxt <= unsigned(db);
                    st_nxt <= all_0;
                    
                elsif(ir_pre = JRNZ) then   --Jump to memory address if data register not zero
                    if(r_pre = "00000000") then --If zero, Increment Program Counter
                        pc_nxt <= pc_pre + 1;
                        st_nxt <= all_1;
                    else                    --if not zer, jump
                        pc_nxt <= unsigned(db);
                        st_nxt <= all_0;
                
                    end if;
--------------------------------------------------------------------------------
                
                elsif(ir_pre = MF) then     --Move Forward
                    r_nxt <= unsigned(db);
                    pc_nxt <= pc_pre + 1;
                    st_nxt <= all_0;
                    
                elsif(ir_pre = MB) then     --Move Backward
                    r_nxt <= unsigned(db);
                    pc_nxt <= pc_pre + 1;
                    st_nxt <= all_0;
                    
                 elsif(ir_pre = ML) then     --Move Left
                    r_nxt <= unsigned(db);
                    pc_nxt <= pc_pre + 1;
                    st_nxt <= all_0;
                
                 elsif(ir_pre = MR) then     --Move Right
                    r_nxt <= unsigned(db);
                    pc_nxt <= pc_pre + 1;
                    st_nxt <= all_0;
                    
                elsif(ir_pre = PUP) then    --Pen UP
                    r_nxt <= unsigned(db);
                    pc_nxt <= pc_pre + 1;
                    st_nxt <= all_0;
                    
                elsif(ir_pre = PDN) then    --Pen DOWN
                    r_nxt <= unsigned(db);
                    pc_nxt <= pc_pre + 1;
                    st_nxt <= all_0;
                    
               elsif(ir_pre = HALT) then
                    st_nxt <= all_1;
               else
                    st_nxt <= all_0;
               
               end if;
                
          end case;
        end process;
        
        ab <= std_logic_vector(pc_pre);
        ob <= std_logic_vector(r_pre);

end arch;
