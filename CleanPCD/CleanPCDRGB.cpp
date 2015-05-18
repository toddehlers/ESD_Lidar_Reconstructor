#include <iostream>
#include <pcl/io/pcd_io.h>
#include <pcl/point_types.h>
#include <boost/thread.hpp> 

boost::mutex mut; 


int main (int argc, char** argv)
{
 
 	pcl::PointCloud<pcl::PointXYZRGB>::Ptr inputGPC (new pcl::PointCloud<pcl::PointXYZRGB>);
	pcl::PointCloud<pcl::PointXYZ>::Ptr outputGPC (new pcl::PointCloud<pcl::PointXYZ>);
	pcl::PointCloud<pcl::PointXYZ>::Ptr tmp (new pcl::PointCloud<pcl::PointXYZ>);
	
	std::string inputGPCName, outputGPCName;
	
	inputGPCName = argv[1];
	outputGPCName = argv[2];
		
	boost::thread t1; 
		
	mut.lock(); 
	std::cout << "Loaded "<< pcl::io::loadPCDFile<pcl::PointXYZRGB> (inputGPCName, *inputGPC)<<std::endl;
	mut.unlock(); 
	

	copyPointCloud(*inputGPC,*tmp);
	
	for (size_t i = 0; i < tmp->points.size (); i++)
    	{
      	
    	pcl::PointXYZ point = tmp->points[i];
    
      	if (!(fabs(point.x) < 0.0001 &&
            fabs(point.y) < 0.00001 &&
            fabs(point.z) < 0.00001) &&
          	!pcl_isnan(point.x) &&
          	!pcl_isnan(point.y) &&
          	!pcl_isnan(point.z))
        
        	outputGPC->points.push_back(point);
    	}
    	
    outputGPC->width = static_cast<uint32_t> (outputGPC->points.size ());
    outputGPC->height = 1;
    outputGPC->is_dense = true; 	


	mut.lock(); 
	std::cerr << "Saved "<< pcl::io::savePCDFile(outputGPCName, *outputGPC)<<std::endl;
	mut.unlock(); 
	
	return (0);
  
}







//#include <iostream> 
//#include <pcl/point_types.h>
//#include <pcl/filters/passthrough.h>
//#include <boost/thread.hpp>
//#include <pcl/io/pcd_io.h>
//
//boost::timed_mutex mutex; 
//
//void ReadPCD(pcl::PointCloud<pcl::PointXYZ>::Ptr &inputGPC,std::string inputGPCName)
//{
//	std::cout<<"Strated Reading PCD File"<<inputGPCName<<std::endl;
//	pcl::PCDReader reader;
//	reader.read (inputGPCName, *inputGPC);
//	std::cout << " GPC "<<inputGPCName <<" after loading "<<inputGPC->points.size ()<<" Points"<< std::endl;
//
//};
//
//void ProcessPCD(pcl::PointCloud<pcl::PointXYZ>::Ptr &inputGPC,pcl::PointCloud<pcl::PointXYZ>::Ptr &outputGPC)
//{
//	std::cout<<"Strated Processing PCD File"<<std::endl;
//    std::cout << "Thread " << boost::this_thread::get_id()<< std::endl; 
//
//	for (size_t i = 0; i < inputGPC->points.size (); i++)
//    	{
//      	
//    pcl::PointXYZ point = inputGPC->points[i];
//    
//      	if (!(fabs(point.x) < 0.0001 &&
//            fabs(point.y) < 0.00001 &&
//            fabs(point.z) < 0.00001) &&
//          	!pcl_isnan(point.x) &&
//          	!pcl_isnan(point.y) &&
//          	!pcl_isnan(point.z))
//        
//        	outputGPC->points.push_back(point);
//    	}
//    	
//    outputGPC->width = static_cast<uint32_t> (outputGPC->points.size ());
//    outputGPC->height = 1;
//    outputGPC->is_dense = true; 	
//	    
//};
//
//void WritePCD(pcl::PointCloud<pcl::PointXYZ>::Ptr &outputGPC,std::string outputGPCName)
//{
//
//	std::cout <<"Strated Saving PCD File"<<std::endl;
//    std::cout << "Thread " << boost::this_thread::get_id()<< std::endl; 
//	std::cout << " GPC was successfully refined and now has total "<<outputGPC->width<<" Points"<< std::endl;
//	std::cout << pcl::io::savePCDFile(outputGPCName, *outputGPC,true);
//
//};
//
//int main(int arc, char** argv) 
//{ 
//	pcl::PointCloud<pcl::PointXYZ>::Ptr inputGPC (new pcl::PointCloud<pcl::PointXYZ>);
//	pcl::PointCloud<pcl::PointXYZ>::Ptr outputGPC (new pcl::PointCloud<pcl::PointXYZ>);
//	std::string inputGPCName, outputGPCName;
//
//	inputGPCName = argv[1];
//	outputGPCName = argv[2];
//
//
////    mutex.lock(); 
//	ReadPCD(inputGPC,inputGPCName);
////    mutex.unlock(); 
////	
////	mutex.lock(); 
////	ProcessPCD(inputGPC,outputGPC);
////    mutex.unlock(); 
////
//	outputGPC = inputGPC;
//	
//	std::cout << " Output GPC with "<<outputGPC->width<<" Points is processed"<< std::endl;
//
////	mutex.lock(); 
//	WritePCD(outputGPC,outputGPCName);
////    mutex.unlock(); 
//
//    return 0;
//} 
//
