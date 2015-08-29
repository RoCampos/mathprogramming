#include <iostream>
#include <fstream>
#include <string>

int main (int argc, char**argv)
{

	std::ifstream file (argv[1]);
	std::string line;

	while ( getline (file,line) ) {

		int v,w,k,bin = -1;
		sscanf (line.c_str(), "y(%d,%d,%d) %d", &v, &w, &k, &bin );

		if (bin == 1)
			std::cout << (v) << " - " << (w) << ":" << k << ";\n"; 

	}



	return 0;
}
