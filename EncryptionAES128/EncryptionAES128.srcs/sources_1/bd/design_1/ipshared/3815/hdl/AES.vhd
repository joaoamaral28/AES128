library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.DataTypes.all;

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

entity AES is
    Port ( clk : in std_logic;
           plainTextBlock  : in std_logic_vector(127 downto 0);
           cipherKey       : in std_logic_vector(127 downto 0);
           valid           : out std_logic;
           cipherTextBlock : out std_logic_vector(127 downto 0));
end AES;

architecture Behavioral of AES is
    -- Pre processing signals
    signal s_roundKeys : roundKeys;
    signal mat : Matrix;
    signal out_initalAddRoundKey : Matrix;
    -- Round1 Signals
    signal r1_sb, r1_bs, r1_mc, out_AddRoundKeyR1 : Matrix;
    -- Round2 Signals
    signal r2_sb, r2_bs, r2_mc, out_AddRoundKeyR2 : Matrix;
    -- Round3 Signals
    signal r3_sb, r3_bs, r3_mc, out_AddRoundKeyR3 : Matrix;
    -- Round4 Signals
    signal r4_sb, r4_bs, r4_mc, out_AddRoundKeyR4 : Matrix;
    -- Round5 Signals
    signal r5_sb, r5_bs, r5_mc, out_AddRoundKeyR5 : Matrix;
    -- Round6 Signals
    signal r6_sb, r6_bs, r6_mc, out_AddRoundKeyR6 : Matrix;
    -- Round7 Signals
    signal r7_sb, r7_bs, r7_mc, out_AddRoundKeyR7 : Matrix;
    -- Round8 Signals
    signal r8_sb, r8_bs, r8_mc, out_AddRoundKeyR8 : Matrix;
    -- Round9 Signals
    signal r9_sb, r9_bs, r9_mc, out_AddRoundKeyR9 : Matrix;
    -- FinalRound Signals
    signal r10_sb, r10_bs, out_AddRoundKeyR10 : Matrix;
    signal s_output : std_logic_vector(127 downto 0);
    signal s_can_read : std_logic;
    
