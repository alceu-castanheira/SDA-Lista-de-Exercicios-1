----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.09.2020 23:10:52
-- Design Name: 
-- Module Name: tb_ex4_SDA_alarme - Behavioral
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

entity tb_ex4_SDA_alarme is
end tb_ex4_SDA_alarme;

architecture Behavioral of tb_ex4_SDA_alarme is

component ex4_SDA_alarme is
    Port ( ign : in STD_LOGIC;
           drive : in STD_LOGIC;
           belt_d : in STD_LOGIC;
           pass : in STD_LOGIC;
           belt_p : in STD_LOGIC;
           alarme : out STD_LOGIC);
end component ex4_SDA_alarme;

    signal s_ign: std_logic := '0';
    signal s_drive: std_logic := '0';
    signal s_belt_d: std_logic := '0';
    signal s_pass: std_logic := '0';
    signal s_belt_p: std_logic := '0';
    
    signal s_alarme: std_logic := '0';
    
    signal s_data_clk : std_logic := '0';
    signal s_count : std_logic_vector (4 downto 0) := (others => '0');
    
begin

    uut: ex4_SDA_alarme port map
    (
        ign => s_ign,
        drive => s_drive,
        belt_d => s_belt_d,
        pass => s_pass,
        belt_p => s_belt_p,
        alarme => s_alarme
    );
    
    s_data_clk <= not s_data_clk after 5 ns;
    
    TB_DATA_GEN: process
    begin
        wait until s_data_clk = '1';
            s_count <= std_logic_vector(unsigned(s_count) + 1);
    end process;
    
    s_ign <= s_count(4);
    s_drive <= s_count(3);
    s_belt_d <= s_count(2);
    s_pass <= s_count(1);
    s_belt_p <= s_count(0);
    
end Behavioral;
