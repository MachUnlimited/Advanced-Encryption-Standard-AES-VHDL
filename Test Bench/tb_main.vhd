----------------------------------------------------------------------------------
-- Company: 
-- Engineer: ATAKAN CAKIR
-- 
-- Create Date: 26.10.2022 22:16:41
-- Design Name: 
-- Module Name: tb_main - Behavioral
-- Project Name: Advanced Encryption Standard (AES)
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_main is
--  Port ( );
end tb_main;

architecture Behavioral of tb_main is
component main is 
    port(
    unencrypted   : in std_logic_vector(127 downto 0) ;
    key           : in std_logic_vector(127 downto 0) ;
    clk           : in std_logic;

    crypted       : out std_logic_vector(127 downto 0)

    
    
    
    );
    
    
end component; 
signal    unencrypted   : std_logic_vector(127 downto 0) ;
signal    key           : std_logic_vector(127 downto 0) ;
signal    clk           : std_logic;

signal    crypted       :  std_logic_vector(127 downto 0);
constant clock_period   : time := 8ns;

begin

uut: main port map( 
                unencrypted => unencrypted,
                key => key,
                clk => clk,

                crypted => crypted );

clock_Process: process
    begin
        clk <= '0';
        wait for clock_period / 2;
        clk <= '1';
        wait for clock_period / 2;
     end process;
     
     
stim_proc: process
    begin
       
              
        
        unencrypted <= x"3243f6a8885a308d313198a2e0370734"; -- example 1
        --unencrypted <= x"1546467a7687b768d97979c6687f987a"; -- example  2
        --unencrypted <= x"e787897f989789c879879b78787897f2";  -- example  3
                     
    
         key         <= x"2b7e151628aed2a6abf7158809cf4f3c";  -- example 1 
        -- key         <= x"43a564b5634e55634f6534e32324f132" ; -- example  2
        -- key         <= x"ad2387b5e4f678435813798132aed6c5" ; -- example  3
        
    wait for clock_period*21;
       wait;  

    end process;




end Behavioral;