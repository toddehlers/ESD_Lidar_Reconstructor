#include <iostream>
#include "esdCreateMaxPCD.cpp"

std::string* parseArgs(int argc, const char* argv[])
{
	std::string* Args = new std::string[argc];
	
	for(int i = 0; i < argc; i++) 
	{
		Args[i] = argv[i];
	}
	
	return Args;
}

int main(int argc, const char* argv[])
{

std::string VERSION_INFO = "DiffLiDAR 1.0, r-2012.08.25, fshahzad";

esdCreateMaxPCD *mInst = new esdCreateMaxPCD();

mInst->Main(argc,parseArgs(argc, argv), VERSION_INFO);

delete mInst;

return 0;

}
