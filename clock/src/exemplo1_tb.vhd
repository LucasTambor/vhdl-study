--declaramos as bibliotecas.
library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

--declaramos a mesa de testes.
--note que não é um análogo a um componente, então não tem "entradas e saídas"
entity exemplo1_tb is
end exemplo1_tb;

architecture sim of exemplo1_tb is

	--declaramos os sinais que usaremos para gerar estímulos.
	signal clock1				: std_logic;
	signal clock2				: std_logic := '0'; --veja abaixo.
	signal clock3				: std_logic;
	signal clock4				: std_logic;
	signal clock5				: std_logic := '0';

begin
-----------------------------------------------------------------------------
--CLOCK 1 e 2 - por atribuição concorrente
-----------------------------------------------------------------------------
clock1 <= not clock1 after 10 ns; --esse vai dar errado. porque? sem definir algum valor, o sinal fica em U. o inverso de U é U.

clock2 <= not clock2 after 10 ns; --esse funciona. Veja na declaração porque.

-----------------------------------------------------------------------------
--CLOCK 3 - por processo
-----------------------------------------------------------------------------
--o clock 3 não precisou de um valor inicial porque já possui um.

process
begin
	clock3 <= '1';
	wait for 10 ns;
	clock3 <= '0';
	wait for 10 ns;
	
end process;

--o clock 4 tem o mesmo problema do clock1
process
begin
	clock4 <= not clock4; 
	clock5 <= not clock5;
	wait for 10 ns;
end process;

end sim;