----------------------------------------------------------------------------------
-- Company: Universidade de Bras�lia
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 20.09.2020 00:04:00
-- Project Name: SDA - Lista de exerc�cios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- Arquivo top module que conecta 2� exerc�cio da lista de xerc�cios 1 de SDA
-- ao VIO IP core, permitindo testar o circuito no laborat�rio remoto.
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

-- Declara��o de bibliotecas. A biblioteca math_real � necess�ria para a calcular
-- o tamanho da sa�da do circuito, que depende do tamanho da entrada.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;

-- Entidade: entradas e sa�das do sistema
entity top_ex2_SDA_zero_count_l2r is

    -- Par�metros gen�ricos definidos pelo usu�rio: 
    -- n => n�mero de bits do dado de entrada
    -- p => n�mero de bits do dado de sa�da
    generic( n : integer range 1 to 16 := 16;
             p : integer range 1 to 5 := 5);
    Port ( 
            -- A entrada do circuito n�o aparece na entidade, pois � provida pelo
            -- VIO IP core.
            --
            -- Entrada de clk. O circuito ex2_SDA_zero_count_l2r � puramente combinacional,
            -- mas o VIO IP core precisa de uma entrada de clk.
            clk : in STD_LOGIC;
            
            -- Sa�da std_logic_vector de p-bits, sendo p o par�metro gen�rico definido
            -- pelo usu�rio
            led : out STD_LOGIC_VECTOR (p-1 downto 0)
          );
end top_ex2_SDA_zero_count_l2r;

-- Arquitetura: descri��o do funcionamento do sistema
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
    
    -- Declara��o de constantes:
    --
    -- Constante com o par�metro de tamanho de entrada do m�dulo.
    constant C_INPUT_WIDTH : integer range 1 to n := n;
    
    -- Constante com o par�metro de tamanho da sa�da do m�dulo, calculada com base no 
    -- valor da constante do par�metro de entrada: tamanho da sa�da = log2(tamanho da entrada) 
    -- arredondado para o inteiro mais pr�ximo.    
    constant C_OUTPUT_WIDTH : integer range 1 to p := integer(ceil(log2(real(C_INPUT_WIDTH))));
    
    -- Sinal de conex�o entre sa�da virtual de vio_0 e a entrada de ex2_SDA_zero_count_l2r
    signal s_data_in : std_logic_vector(C_INPUT_WIDTH-1 downto 0);
    
begin

    -- Realizando mapeamento do m�dulo ex1_SDA_zero_count
    ZERO_COUNT_L2R_MODULE: ex2_SDA_zero_count_l2r 
    generic map (n => C_INPUT_WIDTH, p => C_OUTPUT_WIDTH + 1)
    port map(
        data_in            => s_data_in,
        zero_count_l2r_out => led
    );
    
     -- Realizando mapeamento do m�dulo vio_0
    VIO_IP_CORE: vio_0
    port map(
        clk        => clk,
        probe_out0 => s_data_in
    );
       
end Behavioral;
