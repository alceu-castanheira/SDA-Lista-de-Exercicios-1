----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.09.2020 23:52:16
-- Design Name: 
-- Module Name: tb_ex3_SDA_par_gen - Behavioral
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

entity tb_ex3_SDA_par_gen is
end tb_ex3_SDA_par_gen;

architecture Behavioral of tb_ex3_SDA_par_gen is

    component ex3_SDA_par_gen is
        generic (n : integer range 1 to 32);
        Port ( data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
               data_out : out STD_LOGIC_VECTOR (n downto 0));
    end component ex3_SDA_par_gen;
    
    signal s_data_in : std_logic_vector (14 downto 0) := (others => '0');
    signal s_data_out : std_logic_vector (15 downto 0) := (others => '0');
    
begin

    uut: ex3_SDA_par_gen 
    generic map (n => 15)
    port map
    (
        data_in => s_data_in,
        data_out => s_data_out   
    );
    
    s_data_in <= "101010001000111" after 10 ns, -- 21575 => 7 '1's
                 "101101010100101" after 20 ns, -- 23205 => 8 '1's
                 "111000000010010" after 30 ns, -- 28690 => 5 '1's
                 "111001100111000" after 40 ns, -- 29496 => 8 '1's 
                 "101100000001000" after 50 ns; -- 22536 => 4 '1's
    
end Behavioral;
