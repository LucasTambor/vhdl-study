library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;


entity shift is
    port (
        q :  out std_logic_vector(3 downto 0);
        clk     : in std_logic;
        reset   : in std_logic;
        d       : in std_logic
    );
end;

architecture arch of shift is

    SIGNAL q_signal : std_logic_vector(3 downto 0) := "0000";

begin
    ctr:
    process(clk, reset)
    begin
        if reset = '1' then
            q_signal <= "0000";
        elsif clk'event and clk = '1' then
            q_signal(0) <= d;
            q_signal(1) <= q_signal(0);
            q_signal(2) <= q_signal(1);
            q_signal(3) <= q_signal(2);
        end if;
    end process;

    -------------------
    q <= q_signal;
    -------------------
end arch;
