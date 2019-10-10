library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

entity or_when_else is
	port(
		input_port	: 	in	std_logic_vector(3 downto 0);
		output_port	:	out	std_logic
	);
end or_when_else;

architecture behavioral of or_exemplo is

--para este exemplo não declaramos sinais ou componentes. mas caso fossem declarados, seria aqui.

begin

	--aqui é onde o código acontece.
	process
		case input_port is
			when "000" =>
				output_port <=  '0';
			when others =>
				output_port <= '1';
		end case;
	end process;
end behavioral;