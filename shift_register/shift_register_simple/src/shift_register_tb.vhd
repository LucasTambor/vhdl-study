library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

library work;
	use work.all;

entity shift_register_tb is
end shift_register_tb;

architecture arch of shift_register_tb is
    signal clock_signal		        		: std_logic := '0';
    signal reset_signal		        		: std_logic := '0';
    signal data_signal		        		: std_logic := '0';
    signal q_out_signal                     : std_logic_vector(3 downto 0);
    signal counter                          : integer := 0;

    component shift
    port(
        q :  out std_logic_vector(3 downto 0);
        clk     : in std_logic;
        reset   : in std_logic;
        d       : in std_logic
    );
    end component;
begin
    -----------------------------------------------------------------------------
    --CLOCK
    -----------------------------------------------------------------------------
    clock_signal <= not clock_signal after 10 ns; --cria o relógio.

    -----------------------------------------------------------------------------
    --Data signal | reset | counter
    -----------------------------------------------------------------------------
    process(clock_signal)
    begin
        if clock_signal'event and clock_signal = '1' then
            if counter = 10 then
                reset_signal <= '1';
                counter <= 0;
            else
                counter <= counter + 1;
                reset_signal <= '0';
                data_signal <= not data_signal;
            end if;
        end if;
    end process;

    -----------------------------------------------------------------------------
    --MAP
    -----------------------------------------------------------------------------
    DUT : shift
    port map(
        q => q_out_signal,
        clk => clock_signal,
        reset => reset_signal,
        d => data_signal
    );
        
end arch;