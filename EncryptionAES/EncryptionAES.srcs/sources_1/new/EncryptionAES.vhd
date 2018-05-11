----! Sample inputs and outputs !-----
-- Key: "Thats my Kung Fu"
-- Key Hex(128 bits) : 54 68 61 74 73 20 6D 79 20 4B 75 6E 67 20 46 75
-- PlainText: "Two One Nine Two"
-- PlainTextHex (128 bits) : 54 77 6F 20 4F 6E 65 20 4E 69 6E 65 20 54 77 6F
-- cipherText : 29 C3 50 5F 57 14 20 F6 40 22 99 B3 1A 02 D7 3A
----!---------------------------!-----

-- Pseudo code of implementation
--    for(int i=0; i< n_blocks; i++)
--        text_block <= plainText((127+128*i) downto i*128);
--        output_block <= AESalgorithm(text_block, cipherKey, output_block);

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity EncryptionAES is
    Port ( plainText: in std_logic_vector;
           cipherKey : in std_logic_vector(127 downto 0);
           cipherText: out std_logic_vector);
end EncryptionAES;

architecture Behavioral of EncryptionAES is
    signal text_block : std_logic_vector(127 downto 0);
    signal out_block : std_logic_vector;
    signal out_total_block : std_logic_vector;
    signal modulus : integer;
    signal n_blocks : integer;
    signal n_padding_bits : natural;
    signal pad : std_logic_vector(127 downto 0) := (others => '0');
    signal padding_bits : std_logic_vector;
begin

    -- Divide plainText into multiple 128 bit blocks 
    modulus <= plainText'length mod 128; 
    n_blocks <= plainText'length / 128;
    
    process(n_blocks)
    begin
        -- block processing step
        --- each block of 128 bits is inputed into the algorithm
        --- returning the corresponding criptogram
        block_processing : 
        for i in 0 to n_blocks loop
            text_block <= plainText((127+128*i) downto i*128);
            
            AESalg : AESalgorithm(Behavioral)
                    port map ( input_block =>  text_block,
                               cipherKey => cipherKey,
                               output_block => out_block);
                               
            out_total_block <= out_block & out_total_block;
        end loop;
  
        -- finalization step. Padding with remaining bits      
        finalize:
        n_padding_bits <= 128 - modulus;
        padding_bits <= pad(n_padding_bits-1 downto 0);
        text_block <= padding_bits & plainText(plainText'length-1 downto (plainText'length-modulus));
        out_total_block <= out_block & out_total_block;
        
        cipherText <= out_total_block;
    end process;
   
end Behavioral;
