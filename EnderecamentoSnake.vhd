library IEEE;
use  IEEE.STD_LOGIC_1164.all;
USE ieee.numeric_std.all;

entity EnderecamentoSnake is
	generic(
		C_BITS : in natural := 10; 
		L_BITS : in natural := 10;
		END_BITS : in natural := 8;
		MAX_COL_DISPLAY : in natural := 640;
		MAX_LIN_DISPLAY : in natural := 480;
		END_Y_MAX : in natural := 16;
		END_X_MAX : in natural := 16
	);
   port( 
      clock		:	in std_logic;
		coluna : in std_logic_vector(C_BITS-1 downto 0);
		linha : in std_logic_vector(L_BITS-1 downto 0);
		address: out std_logic_vector(END_BITS-1 downto 0)
	);
end entity EnderecamentoSnake;

architecture comportamento of EnderecamentoSnake is	

signal auxlinha :	INTEGER RANGE 0 to MAX_LIN_DISPLAY;
signal auxcoluna :	INTEGER RANGE 0 to MAX_COL_DISPLAY;
signal auxadd : INTEGER RANGE 0 to MAX_LIN_DISPLAY*MAX_COL_DISPLAY;
constant downsize_X : INTEGER := MAX_LIN_DISPLAY/END_X_MAX;
constant downsize_y : INTEGER := MAX_COL_DISPLAY/END_Y_MAX;

begin
		process(clock)
		begin
			if rising_edge(clock) then
				auxlinha <= to_integer(unsigned(linha));
				auxcoluna <= to_integer(unsigned(coluna));
				auxadd <= (END_X_MAX-auxlinha/downsize_X)*(END_Y_MAX+auxcoluna/downsize_y);
				address <=  std_logic_vector(to_unsigned(auxadd, END_BITS));
			end if;
		
		end process;
		--	

end comportamento;
