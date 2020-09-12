----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2020 00:35:47
-- Design Name: 
-- Module Name: tb_ex1_SDA_zero_count - Behavioral
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

entity tb_ex1_SDA_zero_count is
end tb_ex1_SDA_zero_count;

architecture Behavioral of tb_ex1_SDA_zero_count is

    component ex1_SDA_zero_count is
        generic( n : integer range 1 to 32);
        Port ( data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
               zero_count_out : out STD_LOGIC_VECTOR (5 downto 0));
    end component ex1_SDA_zero_count;
    
    signal s_data_in : std_logic_vector (15 downto 0) := (others => '0');
    signal s_zero_count_out : std_logic_vector (5 downto 0) := (others => '0');
    
begin

    uut: ex1_SDA_zero_count 
    generic map ( n => 16 )
    port map
    (
        data_in => s_data_in,
        zero_count_out => s_zero_count_out
    );
    
    s_data_in <= "1100101100111000" after 10 ns, -- 52024 => 8 '0's
                 "0100010010001110" after 20 ns, -- 17550 => 10 '0's
                 "0001111010010010" after 30 ns, -- 7826 => 9 '0's
                 "1000011111001110" after 40 ns, -- 34766 => 7 '0's
                 "0000000000000101" after 50 ns; -- 5 => 14 '0's
                 
end Behavioral;
