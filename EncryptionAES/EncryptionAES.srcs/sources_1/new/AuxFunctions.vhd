library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library work;
use work.DataTypes.all;

-- Package containing the auxiliary methods used 
package AuxFunctions is
    -- xor a given matrix with a given vector
    function matrix_vec_xor(
        in_mat : Matrix;
        in_vec : std_logic_vector(127 downto 0))
        return Matrix;
        
    -- xor two given matrixes
    function matrix_xor(
        in_mat1 : Matrix;
        in_mat2 : Matrix)
        return Matrix;
        
    -- converts matrix data type to a std_logic_vector 
    function matrix_to_vector(
        in_mat : Matrix)
        return std_logic_vector;
        
    -- converts vector std_logic_vector type to matrix
    function vector_to_matrix(
        in_vec : std_logic_vector)
        return Matrix;
    -- mutiply 4x4 matrix with 4x1 matrix (vector)
    function mult_mat_vec(
        in_mat : Matrix;
        in_vec : std_logic_vector(31 downto 0))
        return std_logic_vector;
end AuxFunctions;

package body AuxFunctions is
    function matrix_vec_xor(
        in_mat : Matrix;
        in_vec : std_logic_vector(127 downto 0))
        return Matrix is
        variable out_mat : Matrix;
        begin
            out_mat(0)(0) := in_mat(0)(0) xor in_vec(7 downto 0);
            out_mat(0)(1) := in_mat(0)(1) xor in_vec(15 downto 8);
            out_mat(0)(2) := in_mat(0)(2) xor in_vec(23 downto 16);
            out_mat(0)(3) := in_mat(0)(3) xor in_vec(31 downto 24);
            out_mat(1)(0) := in_mat(1)(0) xor in_vec(39 downto 32);
            out_mat(1)(1) := in_mat(1)(1) xor in_vec(47 downto 40);
            out_mat(1)(2) := in_mat(1)(2) xor in_vec(55 downto 48);
            out_mat(1)(3) := in_mat(1)(3) xor in_vec(63 downto 56);
            out_mat(2)(0) := in_mat(2)(0) xor in_vec(71 downto 64);
            out_mat(2)(1) := in_mat(2)(1) xor in_vec(79 downto 72);
            out_mat(2)(2) := in_mat(2)(2) xor in_vec(87 downto 80);
            out_mat(2)(3) := in_mat(2)(3) xor in_vec(95 downto 88);            
            out_mat(3)(0) := in_mat(3)(0) xor in_vec(103 downto 96);
            out_mat(3)(1) := in_mat(3)(1) xor in_vec(111 downto 104);
            out_mat(3)(2) := in_mat(3)(2) xor in_vec(119 downto 112);
            out_mat(3)(3) := in_mat(3)(3) xor in_vec(127 downto 120);            
            return out_mat;
        end matrix_vec_xor;
        
    function matrix_xor(
        in_mat1 : Matrix;
        in_mat2 : Matrix)
        return Matrix is
        variable out_mat : Matrix;
        begin
            out_mat(0)(0) := in_mat1(0)(0) xor in_mat2(0)(0);
            out_mat(0)(1) := in_mat1(0)(1) xor in_mat2(0)(1);
            out_mat(0)(2) := in_mat1(0)(2) xor in_mat2(0)(2);
            out_mat(0)(3) := in_mat1(0)(3) xor in_mat2(0)(3);
            
            out_mat(1)(0) := in_mat1(1)(0) xor in_mat2(1)(0);
            out_mat(1)(1) := in_mat1(1)(1) xor in_mat2(1)(1);
            out_mat(1)(2) := in_mat1(1)(2) xor in_mat2(1)(2);
            out_mat(1)(3) := in_mat1(1)(3) xor in_mat2(1)(3);
            
            out_mat(2)(0) := in_mat1(2)(0) xor in_mat2(2)(0);
            out_mat(2)(1) := in_mat1(2)(1) xor in_mat2(2)(1);
            out_mat(2)(2) := in_mat1(2)(2) xor in_mat2(2)(2);
            out_mat(2)(3) := in_mat1(2)(3) xor in_mat2(2)(3);   
                   
            out_mat(3)(0) := in_mat1(3)(0) xor in_mat2(3)(0);
            out_mat(3)(1) := in_mat1(3)(1) xor in_mat2(3)(1);
            out_mat(3)(2) := in_mat1(3)(2) xor in_mat2(3)(2);
            out_mat(3)(3) := in_mat1(3)(3) xor in_mat2(3)(3);
        return out_mat;
    end matrix_xor;
    
    function matrix_to_vector(
        in_mat : Matrix)
        return std_logic_vector is
        variable vector : std_logic_vector;
        begin
            vector(31 downto 0)   := in_mat(0)(3) & in_mat(0)(2) & in_mat(0)(1) & in_mat(0)(0);
            vector(63 downto 32)  := in_mat(1)(3) & in_mat(1)(2) & in_mat(1)(1) & in_mat(1)(0);
            vector(95 downto 64)  := in_mat(2)(3) & in_mat(2)(2) & in_mat(2)(1) & in_mat(2)(0);
            vector(127 downto 96) := in_mat(3)(3) & in_mat(3)(2) & in_mat(3)(1) & in_mat(3)(0);
        return vector;
    end matrix_to_vector;
    
    function vector_to_matrix(
        in_vec : std_logic_vector)
        return Matrix is
        variable mat : Matrix;
        begin
            mat(0)(0) := in_vec(7 downto 0);
            mat(0)(1) := in_vec(15 downto 8);
            mat(0)(2) := in_vec(23 downto 16);
            mat(0)(3) := in_vec(31 downto 24);
            
            mat(1)(0) := in_vec(39 downto 32);
            mat(1)(1) := in_vec(47 downto 40);
            mat(1)(2) := in_vec(55 downto 48);
            mat(1)(3) := in_vec(63 downto 56);
            
            mat(2)(0) := in_vec(71 downto 64);
            mat(2)(1) := in_vec(79 downto 72);
            mat(2)(2) := in_vec(87 downto 80);
            mat(2)(3) := in_vec(95 downto 88);   
                                 
            mat(3)(0) := in_vec(103 downto 96);
            mat(3)(1) := in_vec(111 downto 104);
            mat(3)(2) := in_vec(119 downto 112);
            mat(3)(3) := in_vec(127 downto 120);  
        return mat;
    end vector_to_matrix;
    
    function mult_mat_vec(
        in_mat : Matrix;
        in_vec : std_logic_vector(31 downto 0))
        return std_logic_vector is 
        variable out_mat : std_logic_vector;
        begin
            out_mat(31 downto 24) := std_logic_vector(
                                     (unsigned(in_vec(31 downto 24)) * 
                                     unsigned(std_logic_vector(in_mat(0)(0))))
                                     +
                                     (unsigned(in_vec(23 downto 16)) * 
                                     unsigned(std_logic_vector(in_mat(1)(0))))
                                     +
                                     (unsigned(in_vec(15 downto 8)) * 
                                     unsigned(std_logic_vector(in_mat(2)(0))))
                                     +
                                     (unsigned(in_vec(7 downto 0)) * 
                                     unsigned(std_logic_vector(in_mat(3)(0))))
                                     );
            out_mat(23 downto 16) := std_logic_vector(
                                     (unsigned(in_vec(31 downto 24)) * 
                                      unsigned(std_logic_vector(in_mat(0)(1))))
                                      +
                                      (unsigned(in_vec(23 downto 16)) * 
                                      unsigned(std_logic_vector(in_mat(1)(1))))
                                      +
                                      (unsigned(in_vec(15 downto 8)) * 
                                      unsigned(std_logic_vector(in_mat(2)(1))))
                                      +
                                      (unsigned(in_vec(7 downto 0)) * 
                                      unsigned(std_logic_vector(in_mat(3)(1))))
                                      );
            out_mat(16 downto 8) := std_logic_vector(
                                       (unsigned(in_vec(31 downto 24)) * 
                                        unsigned(std_logic_vector(in_mat(0)(2))))
                                        +
                                        (unsigned(in_vec(23 downto 16)) * 
                                        unsigned(std_logic_vector(in_mat(1)(2))))
                                        +
                                        (unsigned(in_vec(15 downto 8)) * 
                                        unsigned(std_logic_vector(in_mat(2)(2))))
                                        +
                                        (unsigned(in_vec(7 downto 0)) * 
                                        unsigned(std_logic_vector(in_mat(3)(2))))
                                        );
            out_mat(7 downto 0) := std_logic_vector(
                                       (unsigned(in_vec(31 downto 24)) * 
                                        unsigned(std_logic_vector(in_mat(0)(3))))
                                        +
                                        (unsigned(in_vec(23 downto 16)) * 
                                        unsigned(std_logic_vector(in_mat(1)(3))))
                                        +
                                        (unsigned(in_vec(15 downto 8)) * 
                                        unsigned(std_logic_vector(in_mat(2)(3))))
                                        +
                                        (unsigned(in_vec(7 downto 0)) * 
                                        unsigned(std_logic_vector(in_mat(3)(3))))
                                        );
        return out_mat;
    end mult_mat_vec;
end package body AuxFunctions;
