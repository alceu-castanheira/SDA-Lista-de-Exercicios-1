----------------------------------------------------------------------------------
-- Company: Universidade de Brasília - UnB
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 12.09.2020 01:15:33
-- Design Name: 
-- Module Name: tb_ex2_SDA_zero_count_l2r - Behavioral
-- Project Name: SDA - Lista de exercícios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- Testbench do circuito referente ao 2º exercício da lista de exercícios 1 de SDA.
--
-- Dependencies: 
-- 
-- ex2_SDA_zero_count_l2r.vhd
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Declaração de bibliotecas. A biblioteca math_real é necessária para a calcular
-- o tamanho da saída do circuito, que depende do tamanho da entrada.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;

-- Entidade: entradas e saídas do sistema. Entidades de testbench em geral são vazias.
entity tb_ex2_SDA_zero_count_l2r is
end tb_ex2_SDA_zero_count_l2r;

-- Arquitetura: descrição do funcionamento do sistema
architecture Behavioral of tb_ex2_SDA_zero_count_l2r is

    -- Declarando o módulo ex1_SDA_zero_count como componente para ser testado.
    component ex2_SDA_zero_count_l2r is
    generic ( n : integer range 1 to 16;
              p : integer range 1 to 5);
    Port ( data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
           zero_count_l2r_out : out STD_LOGIC_VECTOR (p-1 downto 0));
    end component ex2_SDA_zero_count_l2r;
    
    -- Declaração de constantes:
    --
    -- Constante com o tamanho da entrada de teste.
    constant C_INPUT_WIDTH : integer range 1 to 16 := 16;
    
    -- Constante com o tamanho da saída de teste, calculada com base no valor da constante de 
    -- entrada: tamanho da saída = log2(tamanho da entrada) arredondado para o inteiro mais 
    -- próximo.    
    constant C_OUTPUT_WIDTH : integer range 1 to 5 := integer(ceil(log2(real(C_INPUT_WIDTH))));

    -- Declaração de sinais de teste:
    --
    -- Sinal que se conecta à entrada do módulo a ser testado. Tamanho: C_INPUT_WIDTH bits.
    signal s_data_in : std_logic_vector (C_INPUT_WIDTH-1 downto 0) := (others => '0');
    
    -- Sinal que se conecta à saída do módulo a ser testado. Tamanho: C_OUTPUT_WIDTH bits.
    signal s_zero_count_l2r_out : std_logic_vector (C_OUTPUT_WIDTH downto 0) := (others => '0');
    
begin

    -- Mapeamento das entradas e saídas do módulo sendo testado - Design Under Test (UUT) 
    UUT: ex2_SDA_zero_count_l2r 
    
    -- Mapeando os parâmetros genéricos do módulo:
    --
    -- n: número de bits da entrada: C_INPUT_WIDTH bits
    -- p: número de bits da saída: C_OUTPUT_WIDTH + 1 bits    
    generic map (  n => C_INPUT_WIDTH, p => C_OUTPUT_WIDTH + 1 )
    
    -- Mapeando os pinos de entrada e saída, conectando-os aos seus respectivos sinais 
    -- de teste.    
    port map
    (
        data_in => s_data_in,
        zero_count_l2r_out => s_zero_count_l2r_out
    );
 
    -- Estímulo dos dados de entrada: Primeiro são testados os casos no qual a entrada é composta
    -- totalmente por zeros. Depois, o caso em que o primeiro bit da esquerda para a direita é 
    -- igual a '1'. Em seguida, o caso no qual o último bit é igual a '1'. Os 2 valores numéricos
    -- restantes foram escolhidos por meio de um gerador de números pseudoaleatórios variando 
    -- entre 0 e 2^C_INPUT_WIDTH-1.   
    s_data_in <= "0000000000000000" after 10 ns, -- 0 => 16 '0's
                 "1000000000000000" after 20 ns, -- 16384 => 0 '0's
                 "0000000000000001" after 30 ns, -- 1 => 15 '0's
                 "0010010111000000" after 40 ns, -- 9664 => 2 '0's
                 "0000000111000111" after 50 ns; -- 455 => 7 '0's
                 
end Behavioral;
