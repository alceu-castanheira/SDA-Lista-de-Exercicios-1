----------------------------------------------------------------------------------
-- Company: Universidade de Brasília
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 20.09.2020 00:04:00
-- Project Name: SDA - Lista de exercícios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- Arquivo top module que conecta 2º exercício da lista de xercícios 1 de SDA
-- ao VIO IP core, permitindo testar o circuito no laboratório remoto.
--
-- Dependencies: 
-- 
-- ex2_SDA_zero_count_l2r
-- vio_0
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

-- Entidade: entradas e saídas do sistema
entity top_ex2_SDA_zero_count_l2r is

    -- Parâmetros genéricos definidos pelo usuário: 
    -- n => número de bits do dado de entrada
    -- p => número de bits do dado de saída
    generic( n : integer range 1 to 16 := 16;
             p : integer range 1 to 5 := 5);
    Port ( 
            -- A entrada do circuito não aparece na entidade, pois é provida pelo
            -- VIO IP core.
            --
            -- Entrada de clk. O circuito ex2_SDA_zero_count_l2r é puramente combinacional,
            -- mas o VIO IP core precisa de uma entrada de clk.
            clk : in STD_LOGIC;
            
            -- Saída std_logic_vector de p-bits, sendo p o parâmetro genérico definido
            -- pelo usuário
            led : out STD_LOGIC_VECTOR (p-1 downto 0)
          );
end top_ex2_SDA_zero_count_l2r;

-- Arquitetura: descrição do funcionamento do sistema
architecture Behavioral of top_ex2_SDA_zero_count_l2r is

    -- Declarando ex2_SDA_zero_count_l2r como componente 
    component ex2_SDA_zero_count_l2r is
    generic( n : integer range 1 to 16;
             p : integer range 1 to 5);
    Port ( 
            data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
            zero_count_l2r_out : out STD_LOGIC_VECTOR (p-1 downto 0)
          );
    end component ex2_SDA_zero_count_l2r;
    
    -- Declarando VIO IP core como componente
    COMPONENT vio_0
    PORT (
            clk : IN STD_LOGIC;
            probe_out0 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
    END COMPONENT;
    
    -- Declaração de constantes:
    --
    -- Constante com o parâmetro de tamanho de entrada do módulo.
    constant C_INPUT_WIDTH : integer range 1 to n := n;
    
    -- Constante com o parâmetro de tamanho da saída do módulo, calculada com base no 
    -- valor da constante do parâmetro de entrada: tamanho da saída = log2(tamanho da entrada) 
    -- arredondado para o inteiro mais próximo.    
    constant C_OUTPUT_WIDTH : integer range 1 to p := integer(ceil(log2(real(C_INPUT_WIDTH))));
    
    -- Sinal de conexão entre saída virtual de vio_0 e a entrada de ex2_SDA_zero_count_l2r
    signal s_data_in : std_logic_vector(C_INPUT_WIDTH-1 downto 0);
    
begin

    -- Realizando mapeamento do módulo ex1_SDA_zero_count
    ZERO_COUNT_L2R_MODULE: ex2_SDA_zero_count_l2r 
    generic map (n => C_INPUT_WIDTH, p => C_OUTPUT_WIDTH + 1)
    port map(
        data_in            => s_data_in,
        zero_count_l2r_out => led
    );
    
     -- Realizando mapeamento do módulo vio_0
    VIO_IP_CORE: vio_0
    port map(
        clk        => clk,
        probe_out0 => s_data_in
    );
       
end Behavioral;
