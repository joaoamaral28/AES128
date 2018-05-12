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

    out_state <= matrix_vec_xor(in_state,round_key);
       
end Behavioral;