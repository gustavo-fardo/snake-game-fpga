library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sentido_mem is
    Generic (
        CLK_FREQ_HZ  : natural := 50_000_000; -- System clock frequency (e.g., 50MHz)
        DEBOUNCE_MS  : natural := 20         -- Debounce time in milliseconds
    );
    Port (
        clk       : in  std_logic; -- System clock
        rst       : in  std_logic; -- System reset (active high)
        btn_up    : in  std_logic; -- Pushbutton for counting UP
        btn_down  : in  std_logic; -- Pushbutton for counting DOWN
        sentido : out std_logic_vector(1 downto 0) -- Counter output
    );
end sentido_mem;

architecture Behavioral of sentido_mem is

    -- Number of clock cycles needed for 20ms debounce
    constant DEBOUNCE_CYCLES : natural := (CLK_FREQ_HZ / 1000) * DEBOUNCE_MS;

    signal count_reg : unsigned(1 downto 0);

    signal up_debounce_cnt : natural range 0 to DEBOUNCE_CYCLES;
    signal up_state        : std_logic; 
    signal up_prev         : std_logic; 
    
    signal down_debounce_cnt : natural range 0 to DEBOUNCE_CYCLES; 
    signal down_state        : std_logic; 
    signal down_prev         : std_logic;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                count_reg         <= (others => '0');
                up_debounce_cnt   <= 0;
                up_state          <= '1';
                up_prev           <= '1';
                down_debounce_cnt <= 0;
                down_state        <= '1';
                down_prev         <= '1';
                
            else
                -- Debouncing
                
                if btn_up /= up_state then
                    up_debounce_cnt <= 0;
                elsif up_debounce_cnt < DEBOUNCE_CYCLES then
                    up_debounce_cnt <= up_debounce_cnt + 1;
                else
                    up_state <= btn_up;
                end if;
					 
                if btn_down /= down_state then
                    down_debounce_cnt <= 0;
                elsif down_debounce_cnt < DEBOUNCE_CYCLES then
                    down_debounce_cnt <= down_debounce_cnt + 1;
                else
                    down_state <= btn_down;
                end if;
					 
					 --

                up_prev   <= up_state;
                down_prev <= down_state;

                if (up_state = '0' and up_prev = '1') then
                    count_reg <= count_reg + 1;
                    
                elsif (down_state = '0' and down_prev = '1') then
                    count_reg <= count_reg - 1;
                end if;
                
            end if;
        end if;
    end process;

    sentido <= std_logic_vector(count_reg);

end Behavioral;