----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.09.2020 23:08:04
-- Design Name: 
-- Module Name: ex4_SDA_alarme - Behavioral
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

entity ex4_SDA_alarme is
    Port ( ign : in STD_LOGIC;
           drive : in STD_LOGIC;
           belt_d : in STD_LOGIC;
           pass : in STD_LOGIC;
           belt_p : in STD_LOGIC;
           alarme : out STD_LOGIC);
end ex4_SDA_alarme;

architecture Behavioral of ex4_SDA_alarme is

begin
    
    alarme <= not( (ign) and (drive) and ((not belt_d) or (pass and (not belt_p))));
    
end Behavioral;
