library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GeradorFruta is
	 Generic (
		  M : natural := 20;
		  N : natural := 20
	 );
    Port (
		  clk_gera : in std_logic;
		  fruta_x : out std_logic_vector(3 downto 0);
		  fruta_y : out std_logic_vector(3 downto 0)
    );
end GeradorFruta;

architecture Behavioral of GeradorFruta is

    --  Seeds
    signal lfsr_x : unsigned(15 downto 0) := x"ACE1";
    signal lfsr_y : unsigned(15 downto 0) := x"BEEF";

begin

    process(clk_gera)
        variable feedback_x : std_logic;
        variable feedback_y : std_logic;
        variable rnd_x      : integer;
        variable rnd_y      : integer;
    begin
        if rising_edge(clk_gera) then

            -----------------------------------------
            -- LFSR X
            -----------------------------------------
            feedback_x := lfsr_x(15) xor lfsr_x(13) xor lfsr_x(12) xor lfsr_x(10);
            lfsr_x     <= lfsr_x(14 downto 0) & feedback_x;

            -----------------------------------------
            -- LFSR Y
            -----------------------------------------
            feedback_y := lfsr_y(15) xor lfsr_y(13) xor lfsr_y(12) xor lfsr_y(10);
            lfsr_y     <= lfsr_y(14 downto 0) & feedback_y;

            rnd_x := to_integer(lfsr_x) mod M;  -- 0 to M-1
            rnd_y := to_integer(lfsr_y) mod N;  -- 0 to N-1

            fruta_x <= std_logic_vector(to_unsigned(rnd_x, fruta_x'length));
            fruta_y <= std_logic_vector(to_unsigned(rnd_y, fruta_y'length));

        end if;
    end process;

end Behavioral;
