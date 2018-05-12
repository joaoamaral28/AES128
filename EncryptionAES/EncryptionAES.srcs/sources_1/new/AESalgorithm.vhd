library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.DataTypes.all;
use work.AuxFunctions.all;

entity AESalgorithm is
    Port ( --clk : in std_logic;
           plainTextBlock : in std_logic_vector(127 downto 0);
           cipherKey      : in std_logic_vector(127 downto 0);
           cipherTextBlock :out std_logic_vector(127 downto 0));
end AESalgorithm;

architecture Behavioral of AESalgorithm is
    signal s_out_initalAddRoundKey : Matrix;
    signal in_state : Matrix; 
    signal r1_sb : Matrix;
begin
    -- Convert plainTextBlock bits to Matrix data type
    in_state <= vector_to_matrix(plainTextBlock);  
       
    --! Initial addRoundKey step !--                 
    InitialAddRoundKey: entity work.AddRoundKey(Behavioral)
                port map ( in_state  => in_state,
                           round_key => cipherKey,
                           out_state => s_out_initalAddRoundKey );                
    --! End initial addRoundKey step !--            
    
    --!  Round 1 Start !--
    BytesSubstitution : entity work.SubBytes(Behavioral)
                port map (in_state  =>  s_out_initalAddRoundKey,
                          out_state => r1_sb);

    --!  Round 1 End   !--    
    
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
