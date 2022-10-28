
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity main is 
    port(
    unencrypted   : in std_logic_vector(127 downto 0) ;--:= x"3243f6a8885a308d313198a2e0370734";
    key           : in std_logic_vector(127 downto 0) ;--:=x"2b7e151628aed2a6abf7158809cf4f3c";
    clk           : in std_logic;
    crypted       : out std_logic_vector(127 downto 0) := x"00000000000000000000000000000000"
                                                       

    
    
    
    );
    
    
end entity; 

architecture arch of main is 


component sub_shift_mix is 
    port(
    tmp           : in std_logic_vector(127 downto 0);  -- := x"193de3bea0f4e22b9ac68d2ae9f84808";
    
	after_add_rounds : out std_logic_vector(127 downto 0);

	mix_counter   : in std_logic_vector(3 downto 0)  
	
    
    
    
    );
    
    
end component; 

component key_schedule is 
    port(
    tmp_key_main   : in std_logic_vector(127 downto 0)  ;
    clk   : in  std_logic;

    tmp_1 : out std_logic_vector(127 downto 0);
   
    rcon_ct_key : in std_logic_vector(3 downto 0)  
    
    
    
    );
    
    
end component; 


signal tmp :  std_logic_vector(127 downto 0);
signal after_add_rounds :  std_logic_vector(127 downto 0);
signal tmp_key_main :  std_logic_vector(127 downto 0);

signal tmp_1 :  std_logic_vector(127 downto 0);
signal rcon_ct_key :  std_logic_vector(3 downto 0)  := "0001";
signal mix_counter :  std_logic_vector(3 downto 0)  := "0001";
signal not_mix_col :  std_logic_vector(127 downto 0) ;

signal i_key :  std_logic_vector(127 downto 0);


type state_type is (KEY_GEN,ROUND);
signal state,current_state : state_type := ROUND;


begin
SUB_SHIFT_MIX_MODULE: sub_shift_mix port map(
                                             tmp => tmp,
                                             after_add_rounds => after_add_rounds,
                                             mix_counter      => mix_counter
                                             


                                             );

KEY_MODULE: key_schedule port map(
                                             tmp_key_main => tmp_key_main,
                                             tmp_1 => tmp_1,
                                             rcon_ct_key => rcon_ct_key,
                                             clk => clk



                                             );



    tmp_key_main <= key;
  
    process(clk)
    begin
      if(rising_edge(clk)) then
            case state is 
               when ROUND => 
               
                if (rcon_ct_key = "0001") then
                    tmp <= unencrypted xor key;
                    state <= KEY_GEN;
                elsif(rcon_ct_key < "1011") then
                    tmp <= i_key;
                    state <= KEY_GEN;
                
                elsif(rcon_ct_key = "1011") then
                        crypted <= i_key;
                
                end if;
                    
               when KEY_GEN =>  
                  if (rcon_ct_key = "0001") then
                    i_key <= after_add_rounds xor tmp_1;
                    rcon_ct_key <= rcon_ct_key + "0001" ;
                    state <= ROUND;
                 
                  
--                  elsif(rcon_ct_key = 10) then
--                     i_key <= after_add_rounds xor tmp_1;
--                     rcon_ct_key <= rcon_ct_key +1 ; 
--                     mix_counter <= 10 ;
--                     state <= ROUND;
                  
                  
                   
                  elsif(rcon_ct_key = "1001" ) then
                     i_key <= after_add_rounds xor tmp_1;
                     rcon_ct_key <= rcon_ct_key + "0001" ; 
                     mix_counter <= "1010" ;
                     state <= ROUND;
                 
                 elsif(rcon_ct_key < "1011") then
                     i_key <= after_add_rounds xor tmp_1;
                     rcon_ct_key <= rcon_ct_key + "0001" ;
                     state <= ROUND;
                  
                  
                end if;
               
               when others =>
                    
             end case;
        end if;
           
        end process;





end architecture;