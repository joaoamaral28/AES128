library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library work;
use work.DataTypes.all;

-- Rijndael key schedule method to create keys word by word to be 
-- used for each round of the  algorithm, derivated from the initial cipher key
entity KeyExpansion is
    Port( clk : in std_logic;
          enable : in std_logic;
          cipherKey : in std_logic_vector(127 downto 0);
          valid  : out std_logic;
          roundKeys : out roundKeys);
end KeyExpansion;

architecture Behavioral of KeyExpansion is

    type byte_array is array (0 to 255) of std_logic_vector(7 downto 0); 
    constant SubBoxMem : byte_array := (
    X"63", X"7C", X"77", X"7B", X"F2", X"6B", X"6F", X"C5", X"30", X"01", X"67", X"2B", X"FE", X"D7", X"AB", X"76",
    X"CA", X"82", X"C9", X"7D", X"FA", X"59", X"47", X"F0", X"AD", X"D4", X"A2", X"AF", X"9C", X"A4", X"72", X"C0",
    X"B7", X"FD", X"93", X"26", X"36", X"3F", X"F7", X"CC", X"34", X"A5", X"E5", X"F1", X"71", X"D8", X"31", X"15",
    X"04", X"C7", X"23", X"C3", X"18", X"96", X"05", X"9A", X"07", X"12", X"80", X"E2", X"EB", X"27", X"B2", X"75",
    X"09", X"83", X"2C", X"1A", X"1B", X"6E", X"5A", X"A0", X"52", X"3B", X"D6", X"B3", X"29", X"E3", X"2F", X"84",
    X"53", X"D1", X"00", X"ED", X"20", X"FC", X"B1", X"5B", X"6A", X"CB", X"BE", X"39", X"4A", X"4C", X"58", X"CF",
    X"D0", X"EF", X"AA", X"FB", X"43", X"4D", X"33", X"85", X"45", X"F9", X"02", X"7F", X"50", X"3C", X"9F", X"A8",
    X"51", X"A3", X"40", X"8F", X"92", X"9D", X"38", X"F5", X"BC", X"B6", X"DA", X"21", X"10", X"FF", X"F3", X"D2",
    X"CD", X"0C", X"13", X"EC", X"5F", X"97", X"44", X"17", X"C4", X"A7", X"7E", X"3D", X"64", X"5D", X"19", X"73",
    X"60", X"81", X"4F", X"DC", X"22", X"2A", X"90", X"88", X"46", X"EE", X"B8", X"14", X"DE", X"5E", X"0B", X"DB",
    X"E0", X"32", X"3A", X"0A", X"49", X"06", X"24", X"5C", X"C2", X"D3", X"AC", X"62", X"91", X"95", X"E4", X"79",
    X"E7", X"C8", X"37", X"6D", X"8D", X"D5", X"AE", X"A9", X"6C", X"56", X"F4", X"EA", X"65", X"7A", X"AE", X"08",
    X"BA", X"78", X"25", X"2E", X"1C", X"A6", X"B4", X"C6", X"E8", X"DD", X"74", X"1F", X"4B", X"BD", X"8B", X"8A",
    X"70", X"3E", X"B5", X"66", X"48", X"03", X"F6", X"0E", X"61", X"35", X"57", X"B9", X"86", X"C1", X"1D", X"9E",
    X"E1", X"F8", X"98", X"11", X"69", X"D9", X"8E", X"94", X"9B", X"1E", X"87", X"E9", X"CE", X"55", X"28", X"DF",
    X"8C", X"A1", X"89", X"0D", X"BF", X"E6", X"42", X"68", X"41", X"99", X"2D", X"0F", X"B0", X"54", X"BB", X"16");

    -- constant array value used in the KeyExpansion operation that contains
    -- the values given by [x^(i-1),{00},{00},{00} ], x^(i-1) being 
    -- the powers of x in the field GF(2^8)
    type rconArray is array (0 to 9) of std_logic_vector(7 downto 0);
    -- round constant 
    constant rcon : rconArray := ( X"01", X"02", X"04", X"08", X"10",
                                   X"20", X"40", X"80", X"1B", X"36");
    type expandedKeyWordArray is array (0 to 43) of std_logic_vector(31 downto 0);    
    --signal expandedKey : expandedKeyWordArray := (others => X"00000000");
    --signal tmpWord : std_logic_vector(31 downto 0);
    --signal tmpIdx : integer range 0 to 43; 
    --signal rconIdx: integer range 0 to 9 := 0;
    --signal rotWord : std_logic_vector(31 downto 0);
    --signal subWord : std_logic_vector(31 downto 0);
    --signal index0, index1, index2, index3 : integer range 0 to 255;
    --signal subWordRcon : std_logic_vector(31 downto 0);
    --signal auxWord : std_logic_vector(31 downto 0);
    --signal auxIdx : integer range 0 to 43;
