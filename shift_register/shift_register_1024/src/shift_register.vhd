library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;


entity shift is
    port (
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
end;

architecture arch of shift is

    SIGNAL q_signal : std_logic_vector(1023 downto 0) := (others=>'0');
    SIGNAL data_selected : std_logic := '0';
begin

    data_selected <= '0' when force_0 = '1' else
					    '1' when force_1 = '1' else
						    d;
    ctr:
    process(clk, reset, parallel_load)
    begin
        if reset = '1' then
            q_signal <= (others => '0');
        elsif clk'event and clk = '1' then
            if parallel_load = '1' then
                q_signal <= parallel_data;
            elsif enable = '1' then
                if direction = '1' then
                    q_signal(0) <= data_selected;
                    for I in 1 to 1023 loop
                        q_signal(I) <= q_signal(I-1);
                    end loop;
                else
                    q_signal(1023) <= data_selected;
                    for I in 1022 to 0 loop
                        q_signal(I) <= q_signal(I+1);
                end loop;
            end if;
            end if;
        end if;
    end process;

    -------------------
    shift_reg_out <= q_signal;
    -------------------
end arch;
