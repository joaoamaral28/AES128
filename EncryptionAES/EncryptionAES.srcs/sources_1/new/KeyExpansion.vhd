library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity KeyExpansion is
    Port( cipherKey : in std_logic_vector(127 downto 0);
          roundKeys : out std_logic_vector(155 downto 0));
end KeyExpansion;

architecture Behavioral of KeyExpansion is
    type round_keys is array (0 to 30) of std_logic_vector(79 downto 0);
    signal expandedKey : std_logic_vector(1407 downto 0);
begin
    -- copy key into first 4 words of expanded key
    expandedKey(127 downto 0) <= cipherKey;
    begin
    
    
    end process;
    -- Each subsequent word w[i] depends on w[i-1] and w[i-4]
    -- For words whose positions are NOT multiple of 4 w[i] = w[i-4] ? w[i-1]
    
    --if( i mod 4 = 0)
    
   -- else
    --    w[i] = w[i-4] ? w[i-1]
    
    -- Otherwise w[i] = w[i-4] ? SubWord(RotWord(temp)) ? Rcon[i/4]
    
end Behavioral;
