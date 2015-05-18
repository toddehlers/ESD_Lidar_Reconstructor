#include <pcl/point_types.h>
#include <pcl/filters/passthrough.h>
#include <boost/thread.hpp>
#include <pcl/io/pcd_io.h>
#include "esdCleanPCD.h"

esdCleanPCD::esdCleanPCD()
{
	// Empty input and output file names
	inputGPCName = std::string();
	outputGPCName = std::string();
	
	// Empty input and output Point clouds
	inputGPC = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);
	outputGPC = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);

};

esdCleanPCD::~esdCleanPCD()
{
};

void esdCleanPCD::CLHelp(std::string sHelp[])
{

	for (size_t i = 0; i < sizeof(sHelp)+1; ++i)
 		std::cout<<sHelp[i]<<std::endl;

};

void esdCleanPCD::Main(int argc, std::string argv[],std::string VERSION_INFO)
{
	if (argc==1)
		{
		std::string sHelp[9];

	    sHelp[0] = "-------------------------------------------------------------------------------";
	    sHelp[1] = "ClearPCD <in.pcd> <out.pcd>";
  	    sHelp[2] = "this program will take two input parameters as shown below:";
	    sHelp[3] = "\t 1. in.pcd is the input PCD file";
	    sHelp[4] = "\t 2. out.pcd id the output PCD file";
	    sHelp[5] = "This program will process input.pcd file and remove zeros or null";
	    sHelp[6] = "entries by interatively going through it. Output will be written in out.pcd\n";
	    sHelp[7] = VERSION_INFO;
	    sHelp[8] = "--------------------------------------------------------------------------------";
		 	
		CLHelp(sHelp);
		
		}
	
	else if (argc==3)
		{
		inputGPCName = argv[1];
		outputGPCName = argv[2];
		ReadCleanWrite();
		}
	else
		{
		std::cout<<"Not enough no. of input parameters" <<std::endl;
		}
};

void esdCleanPCD::ReadCleanWrite(void)
{		

  			boost::thread t1(new  boost::thread(&esdCleanPCD::ReadThread)); 
			t1.join();	

//		#pragma omp for ordered schedule(dynamic)

	
//	std::cout << " GPC was successfully refined and now has total "<<outputGPC->width<<" Points"<< std::endl;
//	pcl::io::savePCDFile(outputGPCName, *outputGPC,true);
//	
};

void esdCleanPCD::ReadThread()
{
		std::cout<<"hello"<<std::endl;

//		pcl::PCDReader reader;
//		reader.read (inputGPCName, *inputGPC);
//
//		std::cout << " GPC "<<inputGPCName <<" after loading "<<inputGPC->width<<" Points"<< std::endl;
};

//void esdCleanPCD::CleanThread(pcl::PointCloud<pcl::PointXYZ>::Ptr &inputGPC,pcl::PointCloud<pcl::PointXYZ>::Ptr &outputGPC)
//{
//
//	    for (size_t i = 0; i < inputGPC->points.size (); i++)
//    	{
//      	
//      	pcl::PointXYZ point = inputGPC->points[i];
//      	if (!(fabs(point.x) < 0.0001 &&
//            fabs(point.y) < 0.00001 &&
//            fabs(point.z) < 0.00001) &&
//          	!pcl_isnan(point.x) &&
//          	!pcl_isnan(point.y) &&
//          	!pcl_isnan(point.z))
//        
//        	outputGPC->points.push_back(point);
//    	
//    	}
//    	
//    outputGPC->width = static_cast<uint32_t> (outputGPC->points.size ());
//    outputGPC->height = 1;
//    outputGPC->is_dense = true; 	
//};