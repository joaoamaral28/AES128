library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.DataTypes.all;
use work.AuxFunctions.all;

--The AddRoundKey transformation is a bitwise XOR operation of the state bits 
--and the bits of the current roundkey
entity AddRoundKey is
    Port (  --clk : in std_logic;
            in_state : in Matrix;
            round_key : in std_logic_vector(127 downto 0);
            out_state : out Matrix);
end AddRoundKey;

architecture Behavioral of AddRoundKey is 
begin   
    -- xoring the input state with the round key
    out_state(0)(0) <= in_state(0)(0) xor round_key(127 downto 120);
    out_state(1)(0) <= in_state(1)(0) xor round_key(119 downto 112);
    out_state(2)(0) <= in_state(2)(0) xor round_key(111 downto 104);
    out_state(3)(0) <= in_state(3)(0) xor round_key(103 downto 96);
    
    out_state(0)(1) <= in_state(0)(1) xor round_key(95 downto 88);
    out_state(1)(1) <= in_state(1)(1) xor round_key(87 downto 80);
    out_state(2)(1) <= in_state(2)(1) xor round_key(79 downto 72);
    out_state(3)(1) <= in_state(3)(1) xor round_key(71 downto 64);
    
    out_state(0)(2) <= in_state(0)(2) xor round_key(63 downto 56);
    out_state(1)(2) <= in_state(1)(2) xor round_key(55 downto 48);
    out_state(2)(2) <= in_state(2)(2) xor round_key(47 downto 40);
    out_state(3)(2) <= in_state(3)(2) xor round_key(39 downto 32);
    
    out_state(0)(3) <= in_state(0)(3) xor round_key(31 downto 24);
    out_state(1)(3) <= in_state(1)(3) xor round_key(23 downto 16);
    out_state(2)(3) <= in_state(2)(3) xor round_key(15 downto 8);
    out_state(3)(3) <= in_state(3)(3) xor round_key(7 downto 0);

    --out_state <= matrix_vec_xor(in_state,round_key);
        
end Behavioral;