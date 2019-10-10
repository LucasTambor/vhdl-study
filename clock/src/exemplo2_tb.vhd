--declaramos as bibliotecas.
library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;
--note que usaremos a biblioteca WORK. É onde estará o or_example.
library work;
	use work.all;

--declaramos a mesa de testes.
--note que não é um análogo a um componente, então não tem "entradas e saídas"
entity exemplo2_tb is
end exemplo2_tb;

architecture sim of exemplo2_tb is

	--declaramos os sinais que usaremos para gerar estímulos.
	signal clock1				: std_logic := '0';
	signal nCS					: std_logic := '0'; --veja abaixo.


	--constante. podemos mudar a vontade.
	signal contador				: integer range 0 to 15 := 0; --estamos delimitando o integer para ir de 0 a 2^4-1 (15).

	--declaramos sinais para podermos conectar a entidade no mundo.
	signal signal_input_port	: std_logic_vector(3 downto 0);
	signal signal_output_port	: std_logic;

	--declaramos a entidade.
	component or_exemplo

		port(
			input_port	: 	in	std_logic_vector(3 downto 0);
			output_port	:	out	std_logic
		);
	end component;

begin
-----------------------------------------------------------------------------
--CLOCK
-----------------------------------------------------------------------------
clock1 <= not clock1 after 10 ns; --cria o nosso relógio.

-----------------------------------------------------------------------------
--Criamos um sinal dependente do relógio. Este será vinculado ao CLOCK.
-----------------------------------------------------------------------------
	process
	begin
		nCS <= not nCS;
		--contador comportamental. não gera implementação de verdade no FPGA se feito assim.
		--delimitar range para inteiro não significa que ele retorne a 0 expontaneamente.
		if contador = 15 then
			contador <= 0;
		else
			contador <= contador + 1;
		end if;
		wait until clock1 = '1'; --note: estamos esperando até o clock chegar neste valor.
		wait until clock1 = '0'; --porque não colocamos na lista de sensibilidade? porque claramente instruimos o
								 --processo a esperar. Senão, se fosse usado IF, teria que estar. ver abaixo.
	end process;

	process(nCS, contador, clock1)
	begin
		if ncs = '1' then                       --case incencitive. notem isso.
			signal_input_port <= (others=>'0'); --estou instruindo o sistema a tocar zero em todas as posições.
		else
			signal_input_port <= std_logic_vector(to_unsigned(contador, or_size));
		end if;
	end process;

	DUT : or_exemplo
		generic map(
			bit_input_size => or_size
		)
		port map(
			input_port	=> signal_input_port,
			output_port	=> signal_output_port
		);

end sim;