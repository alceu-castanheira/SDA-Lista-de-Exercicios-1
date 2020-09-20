----------------------------------------------------------------------------------
-- Company: Universidade de Bras�lia - UnB
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 11.09.2020 23:52:16
-- Design Name: 
-- Module Name: tb_ex3_SDA_par_gen - Behavioral
-- Project Name: SDA - Lista de exerc�cios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- Testbench do circuito referente ao 3� exerc�cio da lista de exerc�cios 1 de SDA.
--
-- Dependencies: 
-- 
-- ex3_SDA_par_gen.vhd
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Declara��o de bibliotecas.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade: entradas e sa�das do sistema. Entidades de testbench em geral s�o vazias.
entity tb_ex3_SDA_par_gen is
end tb_ex3_SDA_par_gen;

-- Arquitetura: descri��o do funcionamento do sistema
architecture Behavioral of tb_ex3_SDA_par_gen is

 -- Declarando o m�dulo ex3_SDA_par_gen como componente para ser testado.
    component ex3_SDA_par_gen is
        generic (n : integer range 1 to 15);
        Port ( data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
               data_out : out STD_LOGIC_VECTOR (n downto 0));
    end component ex3_SDA_par_gen;
 
    -- Declara��o de constantes:
    --
    -- Constante com o tamanho da entrada de teste.
    constant C_INPUT_WIDTH : integer range 1 to 15 := 15; 
    
        -- Declara��o de sinais de teste:
    --
    -- Sinal que se conecta � entrada do m�dulo a ser testado. Tamanho: C_INPUT_WIDTH bits.  
    signal s_data_in : std_logic_vector (C_INPUT_WIDTH-1 downto 0) := (others => '0');
 
    -- Sinal que se conecta � sa�da do m�dulo a ser testado. Tamanho: C_OUTPUT_WIDTH bits.    
    signal s_data_out : std_logic_vector (C_INPUT_WIDTH downto 0) := (others => '0');
    
begin

    -- Mapeamento das entradas e sa�das do m�dulo sendo testado - Design Under Test (UUT) 
    UUT: ex3_SDA_par_gen
    
    -- Mapeando os par�metros gen�ricos do m�dulo:
    --
    -- n: n�mero de bits da entrada: C_INPUT_WIDTH bits     
    generic map (n => C_INPUT_WIDTH)
    
    -- Mapeando os pinos de entrada e sa�da, conectando-os aos seus respectivos sinais 
    -- de teste.    
    port map
    (
        data_in => s_data_in,
        data_out => s_data_out   
    );
 
    -- Est�mulo dos dados de entrada. Os 5 valores num�ricos foram escolhidos por 
    -- meio de um gerador de n�meros pseudoaleat�rios variando entre 0 e 
    -- 2^C_INPUT_WIDTH-1.   
    s_data_in <= "101010001000111" after 10 ns, -- 21575 => 7 '1's : bit de paridade => '1'
                 "101101010100101" after 20 ns, -- 23205 => 8 '1's : bit de paridade => '0'
                 "111000000010010" after 30 ns, -- 28690 => 5 '1's: bit de paridade => '1'
                 "111001100111000" after 40 ns, -- 29496 => 8 '1's: bit de paridade => '0'
                 "101100000001000" after 50 ns; -- 22536 => 4 '1's: bit de paridade => '0'
    
end Behavioral;
