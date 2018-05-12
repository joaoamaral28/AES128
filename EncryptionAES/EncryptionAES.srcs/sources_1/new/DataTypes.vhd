library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Package containing the data types
package DataTypes is
    subtype Byte is std_logic_vector(7 downto 0);
    type FullWord is array (0 to 3) of Byte;
    type Matrix is array (0 to 3) of FullWord;
    -- default matrix used in the MixColumns operation
    constant mix_matrix : Matrix := ( ("00000010","00000011","00000001","00000001"),
                                    (  "00000001","00000010","00000011","00000001"),
                                    (  "00000001","00000001","00000010","00000011"),
                                    (  "00000011","00000001","00000001","00000010") );
end DataTypes;