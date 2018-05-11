library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Package containing the data types
package DataTypes is
    subtype Byte is std_logic_vector(7 downto 0);
    type FullWord is array (0 to 3) of Byte;
    type Matrix is array (0 to 3) of FullWord;
end DataTypes;