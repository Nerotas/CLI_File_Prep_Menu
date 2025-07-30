#!/bin/bash 
echo "Drag in ITMSP and then hit enter to continue:"                                                                                      
echo "-------------------------------------------------"                                                                                  
read -er inputITMSP                                                                                                                       
echo "-------------------------------------------------"                                                                                  
echo "Who is the provider? Use provider name from the 3rd line of the iTunes metadata"                                                    
read -er inputProvider                                                                                                                    
echo "-------------------------------------------------"                                                                                  
echo "Name the output log. What is the name of asset?"                                                                                    
read -er inputAsset                                                                                                                       
echo "-------------------------------------------------"                                                                                  
echo "Where is the METADATA folder?"                                                                                                      
read -er inputMETA                                                                                                                        
echo "-------------------------------------------------"                                                                                  
/usr/local/itms/bin/iTMSTransporter -u upload@mojomakers.com -p 1990Mojo -m verify -f $inputITMSP -v eXtreme -s $inputProvider -o "$inputMETA/iTunes_[$inputAsset]_pkg_validation.txt"
