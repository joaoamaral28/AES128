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
    signal enKeyExpR1 : std_logic;
    signal out_initalAddRoundKey : Matrix;
    signal enRoundKeyR1 : std_logic;
    -- Round1 Signals
    signal r1_sb, r1_bs, r1_mc, out_AddRoundKeyR1 : Matrix;
    signal enByteSubR1,enByteShiftR1,enMixColumnsR1,enAddRoundKeyR1 : std_logic;
    -- Round2 Signals
    signal r2_sb, r2_bs, r2_mc, out_AddRoundKeyR2 : Matrix;
    signal enBytesSubstitutionR2, enBytesShiftR2, enMixColumnsR2, enAddRoundKeyR2 : std_logic;
    -- Round3 Signals
    signal r3_sb, r3_bs, r3_mc, out_AddRoundKeyR3 : Matrix;
    signal enBytesSubstitutionR3, enBytesShiftR3, enMixColumnsR3, enAddRoundKeyR3 : std_logic;
    -- Round4 Signals
    signal r4_sb, r4_bs, r4_mc, out_AddRoundKeyR4 : Matrix;
    signal enBytesSubstitutionR4, enBytesShiftR4, enMixColumnsR4, enAddRoundKeyR4 : std_logic;
    -- Round5 Signals
    signal r5_sb, r5_bs, r5_mc, out_AddRoundKeyR5 : Matrix;
    signal enBytesSubstitutionR5, enBytesShiftR5, enMixColumnsR5, enAddRoundKeyR5 : std_logic;
    -- Round6 Signals
    signal r6_sb, r6_bs, r6_mc, out_AddRoundKeyR6 : Matrix;
    signal enBytesSubstitutionR6, enBytesShiftR6, enMixColumnsR6, enAddRoundKeyR6 : std_logic;
    -- Round7 Signals
    signal r7_sb, r7_bs, r7_mc, out_AddRoundKeyR7 : Matrix;
    signal enBytesSubstitutionR7, enBytesShiftR7, enMixColumnsR7, enAddRoundKeyR7 : std_logic;
    -- Round8 Signals
    signal r8_sb, r8_bs, r8_mc, out_AddRoundKeyR8 : Matrix;
    signal enBytesSubstitutionR8, enBytesShiftR8, enMixColumnsR8, enAddRoundKeyR8 : std_logic;
    -- Round9 Signals
    signal r9_sb, r9_bs, r9_mc, out_AddRoundKeyR9 : Matrix;
    signal enBytesSubstitutionR9, enBytesShiftR9, enMixColumnsR9, enAddRoundKeyR9 : std_logic;
    -- FinalRound Signals
    signal r10_sb, r10_bs, out_AddRoundKeyR10 : Matrix;
    signal enBytesSubstitutionR10, enBytesShiftR10, enAddRoundKeyR10 : std_logic;
    
    signal enmat_to_vec : std_logic;
    signal s_output : std_logic_vector(127 downto 0);
    signal s_can_read : std_logic; 
   
    
