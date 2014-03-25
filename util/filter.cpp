#include <iostream>
#include <string>
#include <fstream>

using namespace std;

/**
* Function used to filter the result of 
* glpsol. The result is a minimum cost of 
* a Steiner Tree.
*/
int filter (std::string str);

int main (int argc, char** argv) {

	
	filter ("df");

	return 0;
}

int filter (std::string str) {
	
	ifstream file (str.c_str ());

	if ( !file.good () ) {
		std::cout << "Error\n";
	}

}

