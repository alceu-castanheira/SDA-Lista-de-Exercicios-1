----------------------------------------------------------------------------------
-- Company: Universidade de Bras�lia - UnB
-- Engineer: Alceu Bernardes Castanheira de Farias
-- 
-- Create Date: 12.09.2020 00:56:58
-- Design Name: 
-- Module Name: ex2_SDA_zero_count_l2r - Behavioral
-- Project Name: SDA - Lista de exerc�cios 1
-- Target Devices: Artix 7 - Basys 3
-- Tool Versions: Vivado 2018.3
-- Description: 
-- 
-- Implemente uma fun��o em VHDL que percorre um vetor de esquerda a direita e conta 
-- o n�mero de '0's at� encontrar o primeiro '1'. A palavra de entrada deve ter um 
-- tamanho ajust�vel atrav�s de uma entrada gen�rica. O n�mero de '0's deve ser uma 
-- sa�da do circuito e seu tamanho tamb�m � um par�metro gen�rico. A fun��o deve ser 
-- chamada dentro de um processo.
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
entity ex2_SDA_zero_count_l2r is

    -- Par�metros gen�ricos definidos pelo usu�rio: 
    -- n => n�mero de bits do dado de entrada. Valor m�ximo: 16 (n�mero m�ximo de
    -- switches no kit Basys 3)
    -- p => n�mero de bits do dado de sa�da. Valor m�ximo: 5 (valor de bits
    -- necess�rio para implementar o maior valor em bin�rio (16))
    generic ( n : integer range 1 to 16 := 16;
              p : integer range 1 to 5 := 5);
    Port ( 
            -- Entrada std_logic_vector de n-bits, sendo n o par�metro gen�rico definido
            -- pelo usu�rio            
            data_in : in STD_LOGIC_VECTOR (n-1 downto 0);
            
            -- Sa�da std_logic_vector de p-bits, sendo p o par�metro gen�rico definido
            -- pelo usu�rio            
            zero_count_l2r_out : out STD_LOGIC_VECTOR (p-1 downto 0)
          );
end ex2_SDA_zero_count_l2r;

-- Arquitetura: descri��o do funcionamento do sistema
architecture Behavioral of ex2_SDA_zero_count_l2r is

    -- Fun��o count_zeros_l2r: recebe como par�metro de entrada (param_in) um vetor de 
    -- n-bits e retorna o n�mero de '0's encontrados no sentido da esquerda (bit mais 
    -- significativo) at� a direita, parando ao encontrar o primeiro bit igual a '1'.
    function count_zeroes_l2r (param_in : std_logic_vector(n-1 downto 0))
    return std_logic_vector is
    
    -- v_zero_count: vari�vel de p-1 bits que armazena o n�mero de '0's no vetor de entrada,
    -- da esquerda para a direita, at� encontrar o primeiro '1'. Por se tratar de uma vari�vel, 
    -- o valor � atualizado instanteamente.    
    variable v_zero_count : std_logic_vector(p-1 downto 0) := (others => '0');
    
    -- v_one_flag: vari�vel de 1 bit utilizada como flag, que indica que o primeiro '1' foi
    -- encontrado ao percorrer o vetor de entrada da esquerda para a direita.
    variable v_one_flag : std_logic := '0';
    begin
    
        -- Analisando todos os bits do vetor de entrada (de 0 a n-1).
        for i in 0 to n-1 loop
        
            -- Se a flag v_one_flag for igual a '1':
            if v_one_flag = '1' then
            
                -- v_zero_count mant�m seu valor atual, pois o primeiro '1' j� foi detectado.
                v_zero_count := v_zero_count;
                
            -- Caso contr�rio, se um bit igual a '0' for encontrado:
            elsif param_in(n-1-i) = '0' then
            
                -- v_zero_count � incrementado em 1.
                v_zero_count := std_logic_vector(unsigned(v_zero_count) + 1);
                
            -- Caso contr�rio, se um bit igual a '1' for encontrado:
            elsif param_in(n-1-i) = '1' then
            
                -- v_one_flag recebe '1'.
                v_one_flag := '1';
                
            -- Se nenhuma das condi��es acima for verdadeira:
            else
            
                -- Ambas as vari�veis s�o mantidas em 0.
                v_one_flag := '0';
                v_zero_count := (others => '0');
            end if;
        end loop;
        
    -- Retornar a vari�vel v_zero_count
    return v_zero_count;
    end;

    -- Declara��o do sinal s_zero_count_out_l2r de p-1 bits, que armazena o resultado da
    -- fun��o count_zeroes_l2r.    
    signal s_zero_count_out_l2r : std_logic_vector (p-1 downto 0) := (others => '0');
    
begin

    -- Processo no qual declara-se a fun��o count_zeroes. Notar a lista de sensibilidade:
    -- o processo � executado sempre que data_in muda de valor.
    COUNT_ZEROES_L2R_PROC : process(data_in)
    begin
    
        -- Armazenando o valor retornado pela fun��o count_zeroes_l2r no sinal
        -- s_zero_count_out_l2r    
        s_zero_count_out_l2r <= count_zeroes_l2r(data_in);
    end process;

    -- Atribuindo o sinal s_zero_count_out_l2r � sa�da zero_count_l2r_out
    zero_count_l2r_out <= s_zero_count_out_l2r;
                
end Behavioral;
