#include <pcl/point_types.h>
#include <pcl/filters/passthrough.h>
#include <pcl/io/pcd_io.h>
#include <pcl/kdtree/kdtree_flann.h>
#include <pcl/filters/extract_indices.h>
#include <pcl/point_cloud.h>
#include <pcl/keypoints/uniform_sampling.h>
#include <pcl/registration/icp.h>
#include <iostream>
#include <vector>
#include "esdDiffLiDAR.h"


esdDiffLiDAR::esdDiffLiDAR()
{
	// Empty input and output file names
	inputGPCNameTime1 = std::string();
	inputGPCNameTime2 = std::string();
	PListName = std::string();
	QListName = std::string();
	ptsCorrName= std::string(); 
	
	// Empty input and output Point clouds
	inputGPCTime1 = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);
	inputGPCTime2 = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);
	PList = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);
	QList = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);
	ptsCorr = pcl::PointCloud<pcl::PointXYZ>::Ptr (new pcl::PointCloud<pcl::PointXYZ>);

	gridInterval = 0.0;
	thLimit = 0.0;
	maxCorresDist = 0.0;
};

esdDiffLiDAR::~esdDiffLiDAR()
{
};

void esdDiffLiDAR::CLHelp(std::string sHelp[])
{

	for (size_t i = 0; i < sizeof(sHelp)+1; ++i)
 		std::cout<<sHelp[i]<<std::endl;

};

void esdDiffLiDAR::Main(int argc, std::string argv[],std::string VERSION_INFO)
{				

	if (argc==1)
		{
		std::string sHelp[9];

	    sHelp[0] = "-------------------------------------------------------------------------------";
	    sHelp[1] = "DiffLiDAR <in1.pcd> <in2.pcd> <PList.pcd> <QList.pcd> <gridInterval> <thLimit>";
  	    sHelp[2] = "this program will take three parameters as shown below:";
	    sHelp[3] = "\t 1. in1.pcd is the input PCD file at time1";
	    sHelp[4] = "\t 2. in2.pcd is the input PCD file at time2";
	    sHelp[5] = "\t 3.PList.pcd is the output PCD file with calculated velocities";
	    sHelp[6] = "\t 4. QList.pcd is the output PCD file with calculated velocities";
	    sHelp[7] = "\t 5. gridInterval is searching spehere radius and is always in decimel.";
	    sHelp[8] = VERSION_INFO;
	    sHelp[9] = "--------------------------------------------------------------------------------";
		 	
		CLHelp(sHelp);
		
		}
	
	else if (argc==9)
		{
		inputGPCNameTime1 = argv[1];
 		inputGPCNameTime2 = argv[2];
 		PListName = argv[3];
 		QListName = argv[4];
 		ptsCorrName = argv[5];
		gridInterval = ::atof(argv[6].c_str());
		maxCorresDist = ::atof(argv[7].c_str()); 
		thLimit = ::atof(argv[8].c_str());

		WriteVelocityPCD();
		}
	else
		{
		std::cout<<"Not enough no. of input parameters" <<std::endl;
		}
};

