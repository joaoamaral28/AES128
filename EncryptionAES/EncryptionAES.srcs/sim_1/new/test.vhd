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
            
begin
                                           
    aes : entity work.AESalgorithm(Behavioral)
          port map (plainTextBlock => inputBlock,
                    cipherKey => cipherKey,
                    cipherTextBlock => cipherBlock );

end Structural;