begin
    -- Pre processing
    -- Convert plainTextBlock bits to Matrix data type
    vec_to_mat : entity work.vectorToMatrix(Behavioral)
                 port map (clk => clk,
                           enable => '1',
                           in_vec => plainTextBlock,
                           valid => enKeyExpR1,
                           out_mat => mat);       
    -- Round keys generation
    KeyExpansion : entity work.KeyExpansion(Behavioral)
                   port map (clk => clk,
                             enable => enKeyExpR1,
                             cipherKey => cipherKey,
                             valid => enRoundKeyR1,
                             roundKeys => s_roundKeys);
    -- Initial add round key
    InitialAddRoundKey: entity work.AddRoundKey(Behavioral)
                        port map ( clk => clk,
                                   enable => enRoundKeyR1,
                                   in_state  => mat,
                                   round_key => s_roundKeys(0),--cipherKey,
                                   valid => enByteSubR1,
                                   out_state => out_initalAddRoundKey );  
                                   
   --!  Round 1 Start !--
    BytesSubstitutionR1 : entity work.SubBytes(Behavioral)
                        port map (clk => clk,
                                  enable => enByteSubR1,
                                  in_state  =>  out_initalAddRoundKey,
                                  valid => enByteShiftR1,
                                  out_state => r1_sb);

    BytesShiftR1        : entity work.RowShifter(Behavioral)
                        port map (clk => clk,
                                  enable => enByteShiftR1,
                                  in_state => r1_sb,
                                  valid => enMixColumnsR1,
                                  out_state => r1_bs);

    MixColumnsR1 : entity work.MixColumns(Behavioral)
                   port map(clk => clk,
                            enable => enMixColumnsR1,
                            in_state => r1_bs,
                            valid => enAddRoundKeyR1,
                            out_state => r1_mc);
                            
    AddRoundKeyR1: entity work.AddRoundKey(Behavioral)
                        port map ( clk => clk,
                                   enable => enAddRoundKeyR1,
                                   in_state  => r1_mc,
                                   round_key => s_roundKeys(1),
                                   valid => enBytesSubstitutionR2,
                                   out_state => out_AddRoundKeyR1 ); 
    --!  Round 1 End !--
    
   --!  Round 2 Start !--
     BytesSubstitutionR2 : entity work.SubBytes(Behavioral)
                         port map (clk => clk,
                                   enable => enBytesSubstitutionR2,
                                   in_state  =>  out_AddRoundKeyR1,
                                   valid => enBytesShiftR2,
                                   out_state => r2_sb);
 
     BytesShiftR2 : entity work.RowShifter(Behavioral)
                    port map (clk => clk,
                              enable => enBytesShiftR2,
                              in_state => r2_sb,
                              valid => enMixColumnsR2,
                              out_state => r2_bs);
 
     MixColumnsR2 : entity work.MixColumns(Behavioral)
                    port map(clk => clk,
                             enable => enMixColumnsR2,
                             in_state => r2_bs,
                             valid => enAddRoundKeyR2,
                             out_state => r2_mc);
                             
     AddRoundKeyR2: entity work.AddRoundKey(Behavioral)
                         port map ( clk => clk,
                                    enable => enAddRoundKeyR2,
                                    in_state  => r2_mc,
                                    round_key => s_roundKeys(2),
                                    valid => enBytesSubstitutionR3,
                                    out_state => out_AddRoundKeyR2 ); 
    --!  Round 2 End !--
    --!  Round 3 Start !--
    BytesSubstitutionR3 : entity work.SubBytes(Behavioral)
                      port map (clk => clk,
                                enable => enBytesSubstitutionR3,
                                in_state  =>  out_AddRoundKeyR2,
                                valid => enBytesShiftR3,
                                out_state => r3_sb);
    
    BytesShiftR3 : entity work.RowShifter(Behavioral)
                 port map (clk => clk,
                           enable => enBytesShiftR3,
                           in_state => r3_sb,
                           valid => enMixColumnsR3,
                           out_state => r3_bs);
    
    MixColumnsR3 : entity work.MixColumns(Behavioral)
                 port map(clk => clk,
                          enable => enMixColumnsR3,
                          in_state => r3_bs,
                          valid => enAddRoundKeyR3,
                          out_state => r3_mc);
                          
    AddRoundKeyR3: entity work.AddRoundKey(Behavioral)
                      port map ( clk => clk,
                                 enable => enAddRoundKeyR3,
                                 in_state  => r3_mc,
                                 round_key => s_roundKeys(3),
                                 valid => enBytesSubstitutionR4,
                                 out_state => out_AddRoundKeyR3 ); 
    --!  Round 3 End !--    
    --!  Round 4 Start !--
    BytesSubstitutionR4 : entity work.SubBytes(Behavioral)
                       port map (clk => clk,
                                 enable => enBytesSubstitutionR4,
                                 in_state  =>  out_AddRoundKeyR3,
                                 valid => enBytesShiftR4,
                                 out_state => r4_sb);
    
    BytesShiftR4 : entity work.RowShifter(Behavioral)
                  port map (clk => clk,
                            enable => enBytesShiftR4,
                            in_state => r4_sb,
                            valid => enMixColumnsR4,
                            out_state => r4_bs);
    
    MixColumnsR4 : entity work.MixColumns(Behavioral)
                  port map(clk => clk,
                           enable => enMixColumnsR4,
                           in_state => r4_bs,
                           valid => enAddRoundKeyR4,
                           out_state => r4_mc);
                           
    AddRoundKeyR4: entity work.AddRoundKey(Behavioral)
                       port map (clk => clk,
                                 enable => enAddRoundKeyR4,
                                 in_state  => r4_mc,
                                 round_key => s_roundKeys(4),
                                 valid => enBytesSubstitutionR5,
                                 out_state => out_AddRoundKeyR4 ); 
    --!  Round 4 End !--     
    --!  Round 5 Start !--
    BytesSubstitutionR5 : entity work.SubBytes(Behavioral)
                      port map (clk => clk,
                                enable => enBytesSubstitutionR5,
                                in_state  =>  out_AddRoundKeyR4,
                                valid => enBytesShiftR5,
                                out_state => r5_sb);
    
    BytesShiftR5 : entity work.RowShifter(Behavioral)
                 port map (clk => clk,
                           enable => enBytesShiftR5,
                           in_state => r5_sb,
                           valid => enMixColumnsR5,
                           out_state => r5_bs);
    
    MixColumnsR5 : entity work.MixColumns(Behavioral)
                 port map(clk => clk,
                          enable => enMixColumnsR5,
                          in_state => r5_bs,
                          valid => enAddRoundKeyR5,
                          out_state => r5_mc);
                          
    AddRoundKeyR5: entity work.AddRoundKey(Behavioral)
                      port map ( clk => clk,
                                 enable => enAddRoundKeyR5,
                                 in_state  => r5_mc,
                                 round_key => s_roundKeys(5),
                                 valid => enBytesSubstitutionR6,
                                 out_state => out_AddRoundKeyR5 ); 
     --!  Round 5 End !-- 
    --!  Round 6 Start !--
    BytesSubstitutionR6 : entity work.SubBytes(Behavioral)
                       port map (clk => clk,
                                 enable => enBytesSubstitutionR6,
                                 in_state  =>  out_AddRoundKeyR5,
                                 valid => enBytesShiftR6,
                                 out_state => r6_sb);
    
    BytesShiftR6 : entity work.RowShifter(Behavioral)
                  port map (clk => clk,
                            enable => enBytesShiftR6,
                            in_state => r6_sb,
                            valid => enMixColumnsR6,
                            out_state => r6_bs);
    
    MixColumnsR6 : entity work.MixColumns(Behavioral)
                  port map(clk => clk,
                           enable => enMixColumnsR6,
                           in_state => r6_bs,
                           valid => enAddRoundKeyR6,
                           out_state => r6_mc);
                           
    AddRoundKeyR6: entity work.AddRoundKey(Behavioral)
                       port map ( clk => clk,
                                  enable => enAddRoundKeyR6,
                                  in_state  => r6_mc,
                                  round_key => s_roundKeys(6),
                                  valid => enBytesSubstitutionR7,
                                  out_state => out_AddRoundKeyR6 ); 
    --!  Round 6 End !-- 
    --!  Round 7 Start !--
    BytesSubstitutionR7 : entity work.SubBytes(Behavioral)
                          port map (clk => clk,
                                    enable => enBytesSubstitutionR7,
                                    in_state  =>  out_AddRoundKeyR6,
                                    valid => enBytesShiftR7,
                                    out_state => r7_sb);
    
    BytesShiftR7 : entity work.RowShifter(Behavioral)
                   port map (clk => clk,
                             enable  => enBytesShiftR7,
                             in_state => r7_sb,
                             valid => enMixColumnsR7,
                             out_state => r7_bs);
    
    MixColumnsR7 : entity work.MixColumns(Behavioral)
                   port map(clk => clk,
                            enable => enMixColumnsR7,
                            in_state => r7_bs,
                            valid => enAddRoundKeyR7,
                            out_state => r7_mc);
                         
    AddRoundKeyR7: entity work.AddRoundKey(Behavioral)
                   port map ( clk => clk,
                              enable => enAddRoundKeyR7,
                              in_state  => r7_mc,
                              round_key => s_roundKeys(7),
                              valid => enBytesSubstitutionR8,
                              out_state => out_AddRoundKeyR7 ); 
    --!  Round 7 End !-- 
    --!  Round 8 Start !--
     BytesSubstitutionR8 : entity work.SubBytes(Behavioral)
                           port map (clk => clk,
                                     enable => enBytesSubstitutionR8,
                                     in_state  =>  out_AddRoundKeyR7,
                                     valid => enBytesShiftR8,
                                     out_state => r8_sb);
    
     BytesShiftR8 : entity work.RowShifter(Behavioral)
                    port map (clk => clk,
                              enable => enBytesShiftR8,
                              in_state => r8_sb,
                              valid => enMixColumnsR8,
                              out_state => r8_bs);
    
     MixColumnsR8 : entity work.MixColumns(Behavioral)
                    port map(clk => clk,
                             enable => enMixColumnsR8,
                             in_state => r8_bs,
                             valid => enAddRoundKeyR8,
                             out_state => r8_mc);
                             
     AddRoundKeyR8: entity work.AddRoundKey(Behavioral)
                         port map (clk => clk, 
                                   enable => enAddRoundKeyR8,
                                   in_state  => r8_mc,
                                   round_key => s_roundKeys(8),
                                   valid => enBytesSubstitutionR9,
                                   out_state => out_AddRoundKeyR8 ); 
    --!  Round 8 End !-- 
    --!  Round 9 Start !--
     BytesSubstitutionR9 : entity work.SubBytes(Behavioral)
                         port map (clk => clk,
                                   enable => enBytesSubstitutionR9,
                                   in_state  =>  out_AddRoundKeyR8,
                                   valid => enBytesShiftR9,
                                   out_state => r9_sb);
    
     BytesShiftR9 : entity work.RowShifter(Behavioral)
                    port map (clk => clk,
                              enable => enBytesShiftR9,
                              in_state => r9_sb,
                              valid => enMixColumnsR9,
                              out_state => r9_bs);
    
     MixColumnsR9 : entity work.MixColumns(Behavioral)
                    port map(clk => clk,
                             enable => enMixColumnsR9,
                             in_state => r9_bs,
                             valid => enAddRoundKeyR9,
                             out_state => r9_mc);
                             
     AddRoundKeyR9: entity work.AddRoundKey(Behavioral)
                         port map ( clk => clk,
                                    enable => enAddRoundKeyR9,
                                    in_state  => r9_mc,
                                    round_key => s_roundKeys(9),
                                    valid => enBytesSubstitutionR10,
                                    out_state => out_AddRoundKeyR9 ); 
    --!  Round 9 End !-- 
    --!  FinalRound Start !--
     BytesSubstitutionR10 : entity work.SubBytes(Behavioral)
                         port map (clk => clk,
                                   enable => enBytesSubstitutionR10,
                                   in_state  =>  out_AddRoundKeyR9,
                                   valid => enBytesShiftR10,
                                   out_state => r10_sb);
    
     BytesShiftR10 : entity work.RowShifter(Behavioral)
                    port map (clk => clk,
                              enable => enBytesShiftR10,
                              in_state => r10_sb,
                              valid => enAddRoundKeyR10,
                              out_state => r10_bs);
                                 
     AddRoundKeyR10: entity work.AddRoundKey(Behavioral)
                         port map ( clk => clk,
                                    enable => enAddRoundKeyR10,
                                    in_state  => r10_bs,
                                    round_key => s_roundKeys(10),
                                    valid => enmat_to_vec,
                                    out_state => out_AddRoundKeyR10 ); 
    --!  FinalRound End !-- 
    
    -- conversion back to one dimensional array
    mat_to_vec : entity work.MatrixToVector(Behavioral)
                 port map (clk     => clk,
                           enable => enmat_to_vec,
                           in_mat  => out_AddRoundKeyR10,
                           valid => s_can_read,
                           out_vec => s_output);   
                           
--    process(s_can_read)
--    begin
--        if(s_can_read = '1') then
--            cipherTextBlock <= s_output;
--            valid <= '1';
--        end if;
--    end process;
    
    cipherTextBlock <= s_output;
    valid <= s_can_read;
    
end Behavioral;
