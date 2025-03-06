library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SoM is
    Generic (
        MAX_LENGTH : integer := 138;  -- Max vector length
        COUNTER_LENGTH: INTEGER := 20 
    );
    port (
        clk : in std_logic;
        leds : out std_logic_vector(137 downto 0)
    );
end entity;

architecture rtl of SoM is

    component CC_PLL is
        generic (
            REF_CLK         : string;  -- reference input in MHz
            OUT_CLK         : string;  -- pll output frequency in MHz
            PERF_MD         : string;  -- LOWPOWER, ECONOMY, SPEED
            LOW_JITTER      : integer; -- 0: disable, 1: enable low jitter mode
            CI_FILTER_CONST : integer; -- optional CI filter constant
            CP_FILTER_CONST : integer  -- optional CP filter constant
        );
        port (
            CLK_REF             : in  std_logic;
            USR_CLK_REF         : in  std_logic;
            CLK_FEEDBACK        : in  std_logic;
            USR_LOCKED_STDY_RST : in  std_logic;
            USR_PLL_LOCKED_STDY : out std_logic;
            USR_PLL_LOCKED      : out std_logic;
            CLK0                : out std_logic;
            CLK90               : out std_logic;
            CLK180              : out std_logic;
            CLK270              : out std_logic;
            CLK_REF_OUT         : out std_logic
        );
    end component;

    signal clk0    : std_logic;
    signal counter : unsigned(COUNTER_LENGTH downto 0) := (others => '0');
    signal lastBit : std_logic := '0';
    signal position : INTEGER range 0 to MAX_LENGTH-1 := 0; 

begin
    socket_pll : CC_PLL
    generic map (
        REF_CLK         => "10.0",
        OUT_CLK         => "50.0",
        PERF_MD         => "ECONOMY",
        LOW_JITTER      => 1,
        CI_FILTER_CONST => 2,
        CP_FILTER_CONST => 4
    )
    port map (
        CLK_REF             => clk,
        USR_CLK_REF         => '0',
        CLK_FEEDBACK        => '0',
        USR_LOCKED_STDY_RST => '0',
        USR_PLL_LOCKED_STDY => open,
        USR_PLL_LOCKED      => open,
        CLK0                => clk0,
        CLK90               => open,
        CLK180              => open,
        CLK270              => open,
        CLK_REF_OUT         => open
    );

    process(clk0)
    variable diff: INTEGER := 0;
    begin
        if rising_edge(clk0) then
            counter <= counter + 1;
            
            if counter(COUNTER_LENGTH -1) = '1' and lastBit = '0' then
                leds <= (others => '0');
                if position >= MAX_LENGTH - 1 then
                    position <= 0;            
                else
                    position <= position + 1; 
                end if;
                leds(MAX_LENGTH -1 - position) <= '1';
                  
            end if;
            
            lastBit <= counter(COUNTER_LENGTH -1);
        end if;
    end process;
end architecture;
