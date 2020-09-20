----------------------------------------------------------------------------------
-- Company: Universidade de Bras�lia - UnB
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 11.09.2020 23:10:52
-- Design Name: 
-- Module Name: tb_ex4_SDA_alarme - Behavioral
-- Project Name: SDA - Lista de exerc�cios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- Testbench do circuito referente ao 4� exerc�cio da lista de exerc�cios 1 de SDA.
--
-- Dependencies: 
-- 
-- ex4_SDA_alarme.vhd
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Declara��o de bibliotecas. NUMERIC_STD � utilizada para realizar opera��es aritm�ticas.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entidade: entradas e sa�das do sistema. Entidades de testbench em geral s�o vazias.
entity tb_ex4_SDA_alarme is
end tb_ex4_SDA_alarme;

-- Arquitetura: descri��o do funcionamento do sistema
architecture Behavioral of tb_ex4_SDA_alarme is

    -- Declarando o m�dulo ex4_SDA_alarme como componente para ser testado.
    component ex4_SDA_alarme is
        Port ( ign : in STD_LOGIC;
               driv : in STD_LOGIC;
               belt_d : in STD_LOGIC;
               pass : in STD_LOGIC;
               belt_p : in STD_LOGIC;
               alarme : out STD_LOGIC);
    end component ex4_SDA_alarme;

    -- Declara��o de sinais de teste:
    --
    -- Sinal de teste que se conecta � entrada IGN
    signal s_ign: std_logic := '0';
    
    -- Sinal de teste que se conecta � entrada DRIV
    signal s_driv: std_logic := '0';
    
    -- Sinal de teste que se conecta � entrada BELT_D
    signal s_belt_d: std_logic := '0';
    
    -- Sinal de teste que se conecta � entrada PASS
    signal s_pass: std_logic := '0';
    
    -- Sinal de teste que se conecta � entrada BELT_P
    signal s_belt_p: std_logic := '0';
    
    -- Sinal de teste que se conecta � sa�da ALARME
    signal s_alarme: std_logic := '0';
    
    -- Sinal de clock virtual para gera��o dos dados de est�mulo para as entradas
    signal s_data_clk : std_logic := '0';
    
    -- Sinal de contagem que serve de est�mulo para as entradas
    signal s_count : std_logic_vector (4 downto 0) := (others => '0');
    
begin

    -- Mapeamento das entradas e sa�das do m�dulo sendo testado - Design Under Test (UUT)
    UUT: ex4_SDA_alarme port map
    (
        ign => s_ign,
        driv => s_driv,
        belt_d => s_belt_d,
        pass => s_pass,
        belt_p => s_belt_p,
        alarme => s_alarme
    );
    
    -- Gera��o do sinal de clock virtual para est�mulos dos dados de entrada. Per�odo = 10ns.
    s_data_clk <= not s_data_clk after 5 ns;
    
    -- Processo de contagem que gera est�mulos para os sinais de entrada de teste. A cada
    -- sinal de subida do sinal de clock virtual o contador � incrementado em 1, e cada
    -- bit do sinal de contagem � atribuido a um sinal de teste.
    TB_DATA_GEN: process
    begin
        wait until s_data_clk = '1';
            s_count <= std_logic_vector(unsigned(s_count) + 1);
    end process;
    
    s_ign <= s_count(4);
    s_driv <= s_count(3);
    s_belt_d <= s_count(2);
    s_pass <= s_count(1);
    s_belt_p <= s_count(0);
    
end Behavioral;
