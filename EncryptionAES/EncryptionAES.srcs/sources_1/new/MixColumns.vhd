library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library work;
use work.DataTypes.all;

-- Operation based on the column-by-column multiplication modulus (x^4)+1
-- in the finite field GF (2^8), looking at the columns of the state as polynomials 
-- of the Galois Field
entity MixColumns is
    Port ( in_state : in Matrix;
           out_state : out Matrix);
end MixColumns;

architecture Behavioral of MixColumns is
    signal s_out_state : Matrix;
    
    component mult_mat is 
        port ( in_mat1 : in Matrix;
               in_mat2 : in Matrix;
               out_mat: out Matrix);
    end component mult_mat;

begin
    -- mixing transformation matrix filling
--    out_state(0)(0) <= std_logic_vector(unsigned(mix_matrix(0)(0)) * unsigned(in_state(0)(0))) xor
--                       std_logic_vector(unsigned(mix_matrix(0)(1)) * unsigned(in_state(1)(0))) xor 
--                       std_logic_vector(unsigned(mix_matrix(0)(2)) * unsigned(in_state(2)(0))) xor
--                       std_logic_vector(unsigned(mix_matrix(0)(3)) * unsigned(in_state(3)(0)));
                       
--    out_state(0)(0) <= std_logic_vector(unsigned(mix_matrix(0)(0)) * unsigned(in_state(0)(0))) xor
--                       std_logic_vector(unsigned(mix_matrix(0)(1)) * unsigned(in_state(1)(0))) xor 
--                       std_logic_vector(unsigned(mix_matrix(0)(2)) * unsigned(in_state(2)(0))) xor
--                       std_logic_vector(unsigned(mix_matrix(0)(3)) * unsigned(in_state(3)(0)));
                       
                       
    mult_matrix : mult_mat
        port map( in_mat1 => mix_matrix,
                  in_mat2 => in_state,
                  out_mat => s_out_state);
                  
    out_state <= s_out_state;  

end Behavioral;