begin
    process(clk, enable)
    
    variable expandedKey : expandedKeyWordArray := (others => X"00000000");
    variable tmpWord : std_logic_vector(31 downto 0);
    variable rotWord : std_logic_vector(31 downto 0);
    variable subWord : std_logic_vector(31 downto 0);
    variable subWordRcon : std_logic_vector(31 downto 0);
    variable auxWord : std_logic_vector(31 downto 0);
    variable tmpIdx : integer range 0 to 43; 
    variable rconIdx: integer range 0 to 9 := 0;
    variable index0, index1, index2, index3 : integer range 0 to 255;
    variable auxIdx : integer range 0 to 43;
    
    begin
    if(enable='1') then
 
    -- first 4 words of the expanded key is equal to the cipher key
    expandedKey(0) := cipherKey(127 downto 96); -- w0
    expandedKey(1) := cipherKey(95 downto 64);  -- w1
    expandedKey(2) := cipherKey(63 downto 32);  -- w2
    expandedKey(3) := cipherKey(31 downto 0);   -- w3
    
    keys_generation: -- generate the remaining keys word by word
    for i in 4 to expandedKeyWordArray'length-1 loop
        tmpIdx := i - 1; 
        tmpWord := expandedKey(tmpIdx);
        if(i mod 4 = 0) then
            -- Rotation of word w[i-1]
            rotWord := tmpWord(23 downto 0) & tmpWord(31 downto 24);
            -- index calculation  from rotWord bytes
            index0 := (to_integer(unsigned(rotWord(31 downto 28)))*16) + to_integer(unsigned(rotWord(27 downto 24)));
            index1 := (to_integer(unsigned(rotWord(23 downto 20)))*16) + to_integer(unsigned(rotWord(19 downto 16)));
            index2 := (to_integer(unsigned(rotWord(15 downto 12)))*16) + to_integer(unsigned(rotWord(11 downto 8)));
            index3 := (to_integer(unsigned(rotWord(7 downto 4)))*16)   + to_integer(unsigned(rotWord(3 downto 0)));
            -- SubBytes of rotWord
            rconIdx := (i / 4) - 1;
            subWord := SubBoxMem(index0) & SubBoxMem(index1) & SubBoxMem(index2) & SubBoxMem(index3);
            subWordRcon := (SubBoxMem(index0) xor rcon(rconIdx)) & SubBoxMem(index1) & SubBoxMem(index2) & SubBoxMem(index3);  
            auxIdx := i - 4;
            auxWord := expandedKey(auxIdx);
            expandedKey(i) := auxWord xor subWordRcon; 
        else
            auxIdx := i - 4;
            auxWord := expandedKey(auxIdx);
            expandedKey(i) := auxWord xor tmpWord;            
        end if;

    end loop; 
       
    roundKeys(0) <= expandedKey(0) & expandedKey(1) & expandedKey(2) & expandedKey(3);
    roundKeys(1) <= expandedKey(4) & expandedKey(5) & expandedKey(6) & expandedKey(7);
    roundKeys(2) <= expandedKey(8) & expandedKey(9) & expandedKey(10) & expandedKey(11);
    roundKeys(3) <= expandedKey(12) & expandedKey(13) & expandedKey(14) & expandedKey(15);
    roundKeys(4) <= expandedKey(16) & expandedKey(17) & expandedKey(18) & expandedKey(19);
    roundKeys(5) <= expandedKey(20) & expandedKey(21) & expandedKey(22) & expandedKey(23);
    roundKeys(6) <= expandedKey(24) & expandedKey(25) & expandedKey(26) & expandedKey(27);
    roundKeys(7) <= expandedKey(28) & expandedKey(29) & expandedKey(30) & expandedKey(31);
    roundKeys(8) <= expandedKey(32) & expandedKey(33) & expandedKey(34) & expandedKey(35);
    roundKeys(9) <= expandedKey(36) & expandedKey(37) & expandedKey(38) & expandedKey(39);
    roundKeys(10)<= expandedKey(40) & expandedKey(41) & expandedKey(42) & expandedKey(43);
    
    valid <= '1';
    
    end if;
    end process;
    
end Behavioral;
