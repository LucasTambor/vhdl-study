library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

library work;
	use work.all;

entity shift_register_tb is
end shift_register_tb;

architecture arch of shift_register_tb is
    signal shift_reg_out_signal   : std_logic_vector(1023 downto 0) := (others=>'0');
    signal clk_signal             : std_logic := '0';
    signal reset_signal           : std_logic := '0';
    signal d_signal               : std_logic := '0';
    signal force_1_signal         : std_logic := '0';
    signal force_0_signal         : std_logic := '0';
    signal data_selected_signal   : std_logic := '0';
    signal enable_signal          : std_logic := '0';
    signal direction_signal       : std_logic := '1';
    signal parallel_load_signal   : std_logic := '0';
    signal parallel_d_signal   :  std_logic_vector(1023 downto 0) := (others=>'1');
    signal counter                : integer := 0;

    component shift
    port(
        shift_reg_out   : out std_logic_vector(1023 downto 0);
        clk             : in std_logic;
        reset           : in std_logic;
        d               : in std_logic;
        force_1         : in std_logic;
        force_0         : in std_logic;
        enable          : in std_logic;
        direction       : in std_logic;
        parallel_load   : in std_logic;
        parallel_data   : in std_logic_vector(1023 downto 0)
    );
    end component;
begin
    -----------------------------------------------------------------------------
    --CLOCK
    -----------------------------------------------------------------------------
    clk_signal <= not clk_signal after 10 ns; --cria o relógio.

    -----------------------------------------------------------------------------
    --Data signal | reset | counter
    -----------------------------------------------------------------------------
    process(clk_signal)
    begin
        if clk_signal'event and clk_signal = '1' then
            if counter = 10 then
                reset_signal <= '1';
                counter <= 0;
            else
                counter <= counter + 1;
                reset_signal <= '0';
                d_signal <= not d_signal;
            end if;
        end if;
    end process;

    -----------------------------------------------------------------------------
    --Estimulos Iniciais
    -----------------------------------------------------------------------------
    stimulus : PROCESS
        begin
        wait for 100 ns; force_1_signal  <= '1';
        wait for 50 ns; force_1_signal  <= '0';
        wait for 100 ns; force_0_signal  <= '1';
        wait for 50 ns; force_0_signal  <= '0';
        wait for 50 ns; parallel_load_signal  <= '1';
        wait for 50 ns; parallel_load_signal  <= '0';
        wait;
    end PROCESS stimulus;

    -----------------------------------------------------------------------------
    --MAP
    -----------------------------------------------------------------------------
    DUT : shift
    port map(
        shift_reg_out => shift_reg_out_signal,
        clk => clk_signal,
        reset => reset_signal,
        d => d_signal,
        force_1 => force_1_signal,
        force_0 => force_0_signal,
        enable => enable_signal,
        direction => direction_signal,
        parallel_load => parallel_load_signal,
        parallel_data => parallel_d_signal
    );
        
end arch;