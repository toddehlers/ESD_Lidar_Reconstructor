#include <pcl/point_types.h>
#include <pcl/filters/passthrough.h>
#include <pcl/keypoints/uniform_sampling.h>
#include <pcl/io/pcd_io.h>
#include <pcl/visualization/image_viewer.h>
#include <algorithm>

#include "esdCreateGriddedPCD.h"

esdCreateGriddedPCD::esdCreateGriddedPCD()
{
	// Empty input and output file names
	inputGPCName = std::string();
	outputRasterName = std::string();
	
	// Empty input and output Point clouds
	inputGPC = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);
		
	dx=0.0;
	dy=0.0;
	dz=0.0;

};

esdCreateGriddedPCD::~esdCreateGriddedPCD()
{
};

void esdCreateGriddedPCD::CLHelp(std::string sHelp[])
{
	for (size_t i = 0; i < 11; ++i)
 		std::cout<<sHelp[i]<<std::endl;

};

void esdCreateGriddedPCD::Main(int argc, std::string argv[],std::string VERSION_INFO)
{
	if (argc==1)
		{
		std::string sHelp[11];

	    sHelp[0] = "-------------------------------------------------------------------------------";
	    sHelp[1] = "CreateGriddedPCD <in.pcd> <out.ras> <res>";
  	    sHelp[2] = "this program will take 3 input parameters as shown below:";
	    sHelp[3] = "\t 1. in.pcd is the input PCD file";
	    sHelp[4] = "\t 2. out.ras is the output raster file";
	    sHelp[5] = "\t 3. res is spacing along x and y-axis";
	    sHelp[6] = "This program will process input.pcd using dx,dy and Compute Raster.";
	    sHelp[7] = "Generated list will be written in out.ras\n";
	    sHelp[8] = VERSION_INFO;
	    sHelp[9] = "--------------------------------------------------------------------------------";
		 	
		CLHelp(sHelp);
		
		}
	
	else if (argc==4)
		{
		
		inputGPCName = argv[1];
		outputRasterName = argv[2];	
		
		dx = ::atof(argv[3].c_str());
		dy = dx;
		
		WriteGriddedPCD();
		}
	else
		{
		std::cout<<"Not enough no. of input parameters" <<std::endl;
		}
};

void esdCreateGriddedPCD::WriteGriddedPCD(void)
{
	pcl::KdTreeFLANN<pcl::PointXYZ>  rawkdtree;	
	pcl::PCDReader reader;
	reader.read (inputGPCName, *inputGPC);
	std::cout << " GPC Loaded successfully with total "<<inputGPC->width<<" Points"<< std::endl;

	pcl::PointXYZ min_pt, max_pt; 
	pcl::getMinMax3D(inputGPC.operator*(), min_pt, max_pt); 
	
	int nXPixel, nYPixel;
	nXPixel = ceil((max_pt.x - min_pt.x)/dx);
	nYPixel = ceil((max_pt.y - min_pt.y)/dy);

	pcl::PointCloud<pcl::PointXYZ>::Ptr regularGrid (new pcl::PointCloud<pcl::PointXYZ>);
	double value = 0;

	for (size_t i = 0; i < nXPixel; ++i)
	{
	
		for (size_t j = 0; j < nYPixel; ++j)
		{
		
		pcl::PointXYZ basic_point;
		
	    basic_point.x = min_pt.x + dx* i ;
	    basic_point.y = min_pt.y + dy* j ;
	    basic_point.z = value ;
		
		regularGrid->points.push_back(basic_point);
			 	
		}
	
	}	
	
	std::vector<int> rawPointIds;
	std::vector<float> pointRadius;
	
	rawkdtree.setInputCloud (regularGrid);
	
	for (size_t i = 0; i < inputGPC->points.size(); ++i)
	{
		 
		pcl::PointXYZ searchPoint = inputGPC->points[i];
		searchPoint.z = 0;

		if (rawkdtree.radiusSearch (searchPoint, dx, rawPointIds, pointRadius) >=1)
		{

		int minind = min_element(pointRadius.begin(), pointRadius.end()) - pointRadius.begin();
		std::cout<<i*100/inputGPC->points.size()<<"% done.\r";

		regularGrid->points[rawPointIds.at(minind)].z = inputGPC->points[i].z;
		
		}
		else
		{

		std::cout<<i*100/inputGPC->points.size()<<"% done. \r";

		}
	}
	
	regularGrid->width = (int) nXPixel;
	regularGrid->height = (int) nYPixel;
	
	pcl::io::savePCDFileASCII (outputRasterName, *regularGrid);
	std::cout<<"\n \n Regular grid with Points" <<regularGrid->size() <<" succ. written."<<std::endl;	
};
