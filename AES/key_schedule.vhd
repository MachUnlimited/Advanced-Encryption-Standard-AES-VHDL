----------KEY SCHEDULE ---------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity key_schedule is 
    port(
    tmp_key_main   : in std_logic_vector(127 downto 0)  ;
    clk   : in  std_logic;

    tmp_1 : out std_logic_vector(127 downto 0);
   
    rcon_ct_key : in  std_logic_vector(3 downto 0) 
    
    
    
    );
    
    
end entity; 



architecture arch of key_schedule is

signal key_1 : std_logic_vector(127 downto 0);  
signal key_2 : std_logic_vector(127 downto 0);  
signal key_3 : std_logic_vector(127 downto 0);  
signal key_4 : std_logic_vector(127 downto 0);  
signal key_5 : std_logic_vector(127 downto 0);  
signal key_6 : std_logic_vector(127 downto 0);  
signal key_7 : std_logic_vector(127 downto 0);  
signal key_8 : std_logic_vector(127 downto 0);  
signal key_9 : std_logic_vector(127 downto 0);      
signal key_10 : std_logic_vector(127 downto 0);     



 signal key            :  std_logic_vector(127 downto 0)   ;
 signal rotate         : std_logic_vector(31 downto 0)   ;
 signal rotate_sbox         : std_logic_vector(31 downto 0)   ;


signal cipher_key : std_logic_vector(127 downto 0);
signal tmp_key : std_logic_vector(127 downto 0);

signal  ct_signal : std_logic_vector(3 downto 0) := "0001" ;





TYPE sBoxArray IS ARRAY (NATURAL RANGE 0 TO 255) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    CONSTANT sBox : sBoxArray := (
        x"63", x"7c", x"77", x"7b", x"f2", x"6b", x"6f", x"c5", x"30", x"01", x"67", x"2b", x"fe", x"d7", x"ab", x"76",
        x"ca", x"82", x"c9", x"7d", x"fa", x"59", x"47", x"f0", x"ad", x"d4", x"a2", x"af", x"9c", x"a4", x"72", x"c0",
        x"b7", x"fd", x"93", x"26", x"36", x"3f", x"f7", x"cc", x"34", x"a5", x"e5", x"f1", x"71", x"d8", x"31", x"15",
        x"04", x"c7", x"23", x"c3", x"18", x"96", x"05", x"9a", x"07", x"12", x"80", x"e2", x"eb", x"27", x"b2", x"75",
        x"09", x"83", x"2c", x"1a", x"1b", x"6e", x"5a", x"a0", x"52", x"3b", x"d6", x"b3", x"29", x"e3", x"2f", x"84",
        x"53", x"d1", x"00", x"ed", x"20", x"fc", x"b1", x"5b", x"6a", x"cb", x"be", x"39", x"4a", x"4c", x"58", x"cf",
        x"d0", x"ef", x"aa", x"fb", x"43", x"4d", x"33", x"85", x"45", x"f9", x"02", x"7f", x"50", x"3c", x"9f", x"a8",
        x"51", x"a3", x"40", x"8f", x"92", x"9d", x"38", x"f5", x"bc", x"b6", x"da", x"21", x"10", x"ff", x"f3", x"d2",
        x"cd", x"0c", x"13", x"ec", x"5f", x"97", x"44", x"17", x"c4", x"a7", x"7e", x"3d", x"64", x"5d", x"19", x"73",
        x"60", x"81", x"4f", x"dc", x"22", x"2a", x"90", x"88", x"46", x"ee", x"b8", x"14", x"de", x"5e", x"0b", x"db",
        x"e0", x"32", x"3a", x"0a", x"49", x"06", x"24", x"5c", x"c2", x"d3", x"ac", x"62", x"91", x"95", x"e4", x"79",
        x"e7", x"c8", x"37", x"6d", x"8d", x"d5", x"4e", x"a9", x"6c", x"56", x"f4", x"ea", x"65", x"7a", x"ae", x"08",
        x"ba", x"78", x"25", x"2e", x"1c", x"a6", x"b4", x"c6", x"e8", x"dd", x"74", x"1f", x"4b", x"bd", x"8b", x"8a",
        x"70", x"3e", x"b5", x"66", x"48", x"03", x"f6", x"0e", x"61", x"35", x"57", x"b9", x"86", x"c1", x"1d", x"9e",
        x"e1", x"f8", x"98", x"11", x"69", x"d9", x"8e", x"94", x"9b", x"1e", x"87", x"e9", x"ce", x"55", x"28", x"df",
        x"8c", x"a1", x"89", x"0d", x"bf", x"e6", x"42", x"68", x"41", x"99", x"2d", x"0f", x"b0", x"54", x"bb", x"16"
    );
    



