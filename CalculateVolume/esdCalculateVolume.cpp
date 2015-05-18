#include <pcl/point_types.h>
#include <pcl/filters/passthrough.h>
#include <pcl/io/pcd_io.h>
#include <pcl/kdtree/kdtree_flann.h>
#include <pcl/filters/extract_indices.h>
#include <pcl/point_cloud.h>
#include <pcl/surface/convex_hull.h>
#include <iostream>
#include <vector>
#include "esdCalculateVolume.h"


esdCalculateVolume::esdCalculateVolume()
{
	// Empty input and output file names
	inputGPCName = std::string();
	outputGPCVolName = std::string();
	
	// Empty input and output Point clouds
	inputGPC = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);
	outputVolGPC = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);

};

esdCalculateVolume::~esdCalculateVolume()
{
};

void esdCalculateVolume::CLHelp(std::string sHelp[])
{

	for (size_t i = 0; i < sizeof(sHelp)+1; ++i)
 		std::cout<<sHelp[i]<<std::endl;

};

void esdCalculateVolume::Main(int argc, std::string argv[],std::string VERSION_INFO)
{				

	if (argc==1)
		{
		std::string sHelp[9];

	    sHelp[0] = "-------------------------------------------------------------------------------";
	    sHelp[1] = "CalculateVolume <in.pcd> <out_vol.pcd> <krRadius>";
  	    sHelp[2] = "this program will take three parameters as shown below:";
	    sHelp[3] = "\t 1. in.pcd is the input PCD file";
	    sHelp[4] = "\t 2. out_vol.pcd id the output PCD file with maximum z value in a given window";
	    sHelp[6] = "\t 3. krRadius is searching spehere radius and is always in decimel.";
	    sHelp[7] = VERSION_INFO;
	    sHelp[8] = "--------------------------------------------------------------------------------";
		 	
		CLHelp(sHelp);
		
		}
	
	else if (argc==4)
		{
		
		inputGPCName = argv[1];
		outputGPCVolName = argv[2];
		kerRadius = ::atof(argv[3].c_str());
		WriteMaxPCD();			
		}
		
	else
		{
		std::cout<<"Not enough no. of input parameters" <<std::endl;
		}
};

void esdCalculateVolume::WriteMaxPCD(void)
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
 			pcl::PointXYZ volPt;
 			
   			createSubGPC(ind, inputGPC, subset);
			float volume, area;
			findVolArea(subset, area,volume);
			volPt.x = inputGPC->points[i].x;
			volPt.y = inputGPC->points[i].y;
			volPt.z = volume;
					
			std::cout<<"Processing: \t" <<100*(i+1)/inputGPC->points.size ()<<" % is done.\n";

       		outputVolGPC->points.push_back(volPt);
      				
    	  	}
  		
  		else
  		
  			{

  			outputVolGPC->points.push_back(inputGPC->points[i]);

  			}
    	}
			
		std::cout<<"Processing: \t 100 % is done."<<std::endl;

	    outputVolGPC->width = static_cast<uint32_t> (outputVolGPC->points.size ());
	    outputVolGPC->height = 1;
	    outputVolGPC->is_dense = true; 
  			
		pcl::io::savePCDFileASCII (outputGPCVolName, *outputVolGPC);
		std::cout << " Volume Point Cloud within a spehere radius of " <<kerRadius<<" with total points "<<outputVolGPC->width<<" is created."<< std::endl;	

};

      
void esdCalculateVolume::createSubGPC(std::vector<int> ptIdx, pcl::PointCloud<pcl::PointXYZ>::Ptr &dataGPC, pcl::PointCloud<pcl::PointXYZ>::Ptr &cloud)
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

void esdCalculateVolume::findVolArea(pcl::PointCloud<pcl::PointXYZ>::Ptr &cloud, float &area, float &volume)
{
	pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_hull(new pcl::PointCloud<pcl::PointXYZ>);
    pcl::ConvexHull<pcl::PointXYZ> chull;
    chull.setInputCloud (cloud);
    chull.setDimension(3);
    chull.setComputeAreaVolume(true);
    chull.reconstruct (*cloud_hull);
	volume = chull.getTotalVolume();
	area = chull.getTotalArea();
};
