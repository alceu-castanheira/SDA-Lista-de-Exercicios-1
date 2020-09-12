----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2020 00:22:15
-- Design Name: 
-- Module Name: ex1_SDA_zero_count - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ex1_SDA_zero_count is
    generic( n : integer range 1 to 32 := 16);
    Port ( data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
           zero_count_out : out STD_LOGIC_VECTOR (5 downto 0));
end ex1_SDA_zero_count;

architecture Behavioral of ex1_SDA_zero_count is

    function count_zeroes (param_in : std_logic_vector(n-1 downto 0))
    return std_logic_vector is
    variable v_zero_count : std_logic_vector(5 downto 0) := (others => '0');
    begin
        for i in 0 to n-1 loop
            if param_in(i) = '0' then
                v_zero_count := std_logic_vector(unsigned(v_zero_count) + 1);
            else
                v_zero_count := v_zero_count;
            end if;
        end loop;
    return v_zero_count;
    end;
    
    signal s_zero_count : std_logic_vector(5 downto 0) := (others => '0');
    
begin

    COUNT_ZEROES_PROC: process(data_in)
    begin
        s_zero_count <= count_zeroes(data_in);
    end process;
    
    zero_count_out <= s_zero_count;
    
end Behavioral;
