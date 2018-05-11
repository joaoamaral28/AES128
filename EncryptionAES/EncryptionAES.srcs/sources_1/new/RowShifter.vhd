library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.DataTypes.all;
use work.AuxFunctions.all;

-- Each byte of a row is cyclically shifted to the left by the index
-- of the row (zero-based). Therefore the first row suffers no changes, 
-- the bytes of the second row are shifted left one position, the bytes
-- of the third row are rotated two bytes and the ones from the third
-- row rotated three byte positions.

entity RowShifter is
    Port( in_state : in Matrix;
          out_state : out Matrix);
end RowShifter;

architecture Behavioral of RowShifter is
begin
    -- first row suffers no changes
    out_state(0)(0) <= in_state(0)(0);
    out_state(0)(1) <= in_state(0)(1);
    out_state(0)(2) <= in_state(0)(2);
    out_state(0)(3) <= in_state(0)(3);
    -- second row matrix bytes rotated left one position
    out_state(1)(0) <= in_state(1)(1);
    out_state(1)(1) <= in_state(1)(2);
    out_state(1)(2) <= in_state(1)(3);
    out_state(1)(3) <= in_state(1)(0);
    -- third row matrix bytes rotated left two positions
    out_state(2)(0) <= in_state(2)(2);
    out_state(2)(1) <= in_state(2)(3);
    out_state(2)(2) <= in_state(2)(0);
    out_state(2)(3) <= in_state(2)(1);
    -- fourth row matrix bytes rotated left three positions
    out_state(3)(0) <= in_state(3)(3);
    out_state(3)(1) <= in_state(3)(0);
    out_state(3)(2) <= in_state(3)(1);
    out_state(3)(3) <= in_state(3)(2);
    
end Behavioral;