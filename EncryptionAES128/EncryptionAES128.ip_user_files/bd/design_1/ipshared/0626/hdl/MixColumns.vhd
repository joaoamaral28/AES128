library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library work;
use work.DataTypes.all;

-- Operation based on the column-by-column multiplication in the finite
-- field GF (2^8), looking at the columns of the state as polynomials 
-- of the Galois Field. In order to ease the calculation Galois Multiplication
-- lookup tables where used for multiplication by x"02" and by x"03" of 
-- the input state columns
entity MixColumns is
    Port ( clk : in std_logic;
           enable : in std_logic;
           in_state : in Matrix;
           valid : out std_logic;
           out_state : out Matrix);
end MixColumns;

architecture Behavioral of MixColumns is
    
    type byte_array is array (0 to 255) of std_logic_vector(7 downto 0);
    -- Lookup table containing the multiplication by 3 results in the Galois Field GF(2^8)
    constant LUTx3 : byte_array := (
    X"00", X"03", X"06", X"05", X"0C", X"0F", X"0A", X"09", X"18", X"1B", X"1E", X"1D", X"14", X"17", X"12", X"11",
    X"30", X"33", X"36", X"35", X"3C", X"3F", X"3A", X"39", X"28", X"2B", X"2E", X"2D", X"24", X"27", X"22", X"21",
    X"60", X"63", X"66", X"65", X"6C", X"6F", X"6A", X"69", X"78", X"7B", X"7E", X"7D", X"74", X"77", X"72", X"71",
    X"50", X"53", X"56", X"55", X"5C", X"5F", X"5A", X"59", X"48", X"4B", X"4E", X"4D", X"44", X"47", X"42", X"41",
    X"C0", X"C3", X"C6", X"C5", X"CC", X"CF", X"CA", X"C9", X"D8", X"DB", X"DE", X"DD", X"D4", X"D7", X"D2", X"D1",
    X"F0", X"F3", X"F6", X"F5", X"FC", X"FF", X"FA", X"F9", X"E8", X"EB", X"EE", X"ED", X"E4", X"E7", X"E2", X"E1",
    X"A0", X"A3", X"A6", X"A5", X"AC", X"AF", X"AA", X"A9", X"B8", X"BB", X"BE", X"BD", X"B4", X"B7", X"B2", X"B1",
    X"90", X"93", X"96", X"95", X"9C", X"9F", X"9A", X"99", X"88", X"8B", X"8E", X"8D", X"84", X"87", X"82", X"81",
    X"9B", X"98", X"9D", X"9E", X"97", X"94", X"91", X"92", X"83", X"80", X"85", X"86", X"8F", X"8C", X"89", X"8A",
    X"AB", X"A8", X"AD", X"AE", X"A7", X"A4", X"A1", X"A2", X"B3", X"B0", X"B5", X"B6", X"BF", X"BC", X"B9", X"BA",
    X"FB", X"F8", X"FD", X"FE", X"F7", X"F4", X"F1", X"F2", X"E3", X"E0", X"E5", X"E6", X"EF", X"EC", X"E9", X"EA",
    X"CB", X"C8", X"CD", X"CE", X"C7", X"C4", X"C1", X"C2", X"D3", X"D0", X"D5", X"D6", X"DF", X"DC", X"D9", X"DA",
    X"5B", X"58", X"5D", X"5E", X"57", X"54", X"51", X"52", X"43", X"40", X"45", X"46", X"4F", X"4C", X"49", X"4A",
    X"6B", X"68", X"6D", X"6E", X"67", X"64", X"61", X"62", X"73", X"70", X"75", X"76", X"7F", X"7C", X"79", X"7A",
    X"3B", X"38", X"3D", X"3E", X"37", X"34", X"31", X"32", X"23", X"20", X"25", X"26", X"2F", X"2C", X"29", X"2A",
    X"0B", X"08", X"0D", X"0E", X"07", X"04", X"01", X"02", X"13", X"10", X"15", X"16", X"1F", X"1C", X"19", X"1A");

    -- Lookup table containing the multiplication by 2 results in the Galois Field GF(2^8)
    constant LUTx2 : byte_array := (
    X"00", X"02", X"04", X"06", X"08", X"0A", X"0C", X"0E", X"10", X"12", X"14", X"16", X"18", X"1A", X"1C", X"1E", 
    X"20", X"22", X"24", X"26", X"28", X"2A", X"2C", X"2E", X"30", X"32", X"34", X"36", X"38", X"3A", X"3C", X"3E", 
    X"40", X"42", X"44", X"46", X"48", X"4A", X"4C", X"4E", X"50", X"52", X"54", X"56", X"58", X"5A", X"5C", X"5E", 
    X"60", X"62", X"64", X"66", X"68", X"6A", X"6C", X"6E", X"70", X"72", X"74", X"76", X"78", X"7A", X"7C", X"7E", 
    X"80", X"82", X"84", X"86", X"88", X"8A", X"8C", X"8E", X"90", X"92", X"94", X"96", X"98", X"9A", X"9C", X"9E", 
    X"A0", X"A2", X"A4", X"A6", X"A8", X"AA", X"AC", X"AE", X"B0", X"B2", X"B4", X"B6", X"B8", X"BA", X"BC", X"BE", 
    X"C0", X"C2", X"C4", X"C6", X"C8", X"CA", X"CC", X"CE", X"D0", X"D2", X"D4", X"D6", X"D8", X"DA", X"DC", X"DE", 
    X"E0", X"E2", X"E4", X"E6", X"E8", X"EA", X"EC", X"EE", X"F0", X"F2", X"F4", X"F6", X"F8", X"FA", X"FC", X"FE", 
    X"1B", X"19", X"1F", X"1D", X"13", X"11", X"17", X"15", X"0B", X"09", X"0F", X"0D", X"03", X"01", X"07", X"05", 
    X"3B", X"39", X"3F", X"3D", X"33", X"31", X"37", X"35", X"2B", X"29", X"2F", X"2D", X"23", X"21", X"27", X"25", 
    X"5B", X"59", X"5F", X"5D", X"53", X"51", X"57", X"55", X"4B", X"49", X"4F", X"4D", X"43", X"41", X"47", X"45", 
    X"7B", X"79", X"7F", X"7D", X"73", X"71", X"77", X"75", X"6B", X"69", X"6F", X"6D", X"63", X"61", X"67", X"65", 
    X"9B", X"99", X"9F", X"9D", X"93", X"91", X"97", X"95", X"8B", X"89", X"8F", X"8D", X"83", X"81", X"87", X"85", 
    X"BB", X"B9", X"BF", X"BD", X"B3", X"B1", X"B7", X"B5", X"AB", X"A9", X"AF", X"AD", X"A3", X"A1", X"A7", X"A5", 
    X"DB", X"D9", X"DF", X"DD", X"D3", X"D1", X"D7", X"D5", X"CB", X"C9", X"CF", X"CD", X"C3", X"C1", X"C7", X"C5", 
    X"FB", X"F9", X"FF", X"FD", X"F3", X"F1", X"F7", X"F5", X"EB", X"E9", X"EF", X"ED", X"E3", X"E1", X"E7", X"E5");

    signal byte00_3, byte01_3, byte02_3, byte03_3 : std_logic_vector(7 downto 0); 
    signal byte10_3, byte11_3, byte12_3, byte13_3 : std_logic_vector(7 downto 0); 
    signal byte20_3, byte21_3, byte22_3, byte23_3 : std_logic_vector(7 downto 0); 
    signal byte30_3, byte31_3, byte32_3, byte33_3 : std_logic_vector(7 downto 0);
    
    signal byte00_2, byte01_2, byte02_2, byte03_2 : std_logic_vector(7 downto 0); 
    signal byte10_2, byte11_2, byte12_2, byte13_2 : std_logic_vector(7 downto 0); 
    signal byte20_2, byte21_2, byte22_2, byte23_2 : std_logic_vector(7 downto 0); 
    signal byte30_2, byte31_2, byte32_2, byte33_2 : std_logic_vector(7 downto 0);

    signal mixed_mat : Matrix;

