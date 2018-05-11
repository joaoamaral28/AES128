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
            ---text_block : in std_logic_vector(127 downto 0);
            ---cipherKey : in std_logic_vector(127 downto 0);
            ---out_block : out std_logic_vector(127 downto 0));
end AddRoundKey;

architecture Behavioral of AddRoundKey is 
    signal xor_out : Matrix;
    
    component matrix_vec_xor is 
        port ( in_mat : in Matrix;
               in_vec : in std_logic_vector(127 downto 0);
               out_mat: out Matrix);
    end component matrix_vec_xor;

begin   

    xo_r : matrix_vec_xor
    port map ( in_mat => in_state, 
               in_vec => round_key,
               out_mat => xor_out);
                   
    out_state <= xor_out;
       
end Behavioral;