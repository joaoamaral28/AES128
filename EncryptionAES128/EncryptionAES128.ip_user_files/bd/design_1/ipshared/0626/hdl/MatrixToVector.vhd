library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.DataTypes.all;

entity MatrixToVector is
    Port ( clk    : in std_logic;
           enable : in std_logic;
           in_mat : in Matrix;
           valid : out std_logic;
           out_vec: out std_logic_vector(127 downto 0) );
end MatrixToVector;

architecture Behavioral of MatrixToVector is
begin
    process(clk, enable)
    begin
        if(enable='1') then
        out_vec(31 downto 0)   <= in_mat(0)(3) & in_mat(1)(3) & in_mat(2)(3) & in_mat(3)(3);
        out_vec(63 downto 32)  <= in_mat(0)(2) & in_mat(1)(2) & in_mat(2)(2) & in_mat(3)(2);
        out_vec(95 downto 64)  <= in_mat(0)(1) & in_mat(1)(1) & in_mat(2)(1) & in_mat(3)(1);
        out_vec(127 downto 96) <= in_mat(0)(0) & in_mat(1)(0) & in_mat(2)(0) & in_mat(3)(0); 
       
        valid <= '1';
        end if;
    end process;
    
end Behavioral;
