library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.DataTypes.all;

entity AESalgorithm is
    Port ( --clk : in std_logic;
           plainTextBlock : in std_logic_vector(127 downto 0);
           cipherKey      : in std_logic_vector(127 downto 0);
           cipherTextBlock :out std_logic_vector(127 downto 0));
end AESalgorithm;

architecture Behavioral of AESalgorithm is
    signal s_out_initalAddRoundKey : Matrix;
    signal s_vec_to_mat : Matrix;
    
    component vector_to_matrix is 
        port ( in_vec : in std_logic_vector(127 downto 0);
               mat : out Matrix);
    end component vector_to_matrix;    
    
begin
    --! Initial addRoundKey step !--
    -- Convert plainTextBlock bits to Matrix data type
    vec_to_matrix : vector_to_matrix
    port map ( in_vec => plainTextBlock, 
               mat => s_vec_to_mat);               
    InitialAddRoundKey: entity work.AddRoundKey(Behavioral)
                port map ( in_state => s_vec_to_mat,
                           round_key => cipherKey,
                           out_state => s_out_initalAddRoundKey );                
    --! End initial addRoundKey step !--            
    
    -- 1. Key Expansions
    
    -- 2. Initial Round
       -- 2.1 Add round key
    
    -- 3. Rounds 
    --  3.1 SubBytes
    --  3.2 Shift rows
    --  3.3 Mix columns
    --  3.4 Add round keys
    
    -- 4. Final round 
    --  4.1 SubBytes
    --  4.2 Shift rows
    --  4.3 Add round key


end Behavioral;
