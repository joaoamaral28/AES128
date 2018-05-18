library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.DataTypes.all;
use work.AuxFunctions.all;

 -- AES-128 algorithm processing steps
 
    -- 1. Key Expansion
    -- 2. Initial Round
    --  2.1 Add round key
    
    -- 3. Rounds (1-9)
    --  3.1 SubBytes
    --  3.2 Shift rows
    --  3.3 Mix columns
    --  3.4 Add round keys
    
    -- 4. Final round 
    --  4.1 SubBytes
    --  4.2 Shift rows
    --  4.3 Add round key

entity AESalgorithm is
    Port ( clk : in std_logic;
           plainTextBlock : in std_logic_vector(127 downto 0);
           cipherKey      : in std_logic_vector(127 downto 0);
           cipherTextBlock :out std_logic_vector(127 downto 0));
end AESalgorithm;

architecture Behavioral of AESalgorithm is
    signal s_out_initalAddRoundKey : Matrix;
    signal roundKeys : std_logic_vector(1407 downto 0);
    signal in_state : Matrix; 
    signal r1_sb : Matrix; -- after round1 subBytes
    signal r1_bs : Matrix; -- after round1 shiftBytes
    signal r1_mc : Matrix; -- after round1 mixColumns
    signal r1_out : Matrix; -- after round1 addRoundKey
    signal r1_key : std_logic_vector(127 downto 0);
    
begin

    -- Convert plainTextBlock bits to Matrix data type
    vec_to_mat: entity work.vectorToMatrix(Behavioral)
                    port map (in_vec => plainTextBlock,
                              out_mat => in_state);
    
    -- KeyExpansion step --
    keyExp : entity work.KeyExpansion(Behavioral)
                    port map ( cipherKey => cipherKey,
                               roundKeys => roundKeys);
    
    --! Initial addRoundKey step !--                 
    InitialAddRoundKey: entity work.AddRoundKey(Behavioral)
                        port map ( in_state  => in_state,
                                   round_key => cipherKey,
                                   out_state => s_out_initalAddRoundKey );           
    
    --!  Round 1 Start !--
    BytesSubsR1 : entity work.SubBytes(Behavioral)
                  port map (in_state  =>  s_out_initalAddRoundKey,
                            out_state => r1_sb);

    BytesShiftR1 : entity work.RowShifter(Behavioral)
                   port map (in_state => r1_sb,
                             out_state => r1_bs);
    
    MixColumnsR1 : entity work.MixColumns(Behavioral)
                   port map(in_state => r1_bs,
                            out_state => r1_mc);

    AddRoundKeyR1 : entity work.AddRoundKey(Behavioral)
                    port map( in_state => r1_mc,
                              round_key => r1_key,
                              out_state => r1_out);
    --!  Round 1 End   !--    
    
    
    



end Behavioral;
