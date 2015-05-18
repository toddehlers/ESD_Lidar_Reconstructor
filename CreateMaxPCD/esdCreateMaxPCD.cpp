#include <pcl/point_types.h>
#include <pcl/filters/passthrough.h>
#include <pcl/io/pcd_io.h>
#include <pcl/kdtree/kdtree_flann.h>
#include <pcl/filters/extract_indices.h>
#include "esdCreateMaxPCD.h"

esdCreateMaxPCD::esdCreateMaxPCD()
{
	// Empty input and output file names
	inputGPCName = std::string();
	outputGPCMaxName = std::string();
	
	// Empty input and output Point clouds
	inputGPC = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);
	outputMaxGPC = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);

};

esdCreateMaxPCD::~esdCreateMaxPCD()
{
};

void esdCreateMaxPCD::CLHelp(std::string sHelp[])
{

	for (size_t i = 0; i < sizeof(sHelp)+1; ++i)
 		std::cout<<sHelp[i]<<std::endl;

};

void esdCreateMaxPCD::Main(int argc, std::string argv[],std::string VERSION_INFO)
{				

	if (argc==1)
		{
		std::string sHelp[9];

	    sHelp[0] = "-------------------------------------------------------------------------------";
	    sHelp[1] = "CreateMaxPCD <in.pcd> <out_max.pcd> <krRadius>";
  	    sHelp[2] = "this program will take three parameters as shown below:";
	    sHelp[3] = "\t 1. in.pcd is the input PCD file";
	    sHelp[4] = "\t 2. out_max.pcd id the output PCD file with maximum z value in a given window";
	    sHelp[6] = "\t 3. krRadius is searching spehere radius and is always in decimel.";
	    sHelp[7] = VERSION_INFO;
	    sHelp[8] = "--------------------------------------------------------------------------------";
		 	
		CLHelp(sHelp);
		
		}
	
	else if (argc==4)
		{

		inputGPCName = argv[1];
		outputGPCMaxName = argv[2];
		kerRadius = ::atof(argv[3].c_str());
		WriteMaxPCD();
		}
	else
		{
		std::cout<<"Not enough no. of input parameters" <<std::endl;
		}
};

void esdCreateMaxPCD::WriteMaxPCD(void)
{
		
		pcl::PCDReader reader;
		reader.read (inputGPCName, *inputGPC);
		std::cout << "\nGPC" << inputGPCName << " loaded with "<<inputGPC->width<<" Points"<< std::endl;


		pcl::KdTreeFLANN<pcl::PointXYZ> kdtree;
		kdtree.setInputCloud (inputGPC);
		
	   for (size_t i = 0; i < inputGPC->points.size (); i++)
    	{
     	
    	std::vector<int> ind;
  		std::vector<float> rad;
    	std::vector<int> zval;
  
      	if ( kdtree.radiusSearch (inputGPC->points[i], kerRadius, ind, rad) > 0)
	  		{

 			pcl::PointCloud<pcl::PointXYZ>::Ptr subset (new pcl::PointCloud<pcl::PointXYZ>);
 			pcl::PointXYZ maxPt;
 			
   			createSubGPC(ind, inputGPC, subset);
//			std::cout << " Sub point cloud is being processed with a total of "<<subset->width<<" Points"<< std::endl;	
			findMaxPoint(subset, maxPt);
			maxPt.x = inputGPC->points[i].x;
			maxPt.y = inputGPC->points[i].y;
					
			std::cout<<"Processing: \t" <<100*(i+1)/inputGPC->points.size ()<<" % is done.\r";

       		outputMaxGPC->points.push_back(maxPt);
      				
    	  	}
  		
  		else
  		
  			{

  			outputMaxGPC->points.push_back(inputGPC->points[i]);

  			}
    	}
			
		std::cout<<"Processing: \t 100 % is done."<<std::endl;

	    outputMaxGPC->width = static_cast<uint32_t> (outputMaxGPC->points.size ());
	    outputMaxGPC->height = 1;
	    outputMaxGPC->is_dense = true; 
  			
		pcl::io::savePCDFileASCII (outputGPCMaxName, *outputMaxGPC);
		std::cout << " Maximum Point Cloud within a spehere radius of " <<kerRadius<<" with total points "<<outputMaxGPC->width<<" is created."<< std::endl;	

};

      
void esdCreateMaxPCD::createSubGPC(std::vector<int> ptIdx, pcl::PointCloud<pcl::PointXYZ>::Ptr &dataGPC, pcl::PointCloud<pcl::PointXYZ>::Ptr &cloud)
{

// in future replace this with some fast approach.	
//	dataGPC->width    = ptIdx.size();
//	dataGPC->height   = 1;
//	dataGPC->is_dense = false;
//	dataGPC->points.resize (dataGPC->width * dataGPC->height);

  cloud->width = ptIdx.size();
  cloud->height = 1;
  cloud->points.resize (cloud->width * cloud->height);

  for (size_t i = 0; i < cloud->points.size (); ++i)
  {
    cloud->points[i] = dataGPC->points[ptIdx[i]];
  }
  
};

void esdCreateMaxPCD::findMaxPoint(pcl::PointCloud<pcl::PointXYZ>::Ptr &cloud, pcl::PointXYZ & maxPoint)
{
  pcl::PointXYZ min_pt, max_pt; 
  pcl::getMinMax3D(cloud.operator*(), min_pt, maxPoint);

};
