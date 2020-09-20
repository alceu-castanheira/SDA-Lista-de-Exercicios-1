----------------------------------------------------------------------------------
-- Company: Universidade de Brasília - UnB
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 11.09.2020 23:08:04
-- Design Name: 
-- Module Name: ex4_SDA_alarme - Behavioral
-- Project Name: SDA - Lista de exercícios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- A figura a seguir apresenta um circuito lógico combinacional que opera o alarme 
-- de um carro quando os bancos do motorista e/ou do passageiro estão ocupados e 
-- os cintos de segurança não foram fechados no momento do arranque. O estado ativo
-- ALTO dos sinais DRIV e PASS indicam a presença do motorista e do passageiro, 
-- respectivamente, e são gerados através de interruptores acionados por pressão 
-- colocados nos bancos. O sinal IGN é ativo em ALTO, quando o carro liga a ignição
-- (carro ligado). O sinal BELTD é ativo em BAIXO e indica que o cinto de segurança 
-- do motorista está solto. O sinal BELTP é ativo em BAIXO e indica que o cinto de 
-- segurança do passageiro está solto. O alarme do carro será ativado (BAIXO) cada 
-- vez que o carro esteja em marcha e qualquer um dos bancos da frente esteja ocupado
-- com o cinto de segurança destravado.
--
--
-- Verificou-se o seguinte comportamento inadequado do circuito: quando o banco do 
-- passageiro está ocupado e não tem motorista no carro, o alarme ainda é ativado quando
-- o cinto do passageiro está solto. Apresente uma modificação do circuito no intuito 
-- de ativar o alarme na condição do motorista estar presente.
--
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Declaração de bibliotecas. NUMERIC_STD é necessária para a realização de operações
-- aritméticas.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade: entradas e saídas do sistema
entity ex4_SDA_alarme is
    Port ( 
    
            -- Entradas
            --
            -- IGN: ignição do veículo. '0' = veículo desligado, '1' = veículo ligado.
            ign : in STD_LOGIC;
            
            -- Drive: indica presença de passageiro no banco do motorista. '0' = sem
            -- motorista, '1' = com motorista.
            driv : in STD_LOGIC;
            
            -- Belt_d: cinto do motorista. '0' = cinto fechado, '1' = cinto solto.
            belt_d : in STD_LOGIC;
            
            -- Pass: indica presença de passageiro no banco de carona da frente. '0' =
            -- sem passageiro, '1' = com passageiro.
            pass : in STD_LOGIC;
            
            -- Belt_p: cinto do passageiro. '0' = cinto fechado, '1' = cinto solto.
            belt_p : in STD_LOGIC;
            
            -- Saída
            --
            -- Alarme: o alarme é ativado em '0' quando o carro esteja em marcha e 
            -- qualquer um dos bancos da frente esteja ocupado com o cinto de segurança 
            -- destravado. '1' indica alarme desligado. 
            alarme : out STD_LOGIC);
end ex4_SDA_alarme;

-- Arquitetura: descrição do funcionamento do sistema
architecture Behavioral of ex4_SDA_alarme is

begin
    
    -- A equação booleana original foi modificada para:
    --
    -- _____________________________________
    --               ______         ______ 
    -- IGN . DRIV . (BELT_D + (PASS.BELT_P))
    --
    -- Assim, retirando o sinal DRIV da comparação com BELT_D na porta AND, ele se torna
    -- um sinal com maior peso na saída: somente se a ignição do carro estiver ligada (IGN = '1')
    -- e houver motorista (DRIV = '1'), são realizadas as verificações de cinto do motorista
    -- e presença do passageiro, com o cinto colocado ou não. Isso corrige o problema apresentado
    -- no enunciado do exercício.
    alarme <= not( (ign) and (driv) and ((not belt_d) or (pass and (not belt_p))));
    
end Behavioral;
