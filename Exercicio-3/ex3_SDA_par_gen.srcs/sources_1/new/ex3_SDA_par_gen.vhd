----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.09.2020 23:35:36
-- Design Name: 
-- Module Name: ex3_SDA_par_gen - Behavioral
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

entity ex3_SDA_par_gen is
    generic (n : integer range 1 to 32);
    Port ( data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
           data_out : out STD_LOGIC_VECTOR (n downto 0));
end ex3_SDA_par_gen;

architecture Behavioral of ex3_SDA_par_gen is

    signal s_aux_data_in : std_logic := '0';
    
begin

    data_out(n downto 1) <= data_in;
    
    PARITY_GENERATOR: process(data_in)
    begin
        for i in 0 to n-1 loop
            s_aux_data_in <= s_aux_data_in xor data_in(i);
        end loop;
    end process;  
    
    data_out(0) <= s_aux_data_in;
    
end Behavioral;
