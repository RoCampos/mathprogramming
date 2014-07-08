#include <iostream>
#include <string>
#include <fstream>
#include <regex>
#include <cctype>

using namespace std;

/**
* Function used to filter the result of 
* glpsol. The result is a minimum cost of 
* a Steiner Tree.
*/
int filter (std::string str);

void save_network (std::string str, std::ofstream & out);

int main (int argc, char** argv) {

	filter (argv[1]);

	ofstream os;
	save_network (argv[1],os);

	return 0;
}

int filter (std::string str) {
	
	ifstream file (str.c_str ());

	if ( !file.good () ) {
		std::cerr << "Error\n";
	}
	
	std::string ss;
	while (file.good () ) {
		
		file >> ss;		
		if (ss.compare ("totalcost.val") == 0)  {
			file >> ss;
			file >> ss;
			std::cout << ss << std::endl;
			break;
		}
	}

	file.close ();
}

void save_network (std::string str, std::ofstream & out) {

	ifstream file ( str.c_str () );

	if (!file.good () ) {
		cerr << "erro" << endl;
	}

	std::string ss;
	while ( file.good () ) {
		file >> ss;
		if (ss.compare ("totalcost.val") == 0) {
			file >> ss;
			break;		
		}
	}
	
	file >> ss;
	file >> ss;
	file >> ss;
	file >> ss;
	file >> ss;
	file >> ss;

	while (ss.compare ("Model") != 0) {
		file >> ss;
		//TODO code for filtering

		int flag = 0;
		std::string number;
		int count = 0;
		int edges = 0;
		int value = 0;
		for ( int i=0; i < ss.length (); i++ ) {

			

		}	

	}

	file.close ();
	
}



