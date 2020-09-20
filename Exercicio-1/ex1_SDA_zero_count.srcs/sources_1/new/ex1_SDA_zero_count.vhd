----------------------------------------------------------------------------------
-- Company: Universidade de Brasília - UnB
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 12.09.2020 00:22:15
-- Design Name: 
-- Module Name: ex1_SDA_zero_count - Behavioral
-- Project Name: SDA - Lista de exercícios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- Implemente uma função em VHDL que conte o número de '0's de uma palavra cujo 
-- tamanho é ajustável através de uma entrada genérica. O número de ‘0’s deve 
-- ser uma saída do circuito e seu tamanho também é um parâmetro genérico. A 
-- função deve ser chamada dentro de um processo.
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
use IEEE.NUMERIC_STD.ALL;

-- Entidade: entradas e saídas do sistema
entity ex1_SDA_zero_count is

    -- Parâmetros genéricos definidos pelo usuário: 
    -- n => número de bits do dado de entrada. Valor máximo: 16 (número máximo de
    -- switches no kit Basys 3)
    -- p => número de bits do dado de saída. Valor máximo: 5 (valor de bits
    -- necessário para implementar o maior valor em binário (16))
    generic( n : integer range 1 to 16 := 16;
             p : integer range 1 to 5 := 5);
    Port ( 
            -- Entrada std_logic_vector de n-bits, sendo n o parãmetro genérico definido
            -- pelo usuário
            data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
            
            -- Saída std_logic_vector de p-bits, sendo p o parâmetro genérico definido
            -- pelo usuário
            zero_count_out : out STD_LOGIC_VECTOR (p-1 downto 0)
          );
end ex1_SDA_zero_count;

-- Arquitetura: descrição do funcionamento do sistema
architecture Behavioral of ex1_SDA_zero_count is

    -- Função count_zeros: recebe como parâmetro de entrada (param_in) um
    -- vetor de n-bits e retorna o número de '0's presentes (v_zero_count).
    --
    function count_zeroes (param_in : std_logic_vector(n-1 downto 0))
    return std_logic_vector is
    
    -- v_zero_count: variável de p-1 bits que armazena o número de '0's no vetor de entrada.
    -- Por se tratar de uma variável, o valor é atualizado instanteamente.
    variable v_zero_count : std_logic_vector(p-1 downto 0) := (others => '0');
    begin
        
        -- Analisando todos os bits do vetor de entrada (de 0 a n-1).
        for i in 0 to n-1 loop
        
            -- Se o valor do bit atual for zero:
            if param_in(i) = '0' then
            
                -- Incremente a variável v_zero_count em 1.
                v_zero_count := std_logic_vector(unsigned(v_zero_count) + 1);
                
            -- Caso contrário:    
            else
                
                -- v_zero_count mantem o seu valor atual.                
                v_zero_count := v_zero_count;
            end if;
        end loop;
        
    -- Retornar a variável v_zero_count
    return v_zero_count;
    end;
    
    -- Declaração do sinal s_zero_count de p-1 bits, que armazena o resultado da
    -- função count_zeroes.
    signal s_zero_count : std_logic_vector(p-1 downto 0) := (others => '0');
    
begin

    -- Processo no qual declara-se a função count_zeroes. Notar a lista de 
    -- sensibilidade: o processo sempre é executado quando data_in muda de 
    -- valor
    COUNT_ZEROES_PROC: process(data_in)
    begin
    
        -- Armazenando o valor retornado pela função count_zeroes no sinal
        -- s_zero_count
        s_zero_count <= count_zeroes(data_in);
    end process;
    
    -- Atribuindo o sinal s_zero_count à saída zero_count_out
    zero_count_out <= s_zero_count;
    
end Behavioral;
