library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.DataTypes.all;

entity SubBytes is
    Port ( in_state : in Matrix;
           out_state: out Matrix);
end SubBytes;

architecture Behavioral of SubBytes is
    signal byte00, byte01, byte02, byte03 : Byte; 
    signal byte10, byte11, byte12, byte13 : Byte; 
    signal byte20, byte21, byte22, byte23 : Byte; 
    signal byte30, byte31, byte32, byte33 : Byte; 
    
    component SubBox is 
        port ( inByte : in Byte;
               subByte: out Byte);
    end component;

begin
    
    sbox_00 : SubBox port map (inByte => in_state(0)(0), subByte => byte00 );
    sbox_01 : SubBox port map (inByte => in_state(0)(1), subByte => byte01 );
    sbox_02 : SubBox port map (inByte => in_state(0)(2), subByte => byte02 );
    sbox_03 : SubBox port map (inByte => in_state(0)(3), subByte => byte03 );

    sbox_10 : SubBox port map (inByte => in_state(1)(0), subByte => byte10 );
    sbox_11 : SubBox port map (inByte => in_state(1)(1), subByte => byte11 );
    sbox_12 : SubBox port map (inByte => in_state(1)(2), subByte => byte12 );
    sbox_13 : SubBox port map (inByte => in_state(1)(3), subByte => byte13 );
    
    sbox_20 : SubBox port map (inByte => in_state(2)(0), subByte => byte20 );
    sbox_21 : SubBox port map (inByte => in_state(2)(1), subByte => byte21 );
    sbox_22 : SubBox port map (inByte => in_state(2)(2), subByte => byte22 );
    sbox_23 : SubBox port map (inByte => in_state(2)(3), subByte => byte23 );
    
    sbox_30 : SubBox port map (inByte => in_state(3)(0), subByte => byte30 );
    sbox_31 : SubBox port map (inByte => in_state(3)(1), subByte => byte31 );
    sbox_32 : SubBox port map (inByte => in_state(3)(2), subByte => byte32 );
    sbox_33 : SubBox port map (inByte => in_state(3)(3), subByte => byte33 );
    
    out_state(0)(0) <= byte00; 
    out_state(1)(0) <= byte01; 
    out_state(2)(0) <= byte02; 
    out_state(3)(0) <= byte03; 
    out_state(0)(1) <= byte10; 
    out_state(1)(1) <= byte11; 
    out_state(2)(1) <= byte12; 
    out_state(3)(1) <= byte13; 
    out_state(0)(2) <= byte20; 
    out_state(1)(2) <= byte21; 
    out_state(2)(2) <= byte22; 
    out_state(3)(2) <= byte23; 
    out_state(0)(3) <= byte30; 
    out_state(1)(3) <= byte31; 
    out_state(2)(3) <= byte32; 
    out_state(3)(3) <= byte33; 

end Behavioral;
