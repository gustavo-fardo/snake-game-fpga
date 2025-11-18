library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Armazena a pontuacao mais alta ate o momento vista em sua entrada de N_BITS

entity highscore_mem is
    Generic (
        N_BITS : natural := 4
    );
    Port (
        score       : in std_logic_vector(N_BITS-1 downto 0);
		  highscore   : out std_logic_vector(N_BITS-1 downto 0)
    );
end highscore_mem;

architecture Behavioral of highscore_mem is

	 -- Sinal auxiliar do High Score para comparacao com a entrada
    signal high_score_current : std_logic_vector(N_BITS-1 downto 0) := score; 
	 
begin

    process(score)
    begin
        if high_score_current < score then
				high_score_current <= score;
		  end if;
		  highscore <= high_score_current;
    end process;
	 
end Behavioral;