----------------------------------------------------------------------------------
-- Company: Universidade de Bras�lia - UnB
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 11.09.2020 23:08:04
-- Design Name: 
-- Module Name: ex4_SDA_alarme - Behavioral
-- Project Name: SDA - Lista de exerc�cios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- A figura a seguir apresenta um circuito l�gico combinacional que opera o alarme 
-- de um carro quando os bancos do motorista e/ou do passageiro est�o ocupados e 
-- os cintos de seguran�a n�o foram fechados no momento do arranque. O estado ativo
-- ALTO dos sinais DRIV e PASS indicam a presen�a do motorista e do passageiro, 
-- respectivamente, e s�o gerados atrav�s de interruptores acionados por press�o 
-- colocados nos bancos. O sinal IGN � ativo em ALTO, quando o carro liga a igni��o
-- (carro ligado). O sinal BELTD � ativo em BAIXO e indica que o cinto de seguran�a 
-- do motorista est� solto. O sinal BELTP � ativo em BAIXO e indica que o cinto de 
-- seguran�a do passageiro est� solto. O alarme do carro ser� ativado (BAIXO) cada 
-- vez que o carro esteja em marcha e qualquer um dos bancos da frente esteja ocupado
-- com o cinto de seguran�a destravado.
--
--
-- Verificou-se o seguinte comportamento inadequado do circuito: quando o banco do 
-- passageiro est� ocupado e n�o tem motorista no carro, o alarme ainda � ativado quando
-- o cinto do passageiro est� solto. Apresente uma modifica��o do circuito no intuito 
-- de ativar o alarme na condi��o do motorista estar presente.
--
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Declara��o de bibliotecas. NUMERIC_STD � necess�ria para a realiza��o de opera��es
-- aritm�ticas.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade: entradas e sa�das do sistema
entity ex4_SDA_alarme is
    Port ( 
    
            -- Entradas
            --
            -- IGN: igni��o do ve�culo. '0' = ve�culo desligado, '1' = ve�culo ligado.
            ign : in STD_LOGIC;
            
            -- Drive: indica presen�a de passageiro no banco do motorista. '0' = sem
            -- motorista, '1' = com motorista.
            driv : in STD_LOGIC;
            
            -- Belt_d: cinto do motorista. '0' = cinto fechado, '1' = cinto solto.
            belt_d : in STD_LOGIC;
            
            -- Pass: indica presen�a de passageiro no banco de carona da frente. '0' =
            -- sem passageiro, '1' = com passageiro.
            pass : in STD_LOGIC;
            
            -- Belt_p: cinto do passageiro. '0' = cinto fechado, '1' = cinto solto.
            belt_p : in STD_LOGIC;
            
            -- Sa�da
            --
            -- Alarme: o alarme � ativado em '0' quando o carro esteja em marcha e 
            -- qualquer um dos bancos da frente esteja ocupado com o cinto de seguran�a 
            -- destravado. '1' indica alarme desligado. 
            alarme : out STD_LOGIC);
end ex4_SDA_alarme;

-- Arquitetura: descri��o do funcionamento do sistema
architecture Behavioral of ex4_SDA_alarme is

begin
    
    -- A equa��o booleana original foi modificada para:
    --
    -- _____________________________________
    --               ______         ______ 
    -- IGN . DRIV . (BELT_D + (PASS.BELT_P))
    --
    -- Assim, retirando o sinal DRIV da compara��o com BELT_D na porta AND, ele se torna
    -- um sinal com maior peso na sa�da: somente se a igni��o do carro estiver ligada (IGN = '1')
    -- e houver motorista (DRIV = '1'), s�o realizadas as verifica��es de cinto do motorista
    -- e presen�a do passageiro, com o cinto colocado ou n�o. Isso corrige o problema apresentado
    -- no enunciado do exerc�cio.
    alarme <= not( (ign) and (driv) and ((not belt_d) or (pass and (not belt_p))));
    
end Behavioral;
