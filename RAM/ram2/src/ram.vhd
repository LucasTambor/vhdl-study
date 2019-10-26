--Criar outra RAM para ter apenas uma porta de dados de entrada e saída.

library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;


entity ram is
    port (
        clk             : in std_logic;
        ram_addr        : in std_logic_vector(7 downto 0);
        ram_data        : inout std_logic_vector(7 downto 0);
        wr_en           : in std_logic
    );
end ram;

architecture arch of ram is

    type vector_of_vector is array (7 downto 0) of std_logic_vector(7 downto 0);    
    --Inicializa valores da ram
    signal ram : vector_of_vector := (others => (others => '0'));
    --Endereco lido
    signal read_addr : std_logic_vector(ram_addr'range);
    
begin

    RAMProc: process(clk) 
    begin
        if clk'event and clk = '1' then
            if wr_en = '1' then
                ram(to_integer(unsigned(ram_addr))) <= ram_data;
            else
                ram_data <= ram(to_integer(unsigned(ram_addr))); 
            end if;
        end if;
    end process RAMProc;

end arch;