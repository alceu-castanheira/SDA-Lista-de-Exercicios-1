----------------------------------------------------------------------------------
-- Company: Universidade de Brasília - UnB
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 12.09.2020 00:56:58
-- Design Name: 
-- Module Name: ex2_SDA_zero_count_l2r - Behavioral
-- Project Name: SDA - Lista de exercícios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- Implemente uma função em VHDL que percorre um vetor de esquerda a direita e conta 
-- o número de '0's até encontrar o primeiro '1'. A palavra de entrada deve ter um 
-- tamanho ajustável através de uma entrada genérica. O número de '0's deve ser uma 
-- saída do circuito e seu tamanho também é um parâmetro genérico. A função deve ser 
-- chamada dentro de um processo.
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
entity ex2_SDA_zero_count_l2r is

    -- Parâmetros genéricos definidos pelo usuário: 
    -- n => número de bits do dado de entrada. Valor máximo: 16 (número máximo de
    -- switches no kit Basys 3)
    -- p => número de bits do dado de saída. Valor máximo: 5 (valor de bits
    -- necessário para implementar o maior valor em binário (16))
    generic ( n : integer range 1 to 16 := 16;
              p : integer range 1 to 5 := 5);
    Port ( 
            -- Entrada std_logic_vector de n-bits, sendo n o parãmetro genérico definido
            -- pelo usuário            
            data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
            
            -- Saída std_logic_vector de p-bits, sendo p o parâmetro genérico definido
            -- pelo usuário            
            zero_count_l2r_out : out STD_LOGIC_VECTOR (p-1 downto 0)
          );
end ex2_SDA_zero_count_l2r;

-- Arquitetura: descrição do funcionamento do sistema
architecture Behavioral of ex2_SDA_zero_count_l2r is

    -- Função count_zeros_l2r: recebe como parâmetro de entrada (param_in) um vetor de 
    -- n-bits e retorna o número de '0's encontrados no sentido da esquerda (bit mais 
    -- significativo) até a direita, parando ao encontrar o primeiro bit igual a '1'.
    function count_zeroes_l2r (param_in : std_logic_vector(n-1 downto 0))
    return std_logic_vector is
    
    -- v_zero_count: variável de p-1 bits que armazena o número de '0's no vetor de entrada,
    -- da esquerda para a direita, até encontrar o primeiro '1'. Por se tratar de uma variável, 
    -- o valor é atualizado instanteamente.    
    variable v_zero_count : std_logic_vector(p-1 downto 0) := (others => '0');
    
    -- v_one_flag: variável de 1 bit utilizada como flag, que indica que o primeiro '1' foi
    -- encontrado ao percorrer o vetor de entrada da esquerda para a direita.
    variable v_one_flag : std_logic := '0';
    begin
    
        -- Analisando todos os bits do vetor de entrada (de 0 a n-1).
        for i in 0 to n-1 loop
        
            -- Se a flag v_one_flag for igual a '1':
            if v_one_flag = '1' then
            
                -- v_zero_count mantém seu valor atual, pois o primeiro '1' já foi detectado.
                v_zero_count := v_zero_count;
                
            -- Caso contrário, se um bit igual a '0' for encontrado:
            elsif param_in(n-1-i) = '0' then
            
                -- v_zero_count é incrementado em 1.
                v_zero_count := std_logic_vector(unsigned(v_zero_count) + 1);
                
            -- Caso contrário, se um bit igual a '1' for encontrado:
            elsif param_in(n-1-i) = '1' then
            
                -- v_one_flag recebe '1'.
                v_one_flag := '1';
                
            -- Se nenhuma das condições acima for verdadeira:
            else
            
                -- Ambas as variáveis são mantidas em 0.
                v_one_flag := '0';
                v_zero_count := (others => '0');
            end if;
        end loop;
        
    -- Retornar a variável v_zero_count
    return v_zero_count;
    end;

    -- Declaração do sinal s_zero_count_out_l2r de p-1 bits, que armazena o resultado da
    -- função count_zeroes_l2r.    
    signal s_zero_count_out_l2r : std_logic_vector (p-1 downto 0) := (others => '0');
    
begin

    -- Processo no qual declara-se a função count_zeroes. Notar a lista de sensibilidade:
    -- o processo é executado sempre que data_in muda de valor.
    COUNT_ZEROES_L2R_PROC : process(data_in)
    begin
    
        -- Armazenando o valor retornado pela função count_zeroes_l2r no sinal
        -- s_zero_count_out_l2r    
        s_zero_count_out_l2r <= count_zeroes_l2r(data_in);
    end process;

    -- Atribuindo o sinal s_zero_count_out_l2r à saída zero_count_l2r_out
    zero_count_l2r_out <= s_zero_count_out_l2r;
                
end Behavioral;
