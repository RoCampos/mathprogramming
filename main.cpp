#include <iostream>
#include <fstream>
#include <string>
#include <boost/regex.hpp>
#include <limits>


int main (int argv, char**argc) 
{

	std::string input = argc[1];
	std::string output = argc[2];


  	std::ifstream f_input (input);
  	std::ofstream f_output;
  
  	f_output.open(output, std::ofstream::out | std::ofstream::app);
  
  	f_input.ignore (std::numeric_limits<std::streamsize>::max(), '\n');
  	f_input.ignore (std::numeric_limits<std::streamsize>::max(), '\n');  
  
  	static const boost::regex ex("\\D\\W(\\d*)\\W(\\d*)\\W(\\d*)\\W(\\d*)\\W ([1])");
  	std::string fmt = "$1 - $2:$3 $4;";
  
  	while (f_input.good ()) {
   
    	std::string str;
    
    	std::getline (f_input, str, '\n'); 
   		if (str.size () > 0 && str.at(0) == 'x') {
   	   
      		std::string result = boost::regex_replace (str, ex, fmt);    
      		if (result.at(0) != 'x') {
				f_output << result << std::endl;
      		}
      
    	}    
 	}
  
 	f_input.close ();
  	f_output.close ();
	

	return 0;
}


