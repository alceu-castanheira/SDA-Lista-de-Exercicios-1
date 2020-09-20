----------------------------------------------------------------------------------
-- Company: Universidade de Bras�lia
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 20.09.2020 00:52:35
-- Design Name: 
-- Module Name: top_ex3_SDA_par_gen - Behavioral
-- Project Name: SDA - Lista de exerc�cios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- Arquivo top module que conecta 3� exerc�cio da lista de xerc�cios 1 de SDA
-- ao VIO IP core, permitindo testar o circuito no laborat�rio remoto.
--
-- Dependencies: 
-- 
-- ex3_SDA_par_gen
-- vio_0
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Declara��o de bibliotecas.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade: entradas e sa�das do sistema
entity top_ex3_SDA_par_gen is

    -- Par�metros gen�ricos definidos pelo usu�rio: 
    -- n => n�mero de bits do dado de entrada
    generic( n : integer range 1 to 15 := 15);
    Port ( 
            -- A entrada do circuito n�o aparece na entidade, pois � provida pelo
            -- VIO IP core.
            --
            -- Entrada de clk. O circuito ex3_SDA_par_gen � puramente combinacional,
            -- mas o VIO IP core precisa de uma entrada de clk.
            clk : in STD_LOGIC;
            
            -- Sa�da std_logic_vector de n-bits, sendo n o par�metro gen�rico definido
            -- pelo usu�rio
            led : out STD_LOGIC_VECTOR (n downto 0)
          );
end top_ex3_SDA_par_gen;

-- Arquitetura: descri��o do funcionamento do sistema
architecture Behavioral of top_ex3_SDA_par_gen is

    -- Declarando ex3_SDA_par_gen como componente 
    component ex3_SDA_par_gen is    
        generic (n : integer range 1 to 15);
        Port (          
                data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
                data_out : out STD_LOGIC_VECTOR (n downto 0)
             );
    end component ex3_SDA_par_gen;
    
    -- Declarando VIO IP core como componente
    COMPONENT vio_0
    PORT (
            clk : IN STD_LOGIC;
            probe_out0 : OUT STD_LOGIC_VECTOR(14 DOWNTO 0)
    );
    END COMPONENT;

    -- Declara��o de constantes:
    --
    -- Constante com o par�metro de tamanho de entrada do m�dulo.
    constant C_INPUT_WIDTH : integer range 1 to n := n;  
    
    -- Sinal de conex�o entre sa�da virtual de vio_0 e a entrada de ex1_SDA_zero_count
    signal s_data_in : std_logic_vector(C_INPUT_WIDTH-1 downto 0);
              
begin

    -- Realizando mapeamento do m�dulo ex1_SDA_zero_count
    PARITY_GEN_MODULE: ex3_SDA_par_gen 
    generic map (n => C_INPUT_WIDTH)
    port map(
        data_in  => s_data_in,
        data_out => led
    );
 
    -- Realizando mapeamento do m�dulo vio_0
    VIO_IP_CORE: vio_0
    port map(
        clk        => clk,
        probe_out0 => s_data_in
    );
       
end Behavioral;
