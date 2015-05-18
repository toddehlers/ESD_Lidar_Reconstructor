#include <iostream>
#include <cstdlib> 
#include <ctime>
#include <string>
#include <pcl/io/pcd_io.h>
#include <pcl/point_types.h>
#include <pcl/filters/extract_indices.h>


int main (int argc, char** argv)
{
 
 	pcl::PointCloud<pcl::PointXYZ>::Ptr inputGPC (new pcl::PointCloud<pcl::PointXYZ>);
	pcl::PointCloud<pcl::PointXYZ>::Ptr outputGPC (new pcl::PointCloud<pcl::PointXYZ>);

	std::string inputGPCName, outputGPCName;
	
	inputGPCName = argv[1];
	outputGPCName = argv[2];
	
 	pcl::PCDReader reader;
  	reader.read (inputGPCName, *inputGPC);

	std::cout << "Total Points in input Point Cloud "<<inputGPC->points.size()<<std::endl;
  
    float percPoints = ::atof(argv[3]);

	int nr_points = (int)(inputGPC->points.size ()*percPoints)/100;
	std::cout<<"Final output will consist of" <<nr_points<<"  Points"<<std::endl;

//  	int inPointsArray[nr_points];

	srand((unsigned)time(0)); 
	
//	for(int i=0; i<nr_points; i++)
//        inPointsArray[i] = (int)1+ rand()%inputGPC->points.size ();
//	
	int outpt = 0;
	for(size_t j=0; j<nr_points; j++)
	{
	 	pcl::PointXYZ sPt; 
	 	int inPointsArray = (int)1+ rand()%inputGPC->points.size ();
		sPt = inputGPC->points[inPointsArray];

     	if (!(fabs(sPt.x) < 0.0001 &&
            fabs(sPt.y) < 0.00001 &&
            fabs(sPt.z) < 0.00001) &&
          	!pcl_isnan(sPt.x) &&
          	!pcl_isnan(sPt.y) &&
          	!pcl_isnan(sPt.z))
				{
					outputGPC->points.push_back(sPt);    
					std::cout<<"Processing: \t" <<100*(j+1)/nr_points<<" % is done.\r";
					outpt = outpt+1;
				}
	}	
	
	outputGPC->width = static_cast<uint32_t> (outpt);
	outputGPC->height = static_cast<uint32_t> (1);;
	outputGPC->is_dense = true; 
	    
 	pcl::PCDWriter writer;
 	writer.write(outputGPCName, *outputGPC);
	std::cout << "Total Points in output Point Cloud  "<<outputGPC->points.size()<<std::endl;
	
	return (0);
  
}