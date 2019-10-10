-- Descreve um decodificador 3x8

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

--declaramos a mesa de testes.
--note que não é um análogo a um componente, então não tem "entradas e saídas"
    
entity decodificador is
	port(
		LEDR	: 	out	std_logic_vector(7 downto 0);
		SW	:	in	std_logic_vector(2 downto 0)
	);
end decodificador;

architecture behavioral of decodificador is

begin

    LEDR <=  	"00000001" when SW="000" else
				"00000010" when SW="001" else
				"00000100" when SW="010" else
				"00001000" when SW="011" else
				"00010000" when SW="100" else
				"00100000" when SW="101" else
				"01000000" when SW="110" else
				"10000000" when SW="111" else
				"00000000";

	end behavioral;