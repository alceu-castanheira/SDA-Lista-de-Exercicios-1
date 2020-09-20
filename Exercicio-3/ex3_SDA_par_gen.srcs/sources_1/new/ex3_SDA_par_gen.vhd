----------------------------------------------------------------------------------
-- Company: Universidade de Bras�lia - UnB
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 11.09.2020 23:35:36
-- Design Name: 
-- Module Name: ex3_SDA_par_gen - Behavioral
-- Project Name: SDA - Lista de exerc�cios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- Projete e implemente um circuito gerador de paridade par de uma entrada de N bits,
-- sendo N um par�metro de entrada gen�rico. A sa�da de N+1 bits deve conter um n�mero 
-- par de '1's.
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
use IEEE.NUMERIC_STD.ALL;

-- Entidade: entradas e sa�das do sistema
entity ex3_SDA_par_gen is

    -- Par�metros gen�ricos definidos pelo usu�rio: 
    -- n => n�mero de bits do dado de entrada. Valor m�ximo: 15 (n�mero m�ximo de
    -- switches no kit Basys 3 - 1, por conta do bit de paridade)
    generic (n : integer range 1 to 15 := 15);
    Port (
            -- Entrada std_logic_vector de n-bits, sendo n o par�metro gen�rico definido
            -- pelo usu�rio             
            data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
            
            -- Sa�da std_logic_vector do gerador de paridade. Tamanho de n bits, um a 
            -- mais do que a entrada, por conta do bit de paridade par.
            data_out : out STD_LOGIC_VECTOR (n downto 0)
         );
end ex3_SDA_par_gen;

-- Arquitetura: descri��o do funcionamento do sistema
architecture Behavioral of ex3_SDA_par_gen is
    
begin

    -- Copiando a entrada para os bits mais significativos da sa�da.
    data_out(n downto 1) <= data_in;
    
    -- Processo que implementa o gerador de paridade par. Notar a lista de sensibilidade:
    -- sempre que o valor de data_in mudar, o processo � executado.
    PARITY_GENERATOR: process(data_in)
    
    -- Vari�vel v_parity_bit que armazena o bit de paridade par.
    variable v_parity_bit : std_logic := '0';
    begin
        
        -- Percorrendo todos os bits do vetor de entrada, de 0 a n-1.
        for i in 0 to n-1 loop
        
            -- Um circuito gerador de paridade par � composto por opera��es XOR entre todos
            -- os bits que comp�em a entrada: bit_0 XOR bit_1 XOR bit_2.... XOR bit_(n-1).
            -- Assim, v_parity_bit recebe o valor de v_parity_bit (que na primeira itera��o
            -- vale '0') XOR o bit atual. Na primeira itera��o, v_parity ir� armazenar o bit
            -- atual (menos significativo), mas a partir das pr�ximas itera��es do loop ir�
            -- armazenar o valor da opera��o XOR entre os bits anteriores, para realizar a
            -- opera��o XOR com o bit atual. Notar que por ser uma vari�vel, o valor de
            -- v_parity_bit muda instantaneamente.
            v_parity_bit := v_parity_bit xor data_in(i);
        end loop;
        
        -- Ap�s realizar todas as opera��es XOR, o bit de paridade par � atribuido ao bit
        -- menos significativo de data_out.        
        data_out(0) <= v_parity_bit;
        
        --A vari�vel v_parity_bit retorna a 0, para reiniciar o processo de gera��o do bit de 
        -- paridade quando o valor de data_in mudar.
        v_parity_bit := '0';
    
    end process;
       
end Behavioral;
