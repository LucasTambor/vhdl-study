--
-- Copyright 1991-2016 Mentor Graphics Corporation
--
-- All Rights Reserved.
--
-- THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION WHICH IS THE PROPERTY OF 
-- MENTOR GRAPHICS CORPORATION OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.
--   

library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

library work;
	use work.all;

entity test_counter is
   port(count : BUFFER bit_vector(8 downto 1));
end;

architecture only of test_counter is

COMPONENT counter
      PORT ( count : BUFFER bit_vector(8 downto 1);
             clk   : IN bit;
             reset : IN bit);
END COMPONENT ;

SIGNAL clk_signal   : bit := '0';
SIGNAL reset_signal_reset : bit := '0';
SIGNAL reset_signal_init : bit := '0';
SIGNAL reset_signal : bit := '0';
begin

   -------------
   reset_signal <= reset_signal_reset or reset_signal_init;
   ------------
reset_count : process(clk_signal)
   begin
      if (count = "00001010") then
         reset_signal_reset  <= '1';
      else 
         reset_signal_reset <= '0';
      end if;
end process reset_count;

dut : counter 
   PORT MAP (
   count => count,
   clk => clk_signal,
   reset => reset_signal);

clock : PROCESS
   begin
   wait for 10 ns; clk_signal  <= not clk_signal;
end PROCESS clock;

stimulus : PROCESS
   begin
   wait for 5 ns; reset_signal_init  <= '1';
   wait for 4 ns; reset_signal_init  <= '0';
   wait;
end PROCESS stimulus;

end only;

