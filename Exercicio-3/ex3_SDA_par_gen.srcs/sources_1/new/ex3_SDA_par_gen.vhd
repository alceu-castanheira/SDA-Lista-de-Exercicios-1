----------------------------------------------------------------------------------
-- Company: Universidade de Brasília - UnB
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 11.09.2020 23:35:36
-- Design Name: 
-- Module Name: ex3_SDA_par_gen - Behavioral
-- Project Name: SDA - Lista de exercícios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- Projete e implemente um circuito gerador de paridade par de uma entrada de N bits,
-- sendo N um parâmetro de entrada genérico. A saída de N+1 bits deve conter um número 
-- par de '1's.
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
entity ex3_SDA_par_gen is

    -- Parâmetros genéricos definidos pelo usuário: 
    -- n => número de bits do dado de entrada. Valor máximo: 15 (número máximo de
    -- switches no kit Basys 3 - 1, por conta do bit de paridade)
    generic (n : integer range 1 to 15 := 15);
    Port (
            -- Entrada std_logic_vector de n-bits, sendo n o parãmetro genérico definido
            -- pelo usuário             
            data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
            
            -- Saída std_logic_vector do gerador de paridade. Tamanho de n bits, um a 
            -- mais do que a entrada, por conta do bit de paridade par.
            data_out : out STD_LOGIC_VECTOR (n downto 0)
         );
end ex3_SDA_par_gen;

-- Arquitetura: descrição do funcionamento do sistema
architecture Behavioral of ex3_SDA_par_gen is
    
begin

    -- Copiando a entrada para os bits mais significativos da saída.
    data_out(n downto 1) <= data_in;
    
    -- Processo que implementa o gerador de paridade par. Notar a lista de sensibilidade:
    -- sempre que o valor de data_in mudar, o processo é executado.
    PARITY_GENERATOR: process(data_in)
    
    -- Variável v_parity_bit que armazena o bit de paridade par.
    variable v_parity_bit : std_logic := '0';
    begin
        
        -- Percorrendo todos os bits do vetor de entrada, de 0 a n-1.
        for i in 0 to n-1 loop
        
            -- Um circuito gerador de paridade par é composto por operações XOR entre todos
            -- os bits que compõem a entrada: bit_0 XOR bit_1 XOR bit_2.... XOR bit_(n-1).
            -- Assim, v_parity_bit recebe o valor de v_parity_bit (que na primeira iteração
            -- vale '0') XOR o bit atual. Na primeira iteração, v_parity irá armazenar o bit
            -- atual (menos significativo), mas a partir das próximas iterações do loop irá
            -- armazenar o valor da operação XOR entre os bits anteriores, para realizar a
            -- operação XOR com o bit atual. Notar que por ser uma variável, o valor de
            -- v_parity_bit muda instantaneamente.
            v_parity_bit := v_parity_bit xor data_in(i);
        end loop;
        
        -- Após realizar todas as operações XOR, o bit de paridade par é atribuido ao bit
        -- menos significativo de data_out.        
        data_out(0) <= v_parity_bit;
        
        --A variável v_parity_bit retorna a 0, para reiniciar o processo de geração do bit de 
        -- paridade quando o valor de data_in mudar.
        v_parity_bit := '0';
    
    end process;
       
end Behavioral;
