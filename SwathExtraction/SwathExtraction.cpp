#include <iostream>
#include <pcl/point_types.h>
#include <pcl/filters/passthrough.h>
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

int
 main (int argc, char** argv)
{
	
	
  	pcl::PointCloud<pcl::PointXYZ>::Ptr cloud (new pcl::PointCloud<pcl::PointXYZ>);
  	pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_section (new pcl::PointCloud<pcl::PointXYZ>);
  	
  	pcl::PCDReader reader;
  	reader.read (argv[1], *cloud);
	
	std::cout << "\nGPC" << argv[1] << " loaded with "<<cloud->width<<" Points"<< std::endl;
		
	pcl::PointXYZ min_pt, max_pt;
	min_pt.x = -38.8248;
	min_pt.y = 369.8656;
	min_pt.z = -104.2853;

	max_pt.x = -18.8248;
	max_pt.y = 628.5556;
	max_pt.z = -28.5875;

  // Create the filtering object
	pcl::PassThrough<pcl::PointXYZ> pass(false);
	pass.setInputCloud (cloud);
	pass.setFilterFieldName ("x");
	pass.setFilterLimits (min_pt.x, max_pt.x);
	pass.setFilterLimitsNegative (false);
	pass.filter (*cloud_section);

//	pass.setInputCloud (cloud_section);
//	pass.setFilterFieldName ("y");
//	pass.setFilterLimits (min_pt.y, max_pt.y);
//	pass.setFilterLimitsNegative (true);
//	pass.filter (*cloud_section);
		
//	pass.setInputCloud (cloud_section);
//	pass.setFilterFieldName ("z");
//	pass.setFilterLimits (min_pt.z, max_pt.z);
//	pass.setFilterLimitsNegative (true);
//	pass.filter (*cloud_section);
	
 	pcl::PCDWriter writer;
 	writer.write(argv[2], *cloud_section);
	std::cout << "PCD was saved successfully with a total points "<<cloud_section->points.size()<<std::endl;
	
  return (0);
}
