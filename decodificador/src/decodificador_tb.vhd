-- Descrever um decodificador 3x8

-- IN   | OUT
-- 000  | 0000 0001
-- 001  | 0000 0010
-- 010  | 0000 0100
-- 011  | 0000 1000
-- 100  | ...
-- 101  |
-- 110  |
-- 111  |

library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

library work;
	use work.all;

--declaramos a mesa de testes.
--note que não é um análogo a um componente, então não tem "entradas e saídas"
    
entity decodificador_tb is
end decodificador_tb;

architecture behavioral of decodificador_tb is
    signal clock1		        		: std_logic := '0';
    signal contador				        : integer range 0 to 7 := 0; 
    signal signal_output_port	        : std_logic_vector(7 downto 0);
    signal signal_input_port	        : std_logic_vector(2 downto 0);

    component decodificador
    port(
        input_port	: 	in	std_logic_vector(2 downto 0);
        output_port	:	out	std_logic_vector(7 downto 0)
    );
    end component;

begin
-----------------------------------------------------------------------------
--CLOCK
-----------------------------------------------------------------------------
    clock1 <= not clock1 after 10 ns; --cria o relógio.

    signal_input_port <= std_logic_vector(to_unsigned(contador, 3));

    process(clock1)
    begin
    --delimitar range para inteiro não significa que ele retorne a 0 expontaneamente.
    if contador = 7 then
        contador <= 0;
    else
        contador <= contador + 1;
    end if;       
    end process;

    DUT : decodificador
    generic map(
        bit_input_size => dec_size
    )
    port map(
        input_port	=> signal_input_port,
        output_port	=> signal_output_port
    );
end behavioral;