begin
    process(clk, enable)
    begin
    if(enable='1') then
    -- multiplication result fetching for both x3 and x2 multiplication in GF(2^8)
    byte00_3 <= LUTx3(to_integer(unsigned(in_state(0)(0))));    byte00_2 <= LUTx2(to_integer(unsigned(in_state(0)(0))));
    byte10_3 <= LUTx3(to_integer(unsigned(in_state(1)(0))));    byte10_2 <= LUTx2(to_integer(unsigned(in_state(1)(0))));
    byte20_3 <= LUTx3(to_integer(unsigned(in_state(2)(0))));    byte20_2 <= LUTx2(to_integer(unsigned(in_state(2)(0))));
    byte30_3 <= LUTx3(to_integer(unsigned(in_state(3)(0))));    byte30_2 <= LUTx2(to_integer(unsigned(in_state(3)(0))));
    
    byte01_3 <= LUTx3(to_integer(unsigned(in_state(0)(1))));    byte01_2 <= LUTx2(to_integer(unsigned(in_state(0)(1))));
    byte11_3 <= LUTx3(to_integer(unsigned(in_state(1)(1))));    byte11_2 <= LUTx2(to_integer(unsigned(in_state(1)(1))));
    byte21_3 <= LUTx3(to_integer(unsigned(in_state(2)(1))));    byte21_2 <= LUTx2(to_integer(unsigned(in_state(2)(1))));
    byte31_3 <= LUTx3(to_integer(unsigned(in_state(3)(1))));    byte31_2 <= LUTx2(to_integer(unsigned(in_state(3)(1))));    
    
    byte02_3 <= LUTx3(to_integer(unsigned(in_state(0)(2))));    byte02_2 <= LUTx2(to_integer(unsigned(in_state(0)(2))));
    byte12_3 <= LUTx3(to_integer(unsigned(in_state(1)(2))));    byte12_2 <= LUTx2(to_integer(unsigned(in_state(1)(2))));
    byte22_3 <= LUTx3(to_integer(unsigned(in_state(2)(2))));    byte22_2 <= LUTx2(to_integer(unsigned(in_state(2)(2))));
    byte32_3 <= LUTx3(to_integer(unsigned(in_state(3)(2))));    byte32_2 <= LUTx2(to_integer(unsigned(in_state(3)(2))));  
    
    byte03_3 <= LUTx3(to_integer(unsigned(in_state(0)(3))));    byte03_2 <= LUTx2(to_integer(unsigned(in_state(0)(3))));
    byte13_3 <= LUTx3(to_integer(unsigned(in_state(1)(3))));    byte13_2 <= LUTx2(to_integer(unsigned(in_state(1)(3))));
    byte23_3 <= LUTx3(to_integer(unsigned(in_state(2)(3))));    byte23_2 <= LUTx2(to_integer(unsigned(in_state(2)(3))));
    byte33_3 <= LUTx3(to_integer(unsigned(in_state(3)(3))));    byte33_2 <= LUTx2(to_integer(unsigned(in_state(3)(3))));  
       
    -- first column calculation
    mixed_mat(0)(0) <= byte00_2 xor byte10_3 xor in_state(2)(0) xor in_state(3)(0);  
    mixed_mat(1)(0) <= in_state(0)(0) xor byte10_2 xor byte20_3 xor in_state(3)(0);  
    mixed_mat(2)(0) <= in_state(0)(0) xor in_state(1)(0) xor byte20_2 xor byte30_3;  
    mixed_mat(3)(0) <= byte00_3 xor in_state(1)(0) xor in_state(2)(0) xor byte30_2;      
    
    -- second column calculation
    mixed_mat(0)(1) <= byte01_2 xor byte11_3 xor in_state(2)(1) xor in_state(3)(1);  
    mixed_mat(1)(1) <= in_state(0)(1) xor byte11_2 xor byte21_3 xor in_state(3)(1);  
    mixed_mat(2)(1) <= in_state(0)(1) xor in_state(1)(1) xor byte21_2 xor byte31_3;  
    mixed_mat(3)(1) <= byte01_3 xor in_state(1)(1) xor in_state(2)(1) xor byte31_2; 
    
    -- third column calculation
    mixed_mat(0)(2) <= byte02_2 xor byte12_3 xor in_state(2)(2) xor in_state(3)(2);  
    mixed_mat(1)(2) <= in_state(0)(2) xor byte12_2 xor byte22_3 xor in_state(3)(2);  
    mixed_mat(2)(2) <= in_state(0)(2) xor in_state(1)(2) xor byte22_2 xor byte32_3;  
    mixed_mat(3)(2) <= byte02_3 xor in_state(1)(2) xor in_state(2)(2) xor byte32_2; 
    
    -- fourth column calculation
    mixed_mat(0)(3) <= byte03_2 xor byte13_3 xor in_state(2)(3) xor in_state(3)(3);  
    mixed_mat(1)(3) <= in_state(0)(3) xor byte13_2 xor byte23_3 xor in_state(3)(3);  
    mixed_mat(2)(3) <= in_state(0)(3) xor in_state(1)(3) xor byte23_2 xor byte33_3;  
    mixed_mat(3)(3) <= byte03_3 xor in_state(1)(3) xor in_state(2)(3) xor byte33_2;                                 
        
    out_state <= mixed_mat;
    valid <= '1';
    
    end if;
    end process;

end Behavioral;