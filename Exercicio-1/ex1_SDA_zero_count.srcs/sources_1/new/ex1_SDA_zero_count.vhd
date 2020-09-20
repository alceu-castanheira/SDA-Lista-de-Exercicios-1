----------------------------------------------------------------------------------
-- Company: Universidade de Bras�lia - UnB
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 12.09.2020 00:22:15
-- Design Name: 
-- Module Name: ex1_SDA_zero_count - Behavioral
-- Project Name: SDA - Lista de exerc�cios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- Implemente uma fun��o em VHDL que conte o n�mero de '0's de uma palavra cujo 
-- tamanho � ajust�vel atrav�s de uma entrada gen�rica. O n�mero de �0�s deve 
-- ser uma sa�da do circuito e seu tamanho tamb�m � um par�metro gen�rico. A 
-- fun��o deve ser chamada dentro de um processo.
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
entity ex1_SDA_zero_count is

    -- Par�metros gen�ricos definidos pelo usu�rio: 
    -- n => n�mero de bits do dado de entrada. Valor m�ximo: 16 (n�mero m�ximo de
    -- switches no kit Basys 3)
    -- p => n�mero de bits do dado de sa�da. Valor m�ximo: 5 (valor de bits
    -- necess�rio para implementar o maior valor em bin�rio (16))
    generic( n : integer range 1 to 16 := 16;
             p : integer range 1 to 5 := 5);
    Port ( 
            -- Entrada std_logic_vector de n-bits, sendo n o par�metro gen�rico definido
            -- pelo usu�rio
            data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
            
            -- Sa�da std_logic_vector de p-bits, sendo p o par�metro gen�rico definido
            -- pelo usu�rio
            zero_count_out : out STD_LOGIC_VECTOR (p-1 downto 0)
          );
end ex1_SDA_zero_count;

-- Arquitetura: descri��o do funcionamento do sistema
architecture Behavioral of ex1_SDA_zero_count is

    -- Fun��o count_zeros: recebe como par�metro de entrada (param_in) um
    -- vetor de n-bits e retorna o n�mero de '0's presentes (v_zero_count).
    --
    function count_zeroes (param_in : std_logic_vector(n-1 downto 0))
    return std_logic_vector is
    
    -- v_zero_count: vari�vel de p-1 bits que armazena o n�mero de '0's no vetor de entrada.
    -- Por se tratar de uma vari�vel, o valor � atualizado instanteamente.
    variable v_zero_count : std_logic_vector(p-1 downto 0) := (others => '0');
    begin
        
        -- Analisando todos os bits do vetor de entrada (de 0 a n-1).
        for i in 0 to n-1 loop
        
            -- Se o valor do bit atual for zero:
            if param_in(i) = '0' then
            
                -- Incremente a vari�vel v_zero_count em 1.
                v_zero_count := std_logic_vector(unsigned(v_zero_count) + 1);
                
            -- Caso contr�rio:    
            else
                
                -- v_zero_count mantem o seu valor atual.                
                v_zero_count := v_zero_count;
            end if;
        end loop;
        
    -- Retornar a vari�vel v_zero_count
    return v_zero_count;
    end;
    
    -- Declara��o do sinal s_zero_count de p-1 bits, que armazena o resultado da
    -- fun��o count_zeroes.
    signal s_zero_count : std_logic_vector(p-1 downto 0) := (others => '0');
    
begin

    -- Processo no qual declara-se a fun��o count_zeroes. Notar a lista de 
    -- sensibilidade: o processo sempre � executado quando data_in muda de 
    -- valor
    COUNT_ZEROES_PROC: process(data_in)
    begin
    
        -- Armazenando o valor retornado pela fun��o count_zeroes no sinal
        -- s_zero_count
        s_zero_count <= count_zeroes(data_in);
    end process;
    
    -- Atribuindo o sinal s_zero_count � sa�da zero_count_out
    zero_count_out <= s_zero_count;
    
end Behavioral;
