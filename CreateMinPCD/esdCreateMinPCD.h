//start 
//
#ifndef _CREATEMINPCD_H
#define _CREATEMINPCD_H

class esdCreateMinPCD
{
	private:
		std::string inputGPCName, outputGPCMinName;

		pcl::PointCloud<pcl::PointXYZ>::Ptr inputGPC; 
		pcl::PointCloud<pcl::PointXYZ>::Ptr outputMinGPC;

		float kerRadius; // moving kernel radius 

	protected:

	public:
		esdCreateMinPCD();
		~esdCreateMinPCD();
		void CLHelp(std::string[]);
		void Main(int, std::string[], std::string);	
		void WriteMinPCD(void);	
		void createSubGPC(std::vector<int>, pcl::PointCloud<pcl::PointXYZ>::Ptr &, pcl::PointCloud<pcl::PointXYZ>::Ptr &);
		void findMinPoint(pcl::PointCloud<pcl::PointXYZ>::Ptr &, pcl::PointXYZ &);
};

#endif