void esdDiffLiDAR::WriteVelocityPCD(void)
{
		
		pcl::PCDReader reader;
		reader.read (inputGPCNameTime1, *inputGPCTime1);
		reader.read (inputGPCNameTime2, *inputGPCTime2);
		
		std::cout << "\nGPC" << inputGPCNameTime1 << " loaded with "<<inputGPCTime1->width<<" Points"<< std::endl;
		std::cout << "\nGPC" << inputGPCNameTime2 << " loaded with "<<inputGPCTime2->width<<" Points"<< std::endl;

		pcl::KdTreeFLANN<pcl::PointXYZ> kdtree1,kdtree2;

		kdtree1.setInputCloud (inputGPCTime1);
		kdtree2.setInputCloud (inputGPCTime2);
		
		createPList(inputGPCTime1,PList,gridInterval);		
    	
    	std::vector<int> ind1, ind2;
  		std::vector<float> rad;    	
	 	pcl::PointXYZ tmpQPoint,tmpPPoint,tmpPtCorr;
	
	   	for (size_t i = 0; i < PList->points.size (); i++)
    	{
    		tmpPPoint = PList->points[i];
			tmpQPoint = tmpPPoint;
			tmpPtCorr = tmpPPoint;
			tmpPtCorr.z = 0;
				
      		if ( kdtree1.radiusSearch (PList->points[i], gridInterval/2, ind1, rad) > 0)
	  		{
 			pcl::PointCloud<pcl::PointXYZ>::Ptr subsetTime1 (new pcl::PointCloud<pcl::PointXYZ>);
 			pcl::PointCloud<pcl::PointXYZ>::Ptr subsetTime2 (new pcl::PointCloud<pcl::PointXYZ>);

   			kdtree2.radiusSearch (PList->points[i], (gridInterval/2)+0.2, ind2, rad);
   			
   			if (ind2.size() != 0)
   				{
	   			createSubGPC(ind1, inputGPCTime1, subsetTime1);
   				createSubGPC(ind2, inputGPCTime2, subsetTime2);
					
//				tmpPPoint = PList->points[i];
//				tmpQPoint = tmpPPoint;
		
				offsetCalculations(subsetTime1,subsetTime2,tmpPPoint,tmpQPoint,tmpPtCorr,thLimit,maxCorresDist);
			
				std::cout<<"\t Processing: \t" <<100*(i+1)/PList->points.size ()<<" % is done. while corr is " << tmpPtCorr.z<< "\r";

       			QList->points.push_back(tmpQPoint);    
       			ptsCorr->points.push_back(tmpPtCorr);    
       			PList->points[i] = tmpPPoint;
       		
				}
   			else
   				{

      			QList->points.push_back(PList->points[i]);    
			 	ptsCorr->points.push_back(tmpPtCorr);    

   				}
   				
   			//	ptsCorr->points.push_back(tmpPtCorr);
		  	}
 		
  			else
  			{
  				
       		QList->points.push_back(tmpQPoint);
//  			PList->points[i] = tmpPPoint;
			ptsCorr->points.push_back(tmpPtCorr);

  			}
    	}

		std::cout<<"Processing: \t 100 % is done." <<ptsCorr->size()<<std::endl;
	    QList->width = static_cast<uint32_t> (PList->width);
	    QList->height = static_cast<uint32_t> (PList->height);;
	    QList->is_dense = true; 

	    PList->width = static_cast<uint32_t> (PList->width);;
	    PList->height = static_cast<uint32_t> (PList->height);;
	    PList->is_dense = true; 

	    ptsCorr->width = static_cast<uint32_t> (PList->width);;
	    ptsCorr->height = static_cast<uint32_t> (PList->height);;
	    ptsCorr->is_dense = true; 
	    	      			
		pcl::io::savePCDFileASCII (PListName, *PList);
		std::cout << "PList with " <<gridInterval<<" m intervals with width= "<<PList->width <<" and height "<<PList->height<<" is saved"<< std::endl;	

		pcl::io::savePCDFileASCII (QListName, *QList);
		
		std::cout << "QList with " <<gridInterval<<" m intervals with width= "<<QList->width <<" and height "<<QList->height<<" is saved"<< std::endl;	

		pcl::io::savePCDFileASCII (ptsCorrName, *ptsCorr);
		
		std::cout << "Point Correlation data with " <<gridInterval<<" m intervals with width= "<<ptsCorr->width <<" and height "<<QList->height<<" is saved"<< std::endl;	
		
};

      
void esdDiffLiDAR::createSubGPC(std::vector<int> ptIdx, pcl::PointCloud<pcl::PointXYZ>::Ptr &dataGPC, pcl::PointCloud<pcl::PointXYZ>::Ptr &cloud)
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

