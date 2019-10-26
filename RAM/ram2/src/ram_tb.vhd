library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

library work;
	use work.all;

entity ram_tb is
end ram_tb;

architecture arch of ram_tb is
    signal clk_sig             : std_logic := '0';
    signal ram_addr_sig        : std_logic_vector(7 downto 0) := (others=>'0');
    signal ram_data_sig        : std_logic_vector(7 downto 0) := (others=>'0');
    signal wr_en_sig           : std_logic := '1';
    signal counter             : integer range 0 to 7 := 0; 

    type vector_of_vector is array (7 downto 0) of std_logic_vector(7 downto 0);    
    --Inicializa valores da ram
    signal ram_sig : vector_of_vector := (others => (others => '0'));
    component ram is
        port (
            clk             : in std_logic;
            ram_addr        : in std_logic_vector(7 downto 0);
            ram_data        : inout std_logic_vector(7 downto 0);
            wr_en           : in std_logic
        );    
    end component;

begin

    -----------------------------------------------------------------------------
    --CLOCK
    -----------------------------------------------------------------------------
    clk_sig <= not clk_sig after 10 ns;

    process(clk_sig)
    begin
        if clk_sig'event and clk_sig = '1' then
            --counter loop
            if counter = 7 then
                counter <= 0;
                wr_en_sig <= not wr_en_sig;
            else
                counter <= counter + 1;
            end if;
            --Ram data
            if wr_en_sig = '1' then
                ram_sig(to_integer(unsigned(ram_addr_sig))) <= ram_data_sig;
                ram_data_sig <= std_logic_vector(to_unsigned(((to_integer(unsigned(ram_data_sig))) + 1),ram_data_sig'length));
            end if;
            -- addr loop
            if ram_addr_sig = std_logic_vector(to_unsigned(7, ram_addr_sig'length)) then
                ram_addr_sig <= std_logic_vector(to_unsigned(0, ram_addr_sig'length));
            else 
                ram_addr_sig <= std_logic_vector(to_unsigned(((to_integer(unsigned(ram_addr_sig))) + 1),ram_addr_sig'length));
            end if;
        end if;
    end process;

    -----------------------------------------------------------------------------
    --MAP
    -----------------------------------------------------------------------------
    DUT : ram
    port map(
        clk => clk_sig,
        ram_addr => ram_addr_sig, 
        ram_data => ram_data_sig,
        wr_en => wr_en_sig
    );

end arch;