begin	
     key <= tmp_key_main   when ct_signal = "0001" else
            key_1 when ct_signal = "0010" else
            key_2 when ct_signal = "0011" else
            key_3 when ct_signal = "0100" else
            key_4 when ct_signal = "0101" else
            key_5 when ct_signal = "0110" else
            key_6 when ct_signal = "0111" else
            key_7 when ct_signal = "1000" else
            key_8 when ct_signal = "1001" else
            key_9 when ct_signal = "1010" else
            key_9;                 
        
   
	  rotate <= key(23 downto 16) & key(15 downto 8) & key(7 downto 0)& key(31 downto 24) ; -- ROTATE WORD
	 
	        -------------- rotated words pass through sbox -------------
	
	  rotate_sbox <=  Sbox(to_integer(unsigned(rotate(31 downto 24)))) & Sbox(to_integer(unsigned(rotate(23 downto 16)))) &  Sbox(to_integer(unsigned(rotate(15 downto 8)))) & Sbox(to_integer(unsigned(rotate(7 downto 0))));

	 
	
	  
	       cipher_key(127 downto 120)  <= key(127 downto 120)     xor rotate_sbox(31 downto 24) xor x"01" when ct_signal = "0001" else 
	
	                                      key(127 downto 120)     xor rotate_sbox(31 downto 24) xor x"02" when ct_signal = "0010" else 
	
	                                      key(127 downto 120)     xor rotate_sbox(31 downto 24) xor x"04" when ct_signal = "0011" else 
	  
	                                      key(127 downto 120)     xor rotate_sbox(31 downto 24) xor x"08" when ct_signal = "0100" else 
	 
	                                      key(127 downto 120)     xor rotate_sbox(31 downto 24) xor x"10" when ct_signal = "0101" else 
	
	                                      key(127 downto 120)     xor rotate_sbox(31 downto 24) xor x"20" when ct_signal = "0110" else 

	                                      key(127 downto 120)     xor rotate_sbox(31 downto 24) xor x"40" when ct_signal = "0111" else 
	
	                                      key(127 downto 120)     xor rotate_sbox(31 downto 24) xor x"80" when ct_signal = "1000" else 
	
	                                       key(127 downto 120)     xor rotate_sbox(31 downto 24) xor x"1b" when ct_signal = "1001" else 
	
	                                      key(127 downto 120)     xor rotate_sbox(31 downto 24) xor x"36" when ct_signal = "1010" else 
	

	                                      key(127 downto 120)     xor rotate_sbox(31 downto 24) xor x"36";
	  
	 
	 
	
	
				  
					  
	cipher_key(119 downto 112)  <= key(119 downto 112)    xor rotate_sbox(23 downto 16) xor x"00";       
	cipher_key(111 downto 104)  <= key(111 downto 104)    xor rotate_sbox(15 downto 8) xor x"00";    																								  
	cipher_key(103 downto 96)   <= key(103 downto 96)     xor rotate_sbox(7 downto 0) xor x"00";       
																							
																							
	cipher_key(95 downto 88) <=    key(95 downto 88)  xor     cipher_key(127 downto 120)  ;     --        
	cipher_key(87 downto 80) <=    key(87 downto 80)  xor     cipher_key(119 downto 112)  ;             
	cipher_key(79 downto 72) <=    key(79 downto 72)  xor     cipher_key(111 downto 104)   ;             
	cipher_key(71 downto 64) <=    key(71 downto 64)  xor     cipher_key(103 downto 96)   ;
													
	cipher_key(63 downto 56) <=    key(63 downto 56)  xor     cipher_key(95 downto 88)  ;
	cipher_key(55 downto 48) <=    key(55 downto 48)  xor     cipher_key(87 downto 80)  ;
	cipher_key(47 downto 40) <=    key(47 downto 40)  xor     cipher_key(79 downto 72)  ;
	cipher_key(39 downto 32) <=    key(39 downto 32)  xor     cipher_key(71 downto 64)  ;
	
	cipher_key(31 downto 24) <=   key(31 downto 24)  xor    cipher_key(63 downto 56)  ; --
	cipher_key(23 downto 16) <=   key(23 downto 16)  xor    cipher_key(55 downto 48)  ;
	cipher_key(15 downto 8)  <=   key(15 downto 8)   xor    cipher_key(47 downto 40)  ;
	cipher_key(7 downto 0)   <=   key(7 downto 0)    xor      cipher_key(39 downto 32)  ;
	
	tmp_key <= cipher_key;
	
	
	
     process(clk)
     begin
     
     
    if(rising_edge(clk)) then    
     
     if (ct_signal = "0001") then 
	 
	 
	     key_1 <= tmp_key ;
	     ct_signal <= ct_signal + "0001";
	     
	     
     elsif (ct_signal = "0010") then  
        key_2 <= tmp_key ;
         ct_signal <= ct_signal + "0001";
        
     elsif (ct_signal = "0011") then  
        key_3 <= tmp_key ;
         ct_signal <= ct_signal + "0001"; 
     
     elsif (ct_signal = "0100") then  
        key_4 <= tmp_key ;      
        ct_signal <= ct_signal + "0001";
	 elsif (ct_signal = "0101") then  
        key_5 <= tmp_key ;   
        ct_signal <= ct_signal + "0001";
        
     elsif (ct_signal = "0110") then  
        key_6 <= tmp_key ;     
       ct_signal <= ct_signal + "0001";
	 elsif (ct_signal = "0111") then  
        key_7 <= tmp_key ;
        
        ct_signal <= ct_signal + "0001";
     elsif (ct_signal = "1000") then  
        key_8 <= tmp_key ; 
         ct_signal <= ct_signal + "0001";
        
     elsif (ct_signal = "1001") then  
        key_9 <= tmp_key ; 
         ct_signal <= ct_signal + "0001";
     elsif (ct_signal = "1010") then  
        key_10 <= tmp_key ;    
                
	
    else
        
    end if;
    end if;
    
    end process;
    tmp_1  <= key_1 when rcon_ct_key = "0001" else 
              key_2 when rcon_ct_key = "0010" else 
              key_3 when rcon_ct_key = "0011" else 
              key_4 when rcon_ct_key = "0100" else 
              key_5 when rcon_ct_key = "0101" else 
              key_6 when rcon_ct_key = "0110" else 
              key_7 when rcon_ct_key = "0111" else 
              key_8 when rcon_ct_key = "1000" else 
              key_9 when rcon_ct_key = "1001" else 
              key_10 when rcon_ct_key = "1010" else
              key_10;                  
                
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

   
end architecture;