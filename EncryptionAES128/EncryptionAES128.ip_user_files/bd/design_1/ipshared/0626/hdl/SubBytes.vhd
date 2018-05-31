library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library work;
use work.DataTypes.all;

entity SubBytes is
    Port ( clk : in std_logic;
           enable : in std_logic;
           in_state : in Matrix;
           valid : out std_logic;
           out_state: out Matrix);
end SubBytes;

architecture Behavioral of SubBytes is
    signal byte00, byte01, byte02, byte03 : std_logic_vector(7 downto 0); 
    signal byte10, byte11, byte12, byte13 : std_logic_vector(7 downto 0); 
    signal byte20, byte21, byte22, byte23 : std_logic_vector(7 downto 0); 
    signal byte30, byte31, byte32, byte33 : std_logic_vector(7 downto 0); 
    
    signal index00, index01, index02, index03 : integer range 0 to 255;
    signal index10, index11, index12, index13 : integer range 0 to 255;
    signal index20, index21, index22, index23 : integer range 0 to 255;
    signal index30, index31, index32, index33 : integer range 0 to 255;
    
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
    
begin
    process(clk, enable)
    begin
    if(enable='1') then
    -- index of SBox calculation for all bytes of the state
    index00 <= (to_integer(unsigned(in_state(0)(0)(7 downto 4)))*16) + to_integer(unsigned(in_state(0)(0)(3 downto 0)));
    index10 <= (to_integer(unsigned(in_state(1)(0)(7 downto 4)))*16) + to_integer(unsigned(in_state(1)(0)(3 downto 0)));
    index20 <= (to_integer(unsigned(in_state(2)(0)(7 downto 4)))*16) + to_integer(unsigned(in_state(2)(0)(3 downto 0)));
    index30 <= (to_integer(unsigned(in_state(3)(0)(7 downto 4)))*16) + to_integer(unsigned(in_state(3)(0)(3 downto 0)));
   
    index01 <= (to_integer(unsigned(in_state(0)(1)(7 downto 4)))*16) + to_integer(unsigned(in_state(0)(1)(3 downto 0)));
    index11 <= (to_integer(unsigned(in_state(1)(1)(7 downto 4)))*16) + to_integer(unsigned(in_state(1)(1)(3 downto 0)));
    index21 <= (to_integer(unsigned(in_state(2)(1)(7 downto 4)))*16) + to_integer(unsigned(in_state(2)(1)(3 downto 0)));
    index31 <= (to_integer(unsigned(in_state(3)(1)(7 downto 4)))*16) + to_integer(unsigned(in_state(3)(1)(3 downto 0))); 
    
    index02 <= (to_integer(unsigned(in_state(0)(2)(7 downto 4)))*16) + to_integer(unsigned(in_state(0)(2)(3 downto 0)));
    index12 <= (to_integer(unsigned(in_state(1)(2)(7 downto 4)))*16) + to_integer(unsigned(in_state(1)(2)(3 downto 0)));
    index22 <= (to_integer(unsigned(in_state(2)(2)(7 downto 4)))*16) + to_integer(unsigned(in_state(2)(2)(3 downto 0)));
    index32 <= (to_integer(unsigned(in_state(3)(2)(7 downto 4)))*16) + to_integer(unsigned(in_state(3)(2)(3 downto 0))); 
    
    index03 <= (to_integer(unsigned(in_state(0)(3)(7 downto 4)))*16) + to_integer(unsigned(in_state(0)(3)(3 downto 0)));
    index13 <= (to_integer(unsigned(in_state(1)(3)(7 downto 4)))*16) + to_integer(unsigned(in_state(1)(3)(3 downto 0)));
    index23 <= (to_integer(unsigned(in_state(2)(3)(7 downto 4)))*16) + to_integer(unsigned(in_state(2)(3)(3 downto 0)));
    index33 <= (to_integer(unsigned(in_state(3)(3)(7 downto 4)))*16) + to_integer(unsigned(in_state(3)(3)(3 downto 0))); 
    
    out_state(0)(0) <= SubBoxMem(index00);
    out_state(1)(0) <= SubBoxMem(index10);
    out_state(2)(0) <= SubBoxMem(index20);
    out_state(3)(0) <= SubBoxMem(index30);

    out_state(0)(1) <= SubBoxMem(index01);
    out_state(1)(1) <= SubBoxMem(index11);
    out_state(2)(1) <= SubBoxMem(index21);
    out_state(3)(1) <= SubBoxMem(index31);   
    
    out_state(0)(2) <= SubBoxMem(index02);
    out_state(1)(2) <= SubBoxMem(index12);
    out_state(2)(2) <= SubBoxMem(index22);
    out_state(3)(2) <= SubBoxMem(index32);    
    
    out_state(0)(3) <= SubBoxMem(index03);
    out_state(1)(3) <= SubBoxMem(index13);
    out_state(2)(3) <= SubBoxMem(index23);
    out_state(3)(3) <= SubBoxMem(index33);    
    
    valid <= '1';
    end if;
    
    end process;
end Behavioral;
