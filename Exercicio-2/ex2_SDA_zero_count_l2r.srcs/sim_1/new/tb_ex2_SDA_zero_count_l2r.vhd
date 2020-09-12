----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2020 01:15:33
-- Design Name: 
-- Module Name: tb_ex2_SDA_zero_count_l2r - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ex2_SDA_zero_count_l2r is
end tb_ex2_SDA_zero_count_l2r;

architecture Behavioral of tb_ex2_SDA_zero_count_l2r is

    component ex2_SDA_zero_count_l2r is
    generic ( n : integer range 1 to 32);
    Port ( data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
           zero_count_l2r_out : out STD_LOGIC_VECTOR (5 downto 0));
    end component ex2_SDA_zero_count_l2r;
    
    signal s_data_in : std_logic_vector (15 downto 0) := (others => '0');
    signal s_zero_count_l2r_out : std_logic_vector (5 downto 0) := (others => '0');
    
begin

    uut: ex2_SDA_zero_count_l2r 
    generic map ( n => 16 )
    port map
    (
        data_in => s_data_in,
        zero_count_l2r_out => s_zero_count_l2r_out
    );
    
    s_data_in <= "1000000000000000" after 10 ns, -- 16384 => 0
                 "0000000000000001" after 20 ns, -- 1 => 15
                 "0010010111000000" after 30 ns, -- 9664 => 2
                 "0000100101101100" after 40 ns, -- 2412 => 4
                 "0000000111000111" after 50 ns; -- 455 => 7
                 
end Behavioral;
