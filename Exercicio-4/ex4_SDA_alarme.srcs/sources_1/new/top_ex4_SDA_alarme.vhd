----------------------------------------------------------------------------------
-- Company: Universidade de Brasília
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 20.09.2020 01:52:55
-- Design Name: 
-- Module Name: top_ex4_SDA_alarme - Behavioral
-- Project Name: SDA - Lista de exercícios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- Arquivo top module que conecta 4º exercício da lista de exercícios 1 de SDA
-- ao VIO IP core, permitindo testar o circuito no laboratório remoto.
--
-- Dependencies: 
-- 
-- ex4_SDA_alarme
-- vio_0
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Declaração de bibliotecas. 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade: entradas e saídas do sistema
entity top_ex4_SDA_alarme is
    Port ( 
            -- As entradas do circuito não aparecem na entidade, pois são providas pelo
            -- VIO IP core.
            --
            -- Entrada de clk. O circuito ex4_SDA_alarme é puramente combinacional,
            -- mas o VIO IP core precisa de uma entrada de clk.
            clk : in STD_LOGIC;
            
            -- Saída std_logic referente ao alarme, que será um led da Basys 3.
            led : out STD_LOGIC
          );
end top_ex4_SDA_alarme;

-- Arquitetura: descrição do funcionamento do sistema
architecture Behavioral of top_ex4_SDA_alarme is

    -- Declarando ex4_SDA_alarme como componente 
    component ex4_SDA_alarme is
        Port ( 
                ign : in STD_LOGIC;
                driv : in STD_LOGIC;
                belt_d : in STD_LOGIC;
                pass : in STD_LOGIC;
                belt_p : in STD_LOGIC; 
                alarme : out STD_LOGIC);
    end component ex4_SDA_alarme;

    -- Declarando VIO IP core como componente
    COMPONENT vio_0
    PORT (
            clk : IN STD_LOGIC;
            probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe_out1 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe_out2 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe_out3 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe_out4 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
    );
    END COMPONENT;
    
    -- Sinal de conexão entre saída virtual de vio_0 e a entrada IGN de ex4_SDA_alarme
    signal s_ign : std_logic := '0';
    
    -- Sinal de conexão entre saída virtual de vio_0 e a entrada DRIV de ex4_SDA_alarme
    signal s_driv : std_logic := '0';
    
    -- Sinal de conexão entre saída virtual de vio_0 e a entrada BELT_D de ex4_SDA_alarme
    signal s_belt_d : std_logic := '0';
    
    -- Sinal de conexão entre saída virtual de vio_0 e a entrada PASS de ex4_SDA_alarme
    signal s_pass : std_logic := '0';
    
    -- Sinal de conexão entre saída virtual de vio_0 e a entrada BELT_P de ex4_SDA_alarme
    signal s_belt_p : std_logic := '0';
    
begin

    -- Realizando mapeamento do módulo ex4_SDA_alarme
    ALARM_MODULE: ex4_SDA_alarme port map
    (
        ign => s_ign,
        driv => s_driv,
        belt_d => s_belt_d,
        pass => s_pass,
        belt_p => s_belt_p,
        alarme => led
    );

    -- Realizando mapeamento do módulo vio_0. Notar que como o VIO sempre coloca suas probes
    -- como std_logic_vector, mesmo no caso de 1 bit, é necessário atribuir os valores de 
    -- 1 bit ao bit menos significativo do probe, para evitar erros de sintaxe no Vivado.
    VIO_IP_CORE: vio_0
    port map(
        clk           => clk,
        probe_out0(0) => s_ign,
        probe_out1(0) => s_driv,
        probe_out2(0) => s_belt_d,
        probe_out3(0) => s_pass,
        probe_out4(0) => s_belt_p
    ); 
       
end Behavioral;
