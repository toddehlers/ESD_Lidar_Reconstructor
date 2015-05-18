#include <pcl/point_types.h>
#include <pcl/filters/passthrough.h>
#include <pcl/io/pcd_io.h>
#include <pcl/kdtree/kdtree_flann.h>
#include <pcl/filters/extract_indices.h>
#include <pcl/point_cloud.h>
#include <pcl/surface/convex_hull.h>
#include <iostream>
#include <vector>
#include "esdCutFillVolume.h"


esdCutFillVolume::esdCutFillVolume()
{
	// Empty input and output file names
	inputGPCNameTime1 = std::string();
	inputGPCNameTime2 = std::string();
	
	outputGPCDiffVolName = std::string();
	
	// Empty input and output Point clouds
	inputGPCTime1 = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);
	inputGPCTime2 = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);
	outputDiffVolGPC = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);

};

esdCutFillVolume::~esdCutFillVolume()
{
};

void esdCutFillVolume::CLHelp(std::string sHelp[])
{

	for (size_t i = 0; i < sizeof(sHelp)+1; ++i)
 		std::cout<<sHelp[i]<<std::endl;

};

void esdCutFillVolume::Main(int argc, std::string argv[],std::string VERSION_INFO)
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
	
	else if (argc==5)
		{
		inputGPCNameTime1 = argv[1];
 		inputGPCNameTime2 = argv[2];
 		outputGPCDiffVolName = argv[3];
		kerRadius = ::atof(argv[4].c_str());
		WriteMaxPCD();
		}
	else
		{
		std::cout<<"Not enough no. of input parameters" <<std::endl;
		}
};

void esdCutFillVolume::WriteMaxPCD(void)
{
		
		pcl::PCDReader reader;
		reader.read (inputGPCNameTime1, *inputGPCTime1);
		reader.read (inputGPCNameTime2, *inputGPCTime2);
		
		std::cout << "\nGPC" << inputGPCNameTime1 << " loaded with "<<inputGPCTime1->width<<" Points"<< std::endl;
		std::cout << "\nGPC" << inputGPCNameTime2 << " loaded with "<<inputGPCTime2->width<<" Points"<< std::endl;

		pcl::KdTreeFLANN<pcl::PointXYZ> kdtree1,kdtree2;
		kdtree1.setInputCloud (inputGPCTime1);
		kdtree2.setInputCloud (inputGPCTime2);
		
	   for (size_t i = 0; i < inputGPCTime1->points.size (); i++)
    	{
     	
    	std::vector<int> ind1;
  		std::vector<float> rad1;
    	std::vector<int> ind2;
		pcl::PointXYZ volPt;

  		float volume1,volume2, area1, area2;

      	if ( kdtree1.radiusSearch (inputGPCTime1->points[i], kerRadius, ind1, rad1) > 0)
	  		{

 			pcl::PointCloud<pcl::PointXYZ>::Ptr subsetTime1 (new pcl::PointCloud<pcl::PointXYZ>);
 			pcl::PointCloud<pcl::PointXYZ>::Ptr subsetTime2 (new pcl::PointCloud<pcl::PointXYZ>);
   			kdtree2.radiusSearch (inputGPCTime1->points[i], kerRadius, ind2, rad1);

   			createSubGPC(ind1, inputGPCTime1, subsetTime1);
   			createSubGPC(ind2, inputGPCTime2, subsetTime2);
   			
			
			findVolArea(subsetTime1, area1,volume1);
			findVolArea(subsetTime2, area2,volume2);
			
			volPt.x = inputGPCTime1->points[i].x;
			volPt.y = inputGPCTime1->points[i].y;
			volPt.z = volume2 - volume1;
					
			std::cout<<volPt.z<<" \t Processing: \t" <<100*(i+1)/inputGPCTime1->points.size ()<<" % is done.\n";

       		outputDiffVolGPC->points.push_back(volPt);
      				
    	  	}
  		
  		else
  		
  			{
			volPt.x = inputGPCTime1->points[i].x;
			volPt.y = inputGPCTime1->points[i].y;
			volPt.z = 0;
  			outputDiffVolGPC->points.push_back(volPt);

  			}
    	}
			
		std::cout<<"Processing: \t 100 % is done."<<std::endl;

	    outputDiffVolGPC->width = static_cast<uint32_t> (outputDiffVolGPC->points.size ());
	    outputDiffVolGPC->height = 1;
	    outputDiffVolGPC->is_dense = true; 
  			
		pcl::io::savePCDFileASCII (outputGPCDiffVolName, *outputDiffVolGPC);
		std::cout << " Volume Point Cloud within a spehere radius of " <<kerRadius<<" with total points "<<outputDiffVolGPC->width<<" is created."<< std::endl;	

};

      
void esdCutFillVolume::createSubGPC(std::vector<int> ptIdx, pcl::PointCloud<pcl::PointXYZ>::Ptr &dataGPC, pcl::PointCloud<pcl::PointXYZ>::Ptr &cloud)
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

void esdCutFillVolume::findVolArea(pcl::PointCloud<pcl::PointXYZ>::Ptr &cloud, float &area, float &volume)
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
