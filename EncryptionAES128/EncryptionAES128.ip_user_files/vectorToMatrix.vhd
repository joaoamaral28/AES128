library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.DataTypes.all;

entity vectorToMatrix is
    port (clk     : in std_logic;
          in_vec  : in std_logic_vector(127 downto 0);
          out_mat : out Matrix);
end vectorToMatrix;

architecture Behavioral of vectorToMatrix is
    signal mat : Matrix := ((X"00",X"00",X"00",X"00"),(X"00",X"00",X"00",X"00"),(X"00",X"00",X"00",X"00"),(X"00",X"00",X"00",X"00"));
begin
    process(clk)
    begin
        mat(0)(0) <= in_vec(127 downto 120);
        mat(1)(0) <= in_vec(119 downto 112);
        mat(2)(0) <= in_vec(111 downto 104);
        mat(3)(0) <= in_vec(103 downto 96);
            
        mat(0)(1) <= in_vec(95 downto 88);
        mat(1)(1) <= in_vec(87 downto 80);
        mat(2)(1) <= in_vec(79 downto 72);
        mat(3)(1) <= in_vec(71 downto 64);
        
        mat(0)(2) <= in_vec(63 downto 56);
        mat(1)(2) <= in_vec(55 downto 48);
        mat(2)(2) <= in_vec(47 downto 40);
        mat(3)(2) <= in_vec(39 downto 32);
        
        mat(0)(3) <= in_vec(31 downto 24);
        mat(1)(3) <= in_vec(23 downto 16);
        mat(2)(3) <= in_vec(15 downto 8);
        mat(3)(3) <= in_vec(7 downto 0);
        
        out_mat <= mat;
    end process;
end Behavioral;