begin
    -- Pre processing
    -- Convert plainTextBlock bits to Matrix data type
    vec_to_mat : entity work.vectorToMatrix(Behavioral)
                 port map (clk => clk,
                           in_vec => plainTextBlock,
                           out_mat => mat);       
    -- Round keys generation
    KeyExpansion : entity work.KeyExpansion(Behavioral)
                   port map (clk => clk,
                             cipherKey => cipherKey,
                             roundKeys => s_roundKeys);
    -- Initial add round key
    InitialAddRoundKey: entity work.AddRoundKey(Behavioral)
                        port map ( clk => clk,
                                   in_state  => mat,
                                   round_key => s_roundKeys(0),--cipherKey,
                                   out_state => out_initalAddRoundKey );  
                                   
   --!  Round 1 Start !--
    BytesSubstitutionR1 : entity work.SubBytes(Behavioral)
                        port map (clk => clk,
                                  in_state  =>  out_initalAddRoundKey,
                                  out_state => r1_sb);

    BytesShiftR1        : entity work.RowShifter(Behavioral)
                        port map (clk => clk,
                                  in_state => r1_sb,
                                  out_state => r1_bs);

    MixColumnsR1 : entity work.MixColumns(Behavioral)
                   port map(clk => clk,
                            in_state => r1_bs,
                            out_state => r1_mc);
                            
    AddRoundKeyR1: entity work.AddRoundKey(Behavioral)
                        port map ( clk => clk,
                                   in_state  => r1_mc,
                                   round_key => s_roundKeys(1),
                                   out_state => out_AddRoundKeyR1 ); 
    --!  Round 1 End !--
    
   --!  Round 2 Start !--
     BytesSubstitutionR2 : entity work.SubBytes(Behavioral)
                         port map (clk => clk,
                                    in_state  =>  out_AddRoundKeyR1,
                                   out_state => r2_sb);
 
     BytesShiftR2 : entity work.RowShifter(Behavioral)
                    port map (clk => clk,in_state => r2_sb,
                              out_state => r2_bs);
 
     MixColumnsR2 : entity work.MixColumns(Behavioral)
                    port map(clk => clk,in_state => r2_bs,
                             out_state => r2_mc);
                             
     AddRoundKeyR2: entity work.AddRoundKey(Behavioral)
                         port map ( clk => clk,in_state  => r2_mc,
                                    round_key => s_roundKeys(2),
                                    out_state => out_AddRoundKeyR2 ); 
    --!  Round 2 End !--
    --!  Round 3 Start !--
    BytesSubstitutionR3 : entity work.SubBytes(Behavioral)
                      port map (clk => clk,in_state  =>  out_AddRoundKeyR2,
                                out_state => r3_sb);
    
    BytesShiftR3 : entity work.RowShifter(Behavioral)
                 port map (clk => clk,in_state => r3_sb,
                           out_state => r3_bs);
    
    MixColumnsR3 : entity work.MixColumns(Behavioral)
                 port map(clk => clk,in_state => r3_bs,
                          out_state => r3_mc);
                          
    AddRoundKeyR3: entity work.AddRoundKey(Behavioral)
                      port map ( clk => clk,in_state  => r3_mc,
                                 round_key => s_roundKeys(3),
                                 out_state => out_AddRoundKeyR3 ); 
    --!  Round 3 End !--    
    --!  Round 4 Start !--
    BytesSubstitutionR4 : entity work.SubBytes(Behavioral)
                       port map (clk => clk,in_state  =>  out_AddRoundKeyR3,
                                 out_state => r4_sb);
    
    BytesShiftR4 : entity work.RowShifter(Behavioral)
                  port map (clk => clk,in_state => r4_sb,
                            out_state => r4_bs);
    
    MixColumnsR4 : entity work.MixColumns(Behavioral)
                  port map(clk => clk,in_state => r4_bs,
                           out_state => r4_mc);
                           
    AddRoundKeyR4: entity work.AddRoundKey(Behavioral)
                       port map (clk => clk, in_state  => r4_mc,
                                  round_key => s_roundKeys(4),
                                  out_state => out_AddRoundKeyR4 ); 
    --!  Round 4 End !--     
    --!  Round 5 Start !--
    BytesSubstitutionR5 : entity work.SubBytes(Behavioral)
                      port map (clk => clk,in_state  =>  out_AddRoundKeyR4,
                                out_state => r5_sb);
    
    BytesShiftR5 : entity work.RowShifter(Behavioral)
                 port map (clk => clk,in_state => r5_sb,
                           out_state => r5_bs);
    
    MixColumnsR5 : entity work.MixColumns(Behavioral)
                 port map(clk => clk,in_state => r5_bs,
                          out_state => r5_mc);
                          
    AddRoundKeyR5: entity work.AddRoundKey(Behavioral)
                      port map ( clk => clk,in_state  => r5_mc,
                                 round_key => s_roundKeys(5),
                                 out_state => out_AddRoundKeyR5 ); 
     --!  Round 5 End !-- 
    --!  Round 6 Start !--
    BytesSubstitutionR6 : entity work.SubBytes(Behavioral)
                       port map (clk => clk,in_state  =>  out_AddRoundKeyR5,
                                 out_state => r6_sb);
    
    BytesShiftR6 : entity work.RowShifter(Behavioral)
                  port map (clk => clk,in_state => r6_sb,
                            out_state => r6_bs);
    
    MixColumnsR6 : entity work.MixColumns(Behavioral)
                  port map(clk => clk,in_state => r6_bs,
                           out_state => r6_mc);
                           
    AddRoundKeyR6: entity work.AddRoundKey(Behavioral)
                       port map ( clk => clk,in_state  => r6_mc,
                                  round_key => s_roundKeys(6),
                                  out_state => out_AddRoundKeyR6 ); 
    --!  Round 6 End !-- 
    --!  Round 7 Start !--
    BytesSubstitutionR7 : entity work.SubBytes(Behavioral)
                          port map (clk => clk,in_state  =>  out_AddRoundKeyR6,
                                    out_state => r7_sb);
    
    BytesShiftR7 : entity work.RowShifter(Behavioral)
                   port map (clk => clk,in_state => r7_sb,
                             out_state => r7_bs);
    
    MixColumnsR7 : entity work.MixColumns(Behavioral)
                   port map(clk => clk,in_state => r7_bs,
                            out_state => r7_mc);
                         
    AddRoundKeyR7: entity work.AddRoundKey(Behavioral)
                   port map ( clk => clk,in_state  => r7_mc,
                              round_key => s_roundKeys(7),
                              out_state => out_AddRoundKeyR7 ); 
    --!  Round 7 End !-- 
    --!  Round 8 Start !--
     BytesSubstitutionR8 : entity work.SubBytes(Behavioral)
                           port map (clk => clk,in_state  =>  out_AddRoundKeyR7,
                                     out_state => r8_sb);
    
     BytesShiftR8 : entity work.RowShifter(Behavioral)
                    port map (clk => clk,in_state => r8_sb,
                              out_state => r8_bs);
    
     MixColumnsR8 : entity work.MixColumns(Behavioral)
                    port map(clk => clk,in_state => r8_bs,
                             out_state => r8_mc);
                             
     AddRoundKeyR8: entity work.AddRoundKey(Behavioral)
                         port map (clk => clk, in_state  => r8_mc,
                                    round_key => s_roundKeys(8),
                                    out_state => out_AddRoundKeyR8 ); 
    --!  Round 8 End !-- 
    --!  Round 9 Start !--
     BytesSubstitutionR9 : entity work.SubBytes(Behavioral)
                         port map (clk => clk,in_state  =>  out_AddRoundKeyR8,
                                   out_state => r9_sb);
    
     BytesShiftR9 : entity work.RowShifter(Behavioral)
                    port map (clk => clk,in_state => r9_sb,
                              out_state => r9_bs);
    
     MixColumnsR9 : entity work.MixColumns(Behavioral)
                    port map(clk => clk,in_state => r9_bs,
                             out_state => r9_mc);
                             
     AddRoundKeyR9: entity work.AddRoundKey(Behavioral)
                         port map ( clk => clk,in_state  => r9_mc,
                                    round_key => s_roundKeys(9),
                                    out_state => out_AddRoundKeyR9 ); 
    --!  Round 9 End !-- 
    --!  FinalRound Start !--
     BytesSubstitutionR10 : entity work.SubBytes(Behavioral)
                         port map (clk => clk,in_state  =>  out_AddRoundKeyR9,
                                   out_state => r10_sb);
    
     BytesShiftR10 : entity work.RowShifter(Behavioral)
                    port map (clk => clk,in_state => r10_sb,
                              out_state => r10_bs);
                                 
     AddRoundKeyR10: entity work.AddRoundKey(Behavioral)
                         port map ( clk => clk,in_state  => r10_bs,
                                    round_key => s_roundKeys(10),
                                    out_state => out_AddRoundKeyR10 ); 
    --!  FinalRound End !-- 
    
    -- conversion back to one dimensional array
    mat_to_vec : entity work.MatrixToVector(Behavioral)
                 port map (clk     => clk,
                           in_mat  => out_AddRoundKeyR10,
                           readVal => s_can_read,
                           out_vec => s_output);   
                           
    process(clk,s_can_read)
    begin
        if(s_can_read = '1') then
            cipherTextBlock <= s_output;
            valid <= '1';
        end if;
    end process;
    
end Behavioral;
