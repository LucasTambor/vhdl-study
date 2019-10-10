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
    signal ram_data_in_sig     : std_logic_vector(7 downto 0) := (others=>'0');
    signal ram_data_out_sig    : std_logic_vector(7 downto 0) := (others=>'0');
    signal wr_en_sig           : std_logic := '1';

    component ram is
        port (
            clk             : in std_logic;
            ram_addr        : in std_logic_vector(7 downto 0);
            ram_data_in     : in std_logic_vector(7 downto 0);
            ram_data_out    : out std_logic_vector(7 downto 0);
            wr_en           : in std_logic
        );    
    end component;

begin

    -----------------------------------------------------------------------------
    --CLOCK
    -----------------------------------------------------------------------------
    clk_sig <= not clk_sig after 10 ns; --cria o relógio.

    process(clk_sig)
    begin
        if clk_sig'event and clk_sig = '1' then
            if ram_data_in_sig = std_logic_vector(254) then
                ram_data_in_sig <=  std_logic_vector(unsigned(0));
            else
                ram_data_in_sig <= std_logic_vector(unsigned(ram_data_in_sig + 1));
            end if;
            if ram_addr_sig = 7 then
                ram_addr_sig = 0;
            else 
                ram_addr_sig <= ram_addr_sig + 1;
            end if;
        end if;
    end process;

    -----------------------------------------------------------------------------
    --MAP
    -----------------------------------------------------------------------------
    DUT : ram
    port map(
        clk => clk_sig;
        ram_addr => ram_addr_sig;   
        ram_data_in => ram_data_in_sig;
        ram_data_out => ram_data_out_sig;   
        wr_en => wr_en_sig  
    );

end arch;