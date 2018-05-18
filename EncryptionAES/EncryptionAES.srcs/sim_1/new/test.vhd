library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.DataTypes.all;
use work.AuxFunctions.all;

entity test is
end test;

architecture Structural of test is
    signal inputBlock  : std_logic_vector(127 downto 0) :=  X"3243f6a8885a308d313198a2e0370734";
    signal cipherKey   : std_logic_vector(127 downto 0) :=  X"2b7e151628aed2a6abf7158809cf4f3c";
    signal cipherBlock : std_logic_vector(127 downto 0);
    
    signal s_clk    :   std_logic;
    signal s_roundKeys : roundKeys;
    signal mat : Matrix;
    signal s_out_initalAddRoundKey : Matrix;
    signal r1_sb : Matrix;
    signal r1_bs : Matrix;
    signal r1_mc : Matrix;
    signal out_round1 : Matrix;

begin
    clock_sim:
    process
    begin
        s_clk <= '0';
        wait for 50 ns;
        s_clk <= '1';
        wait for 50 ns;
    end process;
--    vec_to_mat : entity work.vectorToMatrix(Behavioral)
--                 port map (in_vec => inputBlock,
--                           out_mat => mat);  
                           
    KeyExpansion : entity work.KeyExpansion(Behavioral)
                   port map (clk => s_clk,
                             cipherKey => cipherKey,
                             roundKeys => s_roundKeys);

--    InitialAddRoundKey: entity work.AddRoundKey(Behavioral)
--                        port map ( in_state  => mat,
--                                   round_key => s_roundKeys(0),--cipherKey,
--                                   out_state => s_out_initalAddRoundKey );  
                                   
--   --!  Round 1 Start !--
--    BytesSubstitutionR1 : entity work.SubBytes(Behavioral)
--                        port map (in_state  =>  s_out_initalAddRoundKey,
--                                  out_state => r1_sb);

--    BytesShiftR1        : entity work.RowShifter(Behavioral)
--                        port map (in_state => r1_sb,
--                                  out_state => r1_bs);

--    MixColumnsR1 : entity work.MixColumns(Behavioral)
--                   port map(in_state => r1_bs,
--                            out_state => r1_mc);
                            
--    AddRoundKeyR1: entity work.AddRoundKey(Behavioral)
--                        port map ( in_state  => r1_mc,
--                                   round_key => round_key(1),
--                                   out_state => s_out_initalAddRoundKey );  
end Structural;
