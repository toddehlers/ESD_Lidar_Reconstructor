//start 
//
#ifndef _CREATEMAXPCD_H
#define _CREATEMAXPCD_H

class esdCreateMaxPCD
{
	private:
		std::string inputGPCName, outputGPCMaxName;

		pcl::PointCloud<pcl::PointXYZ>::Ptr inputGPC; 
		pcl::PointCloud<pcl::PointXYZ>::Ptr outputMaxGPC;

		float kerRadius; // moving kernel radius 

	protected:

	public:
		esdCreateMaxPCD();
		~esdCreateMaxPCD();
		void CLHelp(std::string[]);
		void Main(int, std::string[], std::string);	
		void WriteMaxPCD(void);	
		void createSubGPC(std::vector<int>, pcl::PointCloud<pcl::PointXYZ>::Ptr &, pcl::PointCloud<pcl::PointXYZ>::Ptr &);
		void findMaxPoint(pcl::PointCloud<pcl::PointXYZ>::Ptr &, pcl::PointXYZ &);
};

#endif