void esdDiffLiDAR::createPList(pcl::PointCloud<pcl::PointXYZ>::Ptr &inputGPC, pcl::PointCloud<pcl::PointXYZ>::Ptr &PList, float interval)
{

	pcl::KdTreeFLANN<pcl::PointXYZ>  rawkdtree;	
	pcl::PointXYZ min_pt, max_pt; 
	
	pcl::getMinMax3D(inputGPC.operator*(), min_pt, max_pt); 
	
	int nXPixel, nYPixel;
	
	nXPixel = ceil((max_pt.x - min_pt.x)/interval);
	nYPixel = ceil((max_pt.y - min_pt.y)/interval);

//	pcl::PointCloud<pcl::PointXYZ>::Ptr regularGrid (new pcl::PointCloud<pcl::PointXYZ>);
	double value = 0;

	for (size_t i = 0; i < nXPixel; ++i)
	{
	
		for (size_t j = 0; j < nYPixel; ++j)
		{
		
		pcl::PointXYZ basic_point;
		
	    basic_point.x = min_pt.x + interval* i ;
	    basic_point.y = min_pt.y + interval* j ;
	    basic_point.z = value ;
		
		PList->points.push_back(basic_point);
			 	
		}
	
	}	
	
	std::vector<int> rawPointIds;
	std::vector<float> pointRadius;
	
	rawkdtree.setInputCloud (PList);
	
	for (size_t i = 0; i < inputGPC->points.size(); ++i)
	{
		 
		pcl::PointXYZ searchPoint = inputGPC->points[i];
		searchPoint.z = 0;

		if (rawkdtree.radiusSearch (searchPoint, interval, rawPointIds, pointRadius) >=1)
		{

		int minind = min_element(pointRadius.begin(), pointRadius.end()) - pointRadius.begin();
		std::cout<<i*100/inputGPC->points.size()<<"% done.\r";

		PList->points[rawPointIds.at(minind)].z = inputGPC->points[i].z;
		
		}
		else
		{

		std::cout<<i*100/inputGPC->points.size()<<"% done. \r";

		}
	}
	
	PList->width = (int) nXPixel;
	PList->height = (int) nYPixel;
	PList->is_dense = true; 

	
// 	old syntex dont delete untill confirm by fshahzad
//	pcl::PointCloud<int> sampled_indices;
//	pcl::UniformSampling<pcl::PointXYZ> uniform_sampling;
//  	uniform_sampling.setInputCloud (inputGPCTime1);
//  	uniform_sampling.setRadiusSearch (interval);
//  	uniform_sampling.compute (sampled_indices);
//  	pcl::copyPointCloud (*inputGPCTime1, sampled_indices.points, *PList);

};	

void esdDiffLiDAR::offsetCalculations(pcl::PointCloud<pcl::PointXYZ>::Ptr &subsetTime1, pcl::PointCloud<pcl::PointXYZ>::Ptr &subsetTime2, pcl::PointXYZ &tmpPPoint, pcl::PointXYZ &tmpQPoint, pcl::PointXYZ &ptsCorr, float thLimit, float maxCorresDist)
{
	pcl::PointCloud<pcl::PointXYZ> Final;
	
	pcl::IterativeClosestPoint<pcl::PointXYZ, pcl::PointXYZ> icp;
	icp.setInputCloud(subsetTime1);
	icp.setInputTarget(subsetTime2);
	icp.setRANSACIterations(thLimit);
    icp.setMaxCorrespondenceDistance (maxCorresDist);
    icp.setMaximumIterations (100); // Set the maximum number of iterations (criterion 1)
	icp.align(Final);

	if (icp.hasConverged())
	{
	Eigen::Matrix4f output = icp.getFinalTransformation();
  	pcl::PointCloud<pcl::PointXYZ> out;
 	pcl::transformPointCloud (*subsetTime1, out,output);
    
    Eigen::Vector4f centroid; 
 	pcl::compute3DCentroid(out,centroid);
	tmpQPoint.x = centroid(0);
	tmpQPoint.y = centroid(1);
	tmpQPoint.z = centroid(2);

	pcl::compute3DCentroid(*subsetTime1,centroid);
	tmpPPoint.x = centroid(0);
	tmpPPoint.y = centroid(1);
	tmpPPoint.z = centroid(2);
	
	ptsCorr.x = tmpPPoint.x;
	ptsCorr.y = tmpPPoint.y;
	ptsCorr.z = icp.getFitnessScore();
	
	}
};	
